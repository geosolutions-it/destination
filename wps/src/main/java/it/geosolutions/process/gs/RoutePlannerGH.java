package it.geosolutions.process.gs;

import it.geosolutions.destination.utils.FormulaUtils;
import it.geosolutions.graphhopper.DestinationEncodingManager;
import it.geosolutions.graphhopper.DestinationGraphHopper;
import it.geosolutions.graphhopper.FormulaWeighting;
import it.geosolutions.graphhopper.WeightType;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.logging.Logger;

import javax.sql.DataSource;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geoserver.config.GeoServerDataDirectory;
import org.geotools.data.DataStoreFinder;
import org.geotools.data.collection.ListFeatureCollection;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.feature.NameImpl;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.geometry.jts.JTS;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.process.ProcessException;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.referencing.CRS;
import org.geotools.referencing.crs.DefaultGeographicCRS;
import org.geotools.util.logging.Logging;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.opengis.referencing.operation.MathTransform;

import com.graphhopper.GHRequest;
import com.graphhopper.GHResponse;
import com.graphhopper.GraphHopper;
import com.graphhopper.util.PointList;
import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.LineString;
import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.io.WKTReader;

@DescribeProcess(title = "RoutePlanner", description = "Dynamically calculates minimal risk routes.")
public class RoutePlannerGH extends RiskCalculatorBase {

    private static final Logger LOGGER = Logging.getLogger(RoutePlannerGH.class);
    
    private File graphHopperBase;
    
    public RoutePlannerGH(Catalog catalog, GeoServerDataDirectory dataDirectory) {
        super(catalog);
        graphHopperBase = new File(dataDirectory.root(), "/graphhopper");
        if (!graphHopperBase.exists()) {
            graphHopperBase.mkdir();
        }
    }

    @DescribeResult(description = "Route planner")
    public SimpleFeatureCollection execute(
            @DescribeParameter(name = "features", description = "Input feature collection") SimpleFeatureCollection features,
            @DescribeParameter(name = "store", description = "risk data store name", min = 0) String storeName,
            @DescribeParameter(name = "start", description ="coordinates of starting point", min=1, max=1) String startCoords,
            @DescribeParameter(name = "end", description ="coordinates of end point", min=1, max=1) String endCoords,
            @DescribeParameter(name = "precision", description = "output value precision (decimals)", min = 0) Integer precision,
            @DescribeParameter(name = "connection", description = "risk database connection params", min = 0) String connectionParams,
            @DescribeParameter(name = "processing", description = "id of the processing type") int processing,
            @DescribeParameter(name = "formula", description = "id of the formula to calculate") int formula,
            @DescribeParameter(name = "target", description = "id of the target/s to use in calculation") int target,
            @DescribeParameter(name = "materials", description = "ids of the materials to use in calculation") String materials,
            @DescribeParameter(name = "scenarios", description = "ids of the scenarios to use in calculation") String scenarios,
            @DescribeParameter(name = "entities", description = "ids of the entities to use in calculation") String entities,
            @DescribeParameter(name = "severeness", description = "ids of the severeness to use in calculation") String severeness,
            @DescribeParameter(name = "fp", description = "fields to use for fp calculation", min = 0) String fpfield,
            @DescribeParameter(name = "crs", description ="EPSG code of the crs to use for damage calculation", min=0) String crs,
            @DescribeParameter(name = "level", description ="optional aggregation level", min=0) Integer level
    
    ) throws IOException, SQLException {
        // building DataStore connection using Catalog/storeName or connection input
        // parameters
        JDBCDataStore dataStore = null;
        if (catalog != null && storeName != null) {
            LOGGER.fine("Loading DataStore " + storeName + " from Catalog");
            DataStoreInfo dataStoreInfo = catalog.getDataStoreByName(storeName);
            if (dataStoreInfo == null) {
                LOGGER.severe("DataStore not found");
                throw new IOException("DataStore not found: " + storeName);
            }
            dataStore = (JDBCDataStore) dataStoreInfo.getDataStore(null);
        } else if (connectionParams != null) {
            dataStore = (JDBCDataStore) DataStoreFinder
                    .getDataStore(getConnectionParameters(connectionParams));
        } else {
            throw new IOException(
                    "DataStore connection not configured, either catalog, storeName or connectionParams are not available");
        }
    
        if (features == null) {
            throw new ProcessException("Missing input feature");
        }

        GeometryFactory geomFactory = new GeometryFactory();
        
        String[] startCoordsArray = startCoords.split(",");
        Point startPoint = geomFactory.createPoint(checkAndReturnCoords(startCoordsArray));
        
        String[] endCoordsArray = endCoords.split(",");
        Point endPoint = geomFactory.createPoint(checkAndReturnCoords(endCoordsArray));
        
        return calculateRoute(features, dataStore, startPoint, endPoint, formula, target, materials,
                scenarios, entities, severeness, fpfield, level);
    }

    private Coordinate checkAndReturnCoords(String[] coordsArray) {
        if (coordsArray != null && coordsArray.length >= 2) {
            double[] doubleCoords = new double[coordsArray.length];
            for (int i=0; i<coordsArray.length; i++) {
                try {
                    doubleCoords[i] = Double.valueOf(coordsArray[i]);
                } catch (NumberFormatException e) {
                    // ignore
                }
            }
            return new Coordinate(doubleCoords[0], doubleCoords[1]);
        }
        
        throw new ProcessException("Invalid coordinates: " + coordsArray);
    }

    private SimpleFeatureCollection calculateRoute(SimpleFeatureCollection features,
            JDBCDataStore dataStore, Point startPoint, Point endPoint, int formula, int target,
            String materials, String scenarios, String entities, String severeness, String fpfield,
            Integer level) throws IOException, SQLException {
        // feature level (1, 2, 3)
        if(level == null) {
            level = FormulaUtils.getLevel(features);
        }
        
        LOGGER.fine("Doing route calculation with the following parameters: Processing=1" +
                ",Formula=" + formula + ",Target=" + target + ",Substances=" + materials + ",Scenarios=" +
                scenarios + ",Entities=" + entities + ",Level=" + level);
        
        Map<String, Object> formulaParams = buildFormulaParams(formula, target, materials,
                scenarios, entities, severeness, fpfield,  level);
        // weight is dynamically calculated using the user-specified formula params
        WeightType weightType = WeightType.DYNAMIC;
        DataSource ds = dataStore.getDataSource();
        
        GraphHopper hopper = loadGraph(ds, weightType, formulaParams);
        GHResponse rsp = requestRoute(hopper, startPoint, endPoint, FormulaWeighting.NAME);
        
        if (rsp.hasErrors()) {
            Throwable cause = rsp.getErrors().get(0);
            throw new IOException("Failed to calculate route", cause);
        }
        
        double distance = rsp.getDistance();
        long time = rsp.getMillis();
        double weight = rsp.getRouteWeight();
        // build route geometry
        LineString routeGeom = buildRouteGeometry(rsp.getPoints(), features.getSchema()
                .getCoordinateReferenceSystem());
        
        // output FeatureType (route)
        // - weight (double, risk units)
        // - distance (double, meters)
        // - time (long, milliseconds)
        // - geometria (LineString)
        SimpleFeatureType routeFT = buildRouteFeatureType(features.getSchema());
        // build feature and add it to feature collection to be returned
        SimpleFeature routeFeature = buildRouteFeature(routeFT, weight, distance, time, routeGeom);
        ListFeatureCollection result = new ListFeatureCollection(routeFT);
        result.add(routeFeature);
        
        return result;
    }
    
    private Map<String, Object> buildFormulaParams(int formula, int target, String materials,
            String scenarios, String entities, String severeness, String fpfield, Integer level) {
        Map<String, Object> formulaParams = new HashMap<String, Object>();
        formulaParams.put(FormulaWeighting.PARAM_FORMULA_ID, formula);
        formulaParams.put(FormulaWeighting.PARAM_TARGET, target);
        formulaParams.put(FormulaWeighting.PARAM_FIELD, "rischio1");
        formulaParams.put(FormulaWeighting.PARAM_MATERIALS, materials);
        formulaParams.put(FormulaWeighting.PARAM_SCENARIOS, scenarios);
        formulaParams.put(FormulaWeighting.PARAM_ENTITIES, entities);
        formulaParams.put(FormulaWeighting.PARAM_SEVERENESS, severeness);
        formulaParams.put(FormulaWeighting.PARAM_FPFIELD, fpfield);
        formulaParams.put(FormulaWeighting.PARAM_LEVEL, level);

        return formulaParams;
    }
    
    private GraphHopper loadGraph(DataSource ds, WeightType weightType, Map<String, Object> formulaParams) {
        File graphStorageDir = createGraphStorageDir(weightType);
        
        GraphHopper hopper = new DestinationGraphHopper(ds, weightType, formulaParams);
        hopper.forServer();
        hopper.setOSMFile("fake.osm");
        hopper.setGraphHopperLocation(graphStorageDir.getAbsolutePath());
        hopper.setEncodingManager(DestinationEncodingManager.createDefault());
        hopper.setCHEnable(false);
        
        hopper.importOrLoad();
        
        return hopper;
    }
    private File createGraphStorageDir(WeightType weightType) {
        // save graph for later re-use
        File graphDir = new File(graphHopperBase, "gh-" + weightType);
        if (!graphDir.exists()) {
            graphDir.mkdir();
        }
        
        return graphDir;
    }
    
    private GHResponse requestRoute(GraphHopper hopper, Point startPoint, Point endPoint, String weighting) {
        final Double lonFrom = startPoint.getX();
        final Double lonTo = endPoint.getX();
        final Double latFrom = startPoint.getY();
        final Double latTo = endPoint.getY();
        GHRequest req = new GHRequest(latFrom, lonFrom, latTo, lonTo).
                setWeighting(weighting).
                setVehicle(weighting).
                setLocale(Locale.US);
        
        return hopper.route(req);
    }
    
    
    private SimpleFeatureType buildRouteFeatureType(SimpleFeatureType sourceSchema) {
        SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
        tb.add("weight", Double.class);
        tb.add("distance", Double.class);
        tb.add("time", Long.class);
        // returned geometries should be in the same CRS as input ones
        CoordinateReferenceSystem targetCRS = sourceSchema.getGeometryDescriptor()
                .getCoordinateReferenceSystem();
        tb.add("geometria", LineString.class, targetCRS);

        // fake layer name (risk) used for WPS output. Layer "risk" must be
        // defined in GeoServer catalog
        tb.setName(new NameImpl(sourceSchema.getName().getNamespaceURI(), "risk"));
        
        return tb.buildFeatureType();
    }
    
    private LineString buildRouteGeometry(PointList points, CoordinateReferenceSystem targetCRS) throws IOException {
        LineString routeGeom = null;
        StringBuilder wktBuilder = new StringBuilder();
        wktBuilder.append("LINESTRING(");
        for (int i=0; i<points.getSize(); i++) {
            wktBuilder.append(points.getLon(i)).append(" ").append(points.getLat(i));
            if (i<points.getSize()-1) {
                wktBuilder.append(",");
            }
        }
        wktBuilder.append(")");
        try {
            routeGeom = (LineString) new WKTReader().read(wktBuilder.toString());
            // transform geometry
            MathTransform coordsTransform = CRS.findMathTransform(DefaultGeographicCRS.WGS84, targetCRS);
            routeGeom = (LineString) JTS.transform(routeGeom, coordsTransform);
            
            return routeGeom;
        } catch (Exception e) {
            throw new IOException("Error processing route geometry", e);
        }
    }
    
    private SimpleFeature buildRouteFeature(SimpleFeatureType routeFT, double weight,
            double distance, long time, LineString geometry) {
        SimpleFeatureBuilder fb = new SimpleFeatureBuilder(routeFT);
        fb.set("weight", weight);
        fb.set("distance", distance);
        fb.set("time", time);
        fb.set("geometria", geometry);

        return fb.buildFeature(null);
    }

}

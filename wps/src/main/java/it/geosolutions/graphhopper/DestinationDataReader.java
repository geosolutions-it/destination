package it.geosolutions.graphhopper;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.sql.DataSource;

import org.geotools.util.logging.Logging;

import com.graphhopper.reader.DataReader;
import com.graphhopper.routing.util.EncodingManager;
import com.graphhopper.routing.util.FlagEncoder;
import com.graphhopper.storage.GraphStorage;
import com.graphhopper.util.EdgeIteratorState;
import com.graphhopper.util.PointList;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.LineString;
import com.vividsolutions.jts.geom.MultiLineString;
import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;

public class DestinationDataReader implements DataReader {

    private static final Logger LOGGER = Logging.getLogger(DestinationDataReader.class);
    
    private DataSource dataSource;
    private GraphStorage graphStorage;
    private WeightType weightType;
    
    private Map<Integer, double[]> dbIdToNodeCoords;
    private Map<Integer, Integer> dbIdToGraphId;

    public DestinationDataReader(GraphStorage graphStorage, DataSource dataSource, WeightType weightType) {
        this.graphStorage = graphStorage;
        this.dataSource = dataSource;
        this.weightType = weightType;
        
        dbIdToNodeCoords = new HashMap<Integer, double[]>();
        dbIdToGraphId = new HashMap<Integer, Integer>();
    }

    @Override
    public void readGraph() throws IOException {
        resetState();
        graphStorage.create(100);
        
        try {
            fetchNodes();
            fetchEdges();
        } catch (SQLException e) {
            throw new IOException(e);
        }
    }
    
    private void resetState() {
        dbIdToNodeCoords.clear();
        dbIdToGraphId.clear();;
    }

    void fetchNodes() throws SQLException {
        String sql = "(WITH edges AS ( "
        //+ "     SELECT source, target, ST_LineMerge(ST_Transform(geometria, 4326)) as geom_line FROM siig_geo_ln_arco_1 "
        + "     SELECT source, target, ST_GeometryN(ST_Transform(geometria, 4326), 1) as geom_line_start, ST_GeometryN(ST_Transform(geometria, 4326), ST_NumGeometries(geometria)) as geom_line_end FROM siig_geo_ln_arco_1 "
        + "), "
        + "src_trg_coords AS ( "
        //+ "     SELECT source, ST_X(ST_StartPoint(geom_line)) AS src_x, ST_Y(ST_StartPoint(geom_line)) AS src_y, target, ST_X(ST_EndPoint(geom_line)) AS trg_x, ST_Y(ST_EndPoint(geom_line)) AS trg_y FROM edges "
        + "     SELECT source, ST_X(ST_StartPoint(geom_line_start)) AS src_x, ST_Y(ST_StartPoint(geom_line_start)) AS src_y, target, ST_X(ST_EndPoint(geom_line_end)) AS trg_x, ST_Y(ST_EndPoint(geom_line_end)) AS trg_y FROM edges "
        + ") "
        + "SELECT source AS node_id, src_x AS x, src_y AS y FROM src_trg_coords) "
        + "UNION "
        + "(WITH edges AS ( "
        //+ "     SELECT source, target, ST_LineMerge(ST_Transform(geometria, 4326)) as geom_line FROM siig_geo_ln_arco_1 "
        + "     SELECT source, target, ST_GeometryN(ST_Transform(geometria, 4326), 1) as geom_line_start, ST_GeometryN(ST_Transform(geometria, 4326), ST_NumGeometries(geometria)) as geom_line_end FROM siig_geo_ln_arco_1 "
        + "), "
        + "src_trg_coords AS ( "
        //+ "     SELECT source, ST_X(ST_StartPoint(geom_line)) AS src_x, ST_Y(ST_StartPoint(geom_line)) AS src_y, target, ST_X(ST_EndPoint(geom_line)) AS trg_x, ST_Y(ST_EndPoint(geom_line)) AS trg_y FROM edges "
        + "     SELECT source, ST_X(ST_StartPoint(geom_line_start)) AS src_x, ST_Y(ST_StartPoint(geom_line_start)) AS src_y, target, ST_X(ST_EndPoint(geom_line_end)) AS trg_x, ST_Y(ST_EndPoint(geom_line_end)) AS trg_y FROM edges "
        + ") "
        + "SELECT target AS node_id, trg_x AS x, trg_y AS y FROM src_trg_coords ORDER BY node_id ASC)";
        
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet result = null;
        try {
            conn = dataSource.getConnection();
            
            st = conn.prepareStatement(sql);
            
            result = st.executeQuery();
            
            processNodes(result);
        } finally {
            if (result != null) {
                result.close();
            }
            if (st != null) {
                st.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    void processNodes(ResultSet rs) throws SQLException {
        final double TOLERANCE = 1E-04; // in degrees
        
        int nodeCounter = 0;
        while (rs.next()) {
            Integer nodeDbId = rs.getInt("node_id");
            Double lon = rs.getDouble("x");
            Double lat = rs.getDouble("y");
            
            if (dbIdToNodeCoords.containsKey(nodeDbId)) {
                // node has been already added: check coordinates
                double[] coords = dbIdToNodeCoords.get(nodeDbId);
                if (coords[0] - lon > TOLERANCE || coords[1] -lat > TOLERANCE) {
                    throw new SQLException("Found irreconcilable coords for node: " + nodeDbId);
                }
            } else {
                int nodeGraphId = nodeCounter++;
                dbIdToNodeCoords.put(nodeDbId, new double[] { lon, lat });
                dbIdToGraphId.put(nodeDbId, nodeGraphId);
                
                graphStorage.getNodeAccess().setNode(nodeGraphId, lat, lon);
            }
        }
    }
    
    void fetchEdges() throws SQLException {
        String sql = "SELECT "
                + "             l.id_geo_arco, l.source, l.target, l.lunghezza, "
                + "             l.nr_incidenti_elab, e.calc_formula_soc, e.calc_formula_amb, "
                + "             ST_AsText(ST_LineMerge(ST_Transform(l.geometria, 4326))) as geom_line "
                + "     FROM siig_geo_ln_arco_1 l, siig_t_elab_standard_1 e "
                + "     WHERE l.id_geo_arco = e.id_geo_arco "
                + "     ORDER BY id_geo_arco ASC";
        
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet result = null;
        try {
            conn = dataSource.getConnection();
            
            st = conn.prepareStatement(sql);
            
            result = st.executeQuery();
            
            processEdges(result);
        } finally {
            if (result != null) {
                result.close();
            }
            if (st != null) {
                st.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    void processEdges(ResultSet rs) throws SQLException {
        while (rs.next()) {
            Integer dbEdgeId = rs.getInt("id_geo_arco");
            Integer sourceDbId = rs.getInt("source");
            Integer targetDbId = rs.getInt("target");
            Integer length = rs.getInt("lunghezza");
            double nrIncidentiElab = rs.getDouble("nr_incidenti_elab");
            double rischioSoc = rs.getDouble("calc_formula_soc");
            double rischioAmb = rs.getDouble("calc_formula_amb");
            List<Point> points = new ArrayList<Point>();
            PointList pillarNodes = null;
            try {
                String lineWkt = rs.getString("geom_line");
                Geometry lineGeom = new WKTReader().read(lineWkt);
                MultiLineString multiLine = null;
                if (lineGeom instanceof MultiLineString) {
                    multiLine = (MultiLineString) lineGeom;
                } else if (lineGeom instanceof LineString) {
                    LineString[] lsArray = new LineString[] { (LineString) lineGeom };
                    multiLine = new MultiLineString(lsArray, lineGeom.getFactory());
                }
                if (multiLine != null) {
                    for (int j=0; j<multiLine.getNumGeometries(); j++) {
                        LineString line = (LineString) multiLine.getGeometryN(j);
                        for (int i=0; i<line.getNumPoints(); i++) {
                            points.add(line.getPointN(i));
                        }
                    }
                    // remove first and last point
                    points.remove(0);
                    points.remove(points.size()-1);
                    if (points.size() > 0) {
                        pillarNodes = new PointList(points.size(), false);
                        for (Point ithPoint: points) {
                            pillarNodes.add(ithPoint.getY(), ithPoint.getX());
                        }
                    }
                }
            } catch (ParseException e) {
                LOGGER.log(Level.FINE, "Failed parsing geometry for arc " + dbEdgeId, e);
            }
            
            Integer sourceGraphId = dbIdToGraphId.get(sourceDbId);
            Integer targetGraphId = dbIdToGraphId.get(targetDbId);
            if (sourceGraphId == null || targetGraphId == null) {
                throw new IllegalStateException("Cannot create edge: missing source or target node");
            }
            
            EncodingManager em = graphStorage.getEncodingManager();
            long flags = em.flagsDefault(true, true);
            
            FlagEncoder encoder = null;
            switch (weightType) {
                case RISK_SOC:
                    encoder = em.getEncoder(DestinationEncodingManager.PRECALC_RISK);
                    flags = encoder.setDouble(flags, PrecalculatedRiskWeighting.RISK, rischioSoc);
                    break;
                case RISK_ENV:
                    encoder = em.getEncoder(DestinationEncodingManager.PRECALC_RISK);
                    flags = encoder.setDouble(flags, PrecalculatedRiskWeighting.RISK, rischioAmb);
                    break;
                case NUM_ACC:
                    encoder = em.getEncoder(DestinationEncodingManager.PRECALC_RISK);
                    flags = encoder.setDouble(flags, PrecalculatedRiskWeighting.RISK, nrIncidentiElab);
                    break;
                case FORMULA:
                    encoder = em.getEncoder(DestinationEncodingManager.FORMULA);
                    flags = encoder.setLong(flags, FormulaWeighting.EDGE_ID, dbEdgeId);
                    break;
                default:
                    break;
            }
            
            EdgeIteratorState newEdge = graphStorage.edge(sourceGraphId, targetGraphId)
                    .setDistance(length).setFlags(flags);
            if (pillarNodes != null) {
                newEdge.setWayGeometry(pillarNodes);
            }
        }
    }
}

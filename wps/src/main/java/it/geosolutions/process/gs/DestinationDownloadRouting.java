/*
 *    GeoTools - The Open Source Java GIS Toolkit
 *    http://geotools.org
 *
 *    (C) 2002-2011, Open Source Geospatial Foundation (OSGeo)
 *
 *    This library is free software; you can redistribute it and/or
 *    modify it under the terms of the GNU Lesser General Public
 *    License as published by the Free Software Foundation;
 *    version 2.1 of the License.
 *
 *    This library is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *    Lesser General Public License for more details.
 */
package it.geosolutions.process.gs;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.util.Collections;
import java.util.UUID;
import java.util.logging.Logger;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geoserver.config.GeoServerDataDirectory;
import org.geoserver.wfs.response.ShapeZipOutputFormat;
import org.geotools.data.DataStoreFinder;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.process.ProcessException;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.util.logging.Logging;

import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.io.WKTReader;

/**
 * 
 * WPS Process for risk analysis results download.
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "DestinationDownloadRouting", description = "Dynamically downloads routing")
public class DestinationDownloadRouting extends RiskCalculatorBase {
	
	private static final Logger LOGGER = Logging.getLogger(DestinationDownloadRouting.class);
	private static final WKTReader wktReader = new WKTReader();	
	
	String downloadFolder;
	RoutePlannerGH router;
	
	
	/**
	 * @param catalog
	 */
	public DestinationDownloadRouting(Catalog catalog, GeoServerDataDirectory dataDirectory) {
		super(catalog);
		router = new RoutePlannerGH(catalog, dataDirectory);
		downloadFolder = dataDirectory.root()
				.getAbsolutePath()
				+ File.separator
				+ "www"
				+ File.separator
				+ "downloads";
	}
	
	@DescribeResult(description = "Download Routing Result")
	public String execute(
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
	            @DescribeParameter(name = "level", description ="optional aggregation level", min=0) Integer level,
	            @DescribeParameter(name = "blocked", description ="optional ids of blocked edges", min=0) String blockedIds 

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
	        Point startPoint = geomFactory.createPoint(router.checkAndReturnCoords(startCoordsArray));
	        
	        String[] endCoordsArray = endCoords.split(",");
	        Point endPoint = geomFactory.createPoint(router.checkAndReturnCoords(endCoordsArray));
	        
	        SimpleFeatureCollection routing = router.calculateRoute(features, dataStore, startPoint, endPoint, formula, target, materials,
	                scenarios, entities, severeness, fpfield, level, blockedIds);
	        
	        String finalZipName = createUniqueFileName() + ".zip";
               
                
                return writeToShapeFile(finalZipName, routing);
			
			
	}
	
	/**
         * @return
         */
        private String createUniqueFileName() {
                return UUID.randomUUID().toString();
        }
        
        /**
         * @param riskShapeFileName
         * @param fc
         * @param of
         * @return
         * @throws FileNotFoundException
         * @throws IOException
         */
        private String writeToShapeFile(String riskShapeFileName,
                        SimpleFeatureCollection fc)
                        throws FileNotFoundException, IOException {
                ShapeZipOutputFormat of = new ShapeZipOutputFormat(null, catalog, null);
                FileOutputStream os = null;
                try {                   
                        os = new FileOutputStream(downloadFolder + File.separator + riskShapeFileName);
                of.write(Collections.singletonList(fc), Charset.forName("ISO-8859-1"), os, null);
                return riskShapeFileName;
                } finally {
                        if(os != null) {
                                os.close();
                        }
                }
                
        }
	
}

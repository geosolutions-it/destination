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
package it.geosolutions.geobatch.destination.action;

import it.geosolutions.geobatch.destination.ingestion.ArcsIngestionProcess;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.streetuser.StreetUserComputation;
import it.geosolutions.geobatch.destination.vulnerability.RiskComputation;
import it.geosolutions.geobatch.destination.vulnerability.TargetManager.TargetInfo;
import it.geosolutions.geobatch.destination.vulnerability.VulnerabilityComputation;
import it.geosolutions.geobatch.destination.vulnerability.VulnerabilityEnvironment;
import it.geosolutions.geobatch.destination.vulnerability.VulnerabilityUtils;
import it.geosolutions.geobatch.destination.zeroremoval.ZeroRemovalComputation;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.awt.image.RenderedImage;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import javax.media.jai.JAI;
import javax.media.jai.PlanarImage;

import org.geotools.data.DataStoreFinder;
import org.geotools.filter.function.RangedClassifier;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.resources.image.ImageUtilities;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 * 
 */
public class RoadRunner {

    private static final Logger LOGGER = LoggerFactory.getLogger(RoadRunner.class);

    public static void main(String[] args) {
        Map<String, Serializable> datastoreParams = new HashMap<String, Serializable>();
        datastoreParams.put("port", 5432);
        datastoreParams.put("schema", "siig_p");
        datastoreParams.put("passwd", "siig_p");
        datastoreParams.put("dbtype", "postgis");
        datastoreParams.put("host", "localhost");
        datastoreParams.put("Expose primary keys", "true");
        datastoreParams.put("user", "siig_p");
        datastoreParams.put("database", "destination_staging");

        JDBCDataStore dataStore = null;
        MetadataIngestionHandler metadataHandler = null;
        try {

            // String inputFeature = "RL_C_Grafo_20131126";
            // String inputFeature = "RP_C_Grafo_20131212";
            // String inputFeature = "TI_C_Grafo_20140124";
            // String inputFeature = "BZ_C_Grafo_20131125";

            String inputFeature = "AO_C_Grafo_20140108";

            dataStore = (JDBCDataStore) DataStoreFinder.getDataStore(datastoreParams);
            metadataHandler = new MetadataIngestionHandler(dataStore);
            /*
             * OriginalArcsIngestionProcess arcIngestion = new OriginalArcsIngestionProcess(inputFeature, new ProgressListenerForwarder(null),
             * metadataHandler, dataStore, -1, -1); arcIngestion.importArcs(null, false);
             */
            ArcsIngestionProcess arcIngestion = new ArcsIngestionProcess(inputFeature,
                    new ProgressListenerForwarder(null), metadataHandler, dataStore);

            /*
             * arcIngestion.updateArcs(null, 2, false, false, false, null); arcIngestion.updateArcs(null, 3, false, false, false, null);
             * arcIngestion.updateArcs(null, 3, true, false, false, null);
             */

            /*
             * arcIngestion.importArcs(null, 1, false, false, true, null); arcIngestion.importArcs(null, 2, false, false, false, null);
             * arcIngestion.importArcs(null, 3, false, false, false, null); arcIngestion.importArcs(null, 3, true, false, false, "A");
             */

            // Spalmatore
            ZeroRemovalComputation zeroComputation = new ZeroRemovalComputation(inputFeature,
                    new ProgressListenerForwarder(null), metadataHandler, dataStore);

            // zeroComputation.removeZeros(null, 1, null);
            // zeroComputation.removeZeros(null, 2, null);
            // zeroComputation.removeZeros(null, 3, null);

            JAI.getDefaultInstance().getTileCache().setMemoryCapacity(1024 * 1024 * 512);

            // Vulnerability variables initialization
            VulnerabilityComputation vulnerability1 = new VulnerabilityComputation(inputFeature,
                    new ProgressListenerForwarder(null), metadataHandler, dataStore);

            Map<Integer, TargetInfo> bandPerTargetH = new TreeMap<Integer, TargetInfo>();
            Map<Integer, TargetInfo> bandPerTargetNH = new TreeMap<Integer, TargetInfo>(); // Calculation of the input Rasters
            RenderedImage[] images = vulnerability1.rasterCalculation(bandPerTargetH,
                    bandPerTargetNH);

            int threadMaxNumber = 4;
            int numBlocksPerAxis = 2;

            RangedClassifier groups = VulnerabilityUtils.computeIntervals(vulnerability1,
                    threadMaxNumber, null, false);

            // Launch of multiple vulnerability computation inside threads
            String writeMode = "UPDATE";

            VulnerabilityEnvironment env = new VulnerabilityEnvironment(
                    new ProgressListenerForwarder(null));

            // Level 1
            env.computeLevel12(null, numBlocksPerAxis, numBlocksPerAxis, inputFeature, dataStore,
                    metadataHandler, images, bandPerTargetNH, bandPerTargetH, writeMode, 1, false,
                    null, null, null, null, null, null);
            // Level 2
            env.computeLevel12(null, numBlocksPerAxis, numBlocksPerAxis, inputFeature, dataStore,
                    metadataHandler, images, bandPerTargetNH, bandPerTargetH, writeMode, 2, false,
                    null, null, null, null, null, null);
            // Level 3
            env.computeLevel3(null, threadMaxNumber, groups, inputFeature, dataStore,
                    metadataHandler, images, bandPerTargetNH, bandPerTargetH, writeMode, false,
                    null);

            // Image Disposal
            ImageUtilities.disposePlanarImageChain(PlanarImage.wrapRenderedImage(images[0]));
            // Image Disposal
            ImageUtilities.disposePlanarImageChain(PlanarImage.wrapRenderedImage(images[1]));

            RiskComputation riskComputation = new RiskComputation(inputFeature,
                    new ProgressListenerForwarder(null), metadataHandler, dataStore);

            // riskComputation.prefetchRiskAtLevel(15, 1, 1, 26, 100, "1,2,3,4,5,6,7,8,9,10,11,12", "1,2,3,4,5,6,7,8,9,10,11,12,13,14", "0,1",
            // "1,2,3,4,5", "fp_scen_centrale", "PURGE_INSERT", null, false);
            // riskComputation.prefetchRiskAtLevel(15, 2, 1, 26, 100, "1,2,3,4,5,6,7,8,9,10,11,12", "1,2,3,4,5,6,7,8,9,10,11,12,13,14", "0,1",
            // "1,2,3,4,5", "fp_scen_centrale", "PURGE_INSERT", null, false);
            // riskComputation.prefetchRiskAtLevel(15, 3, 1, 29, 100, "1,2,3,4,5,6,7,8,9,10,11,12", "1,2,3,4,5,6,7,8,9,10,11,12,13,14", "0,1",
            // "1,2,3,4,5", "fp_scen_centrale", "PURGE_INSERT", "B", false);

            StreetUserComputation streetUserComputation = new StreetUserComputation(inputFeature,
                    new ProgressListenerForwarder(null), metadataHandler, dataStore);
            // streetUserComputation.setStartOriginId(832268);
            streetUserComputation.setRemoveFeatures(false);
            streetUserComputation.setSorted(true);
            // streetUserComputation.execute(1, false, null);
            streetUserComputation.execute(2, false, null);
            streetUserComputation.execute(3, false, null);
        } catch (Exception e) {
            LOGGER.error(e.getMessage());
        } finally {
            if (metadataHandler != null) {
                metadataHandler.dispose();
            }

            if (dataStore != null) {
                dataStore.dispose();
            }
        }

    }
}

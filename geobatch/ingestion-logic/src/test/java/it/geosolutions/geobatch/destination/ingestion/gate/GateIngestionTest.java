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
package it.geosolutions.geobatch.destination.ingestion.gate;

import it.geosolutions.geobatch.destination.TestMetadataIngestionHandler;
import it.geosolutions.geobatch.destination.common.utils.TimeUtils;
import it.geosolutions.geobatch.destination.ingestion.GateIngestionProcess;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.ingestion.gate.dao.TransitDao;
import it.geosolutions.geobatch.destination.ingestion.gate.dao.impl.TransitDaoJDBCImpl;
import it.geosolutions.geobatch.destination.ingestion.gate.dao.impl.TransitDaoMemoryImpl;
import it.geosolutions.geobatch.destination.ingestion.gate.model.ExportData;
import it.geosolutions.geobatch.destination.ingestion.gate.model.Transit;
import it.geosolutions.geobatch.destination.ingestion.gate.model.TransitBeanTest;
import it.geosolutions.geobatch.destination.ingestion.gate.model.Transits;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.xml.bind.JAXB;

import org.apache.commons.io.FileUtils;
import org.geotools.data.DataStore;
import org.geotools.data.DataStoreFinder;
import org.geotools.data.memory.MemoryDataStore;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.jdbc.JDBCDataStoreFactory;
import org.geotools.test.OnlineTestCase;
import org.joda.time.DateTime;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Gate ingestion test:
 * <ol>
 * <li>Insert a gate for testing proposal</li>
 * <li>Generate a xml test file with {@link GateIngestionTest#numberOrTransits} transits</li>
 * <li>Execute a {@link GateIngestionProcess} with the xml file</li>
 * <li>Check if data it's correctly inserted</li>
 * <li> Remove test data</li>
 * </ol>
 * 
 * @author adiaz
 */
public class GateIngestionTest extends OnlineTestCase {

private final static Logger LOGGER = LoggerFactory
        .getLogger(GateIngestionTest.class);

/**
 * Separator
 */
public static final String SEPARATOR = System.getProperty("file.separator");

/**
 * JDBC connection
 */
protected DataStore datastore;

/**
 * Metadata ingestion handler
 */
protected MetadataIngestionHandler metadataHandler;

/**
 * Random to generate magic keys and random strings
 */
private static final Random RANDOM = new Random();

/**
 * Magic key for the id of the inserted data
 */
private Long magicKey;

/**
 * Test gate id
 */
private Long FAKE_GATE_ID;

/**
 * Description for the fake gate
 */
private String FAKE_GATE_KEY = "TEST_GATE";

/**
 * Number of transits to be inserted
 */
private Integer numberOrTransits = new Integer(50);

/**
 * DAO to store transit objects
 */
private TransitDao transitDao;

/**
 * Initialization of data store
 * 
 * @throws Exception if create fake gate throws an exception 
 */
@Before
public void init() throws Exception {
    try {
        if (datastore == null) {
            datastore = DataStoreFinder
                    .getDataStore(getPostgisParams());
            if(datastore instanceof JDBCDataStore){
                metadataHandler = new MetadataIngestionHandler(datastore);
                transitDao = new TransitDaoJDBCImpl((JDBCDataStore) datastore);
            }else{
                // if default data store is not found, use a memory datastore
                datastore = new MemoryDataStore();
                metadataHandler = new TestMetadataIngestionHandler(datastore);
                transitDao = new TransitDaoMemoryImpl((MemoryDataStore) datastore);
            }
        }
    } catch (Exception e) {
        LOGGER.info("JDBC connection is not available. We're going to test with mocked data");
        if(datastore != null){
            // TODO: close transaction
            datastore.dispose();
        }
        // if default data store fails, use a memory data store
        datastore = new MemoryDataStore();
        metadataHandler = new TestMetadataIngestionHandler(datastore);
        transitDao = new TransitDaoMemoryImpl((MemoryDataStore) datastore);
    }
    createFakeGate();
}

protected String getFixtureId() {
    return "destination";
}

/**
 * Test import gates process
 */
@Test
public void testImportGatesProcess() {

    File file;
    List<Long> ids = null;
    boolean failCleanning = false;
    try {

        // init if needed
        init();

        // Prepare process
        file = getTestFile(FAKE_GATE_ID, numberOrTransits);
        GateIngestionProcess gateIngestion = new GateIngestionProcess("",
                new ProgressListenerForwarder(null), metadataHandler,
                datastore, file);

        // process execution
        ids = gateIngestion.importGates(false);

        // Check if was inserted correctly
        checkData(ids, file);

    } catch (Exception e) {
        fail("Exception on gates ingestion");
        e.printStackTrace();
    } finally {
        // clean inserted data
        if(ids != null){
            try {
                cleanUp(ids);
            } catch (Exception e) {
                failCleanning = true;
            }
        }
        if (metadataHandler != null) {
            metadataHandler.dispose();
        }

        if (datastore != null) {
            datastore.dispose();
        }
    }
    
    if(failCleanning){
        fail("Fail on clean up");
    }
}

/**
 * @return connection parameters
 */
public Map<String, Serializable> getPostgisParams() {
    Map<String, Serializable> params = new HashMap<String, Serializable>();

    params.put(JDBCDataStoreFactory.DBTYPE.key, "postgis");
    params.put(JDBCDataStoreFactory.HOST.key, fixture.getProperty("pg_host"));
    params.put(JDBCDataStoreFactory.PORT.key, fixture.getProperty("pg_port"));
    params.put(JDBCDataStoreFactory.SCHEMA.key,
            fixture.getProperty("pg_schema"));
    params.put(JDBCDataStoreFactory.DATABASE.key,
            fixture.getProperty("pg_database"));
    params.put(JDBCDataStoreFactory.USER.key, fixture.getProperty("pg_user"));
    params.put(JDBCDataStoreFactory.PASSWD.key,
            fixture.getProperty("pg_password"));

    return params;
}

/**
 * Create a fake gate to make the test
 * @throws Exception 
 */
private void createFakeGate() throws Exception {
    // its numeric(5,0)
    FAKE_GATE_ID = new Long(RANDOM.nextInt(100000));
    // create test gate
    transitDao.createGate(FAKE_GATE_ID, FAKE_GATE_KEY);
}

/**
 * Check if the data inserted its correct
 * 
 * @param ids of the inserted data
 * @param file used to execute the process
 * @throws Exception 
 */
private void checkData(List<Long> ids, File file) throws Exception {
    // the number of inserts it's OK
    assertEquals(ids.size(), (int) numberOrTransits);
    // check one by one
    int index = 0;
    ExportData exportedData = JAXB.unmarshal(file, ExportData.class);
    for(Transit transit: exportedData.getTransits().get(0).getTransit()){
        checkData(ids.get(index++), transit);
    }
}

/**
 * Check if exists one transit with all data in the database
 * 
 * @param idTransit id of the transit in the database
 * @param transit bean with the data
 * @throws Exception 
 */
private void checkData(Long idTransit, Transit transit) throws Exception {
    assertTrue(transitDao.exists(idTransit, transit));
            
}

/**
 * Clean up the inserted data for the test
 * 
 * @param insertedTransitsIds
 * @throws Exception
 */
private void cleanUp(List<Long> insertedTransitsIds) throws Exception {
    transitDao.cleanAll(insertedTransitsIds);
    // clean fake gate
    transitDao.deleteGate(FAKE_GATE_ID);
}

/**
 * Generate a test file with the content tested on
 * {@link TransitBeanTest#TEST_XML}
 * 
 * @return
 * @throws IOException
 */
private File getTestFile(long idGate, int transitNumbers) throws IOException {
    File file = new File(FileUtils.getTempDirectory() + SEPARATOR
            + "A00_20131016-180030.xml");

    if (!file.exists())
        file.createNewFile();

    ExportData exportData = generateTestData(idGate, transitNumbers);

    JAXB.marshal(exportData, file);

    return file;
}

private ExportData generateTestData(long idGate, int transitNumber) {

    // Magic key for the id
    magicKey = RANDOM.nextLong();

    // Generate transits
    Transits transits = new Transits();

    // parameters to be generated in this function
    boolean inverse = false;
    DateTime dt = null;
    String kemler = null;
    String onu = null;

    for (int i = 0; i < transitNumber; i++) {
        if (!inverse) {
            // Generate different data each 2 transits (enter and return)
            kemler = RANDOM.nextInt(100) + "_k";
            onu = RANDOM.nextInt(100) + "_o";
        }

        // create a new transit
        Transit transit = new Transit();
        transit.setIdGate(idGate);
        transit.setIdTransito(magicKey + i);

        // Time it's different each time
        dt = new DateTime();
        transit.setDataRilevamento(dt.toString(TimeUtils.DEFAULT_FORMATTER));

        // direction
        transit.setDirezione(inverse ? "1" : "0");

        // lane (always 0)
        transit.setCorsia(0);

        // genrated
        transit.setKemlerCode(kemler);
        transit.setOnuCode(onu);

        transits.getTransit().add(transit);

        // inverse direction
        inverse = !inverse;
    }

    // Generate the export fakeData
    ExportData eD = new ExportData();
    eD.getTransits().add(transits);

    return eD;
}

}

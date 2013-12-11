/*

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
package it.geosolutions.geobatch.destination.ingestion.gate.dao.impl;

import it.geosolutions.geobatch.destination.common.utils.DbUtils;
import it.geosolutions.geobatch.destination.common.utils.SequenceManager;
import it.geosolutions.geobatch.destination.common.utils.TimeUtils;
import it.geosolutions.geobatch.destination.ingestion.gate.dao.TransitDao;
import it.geosolutions.geobatch.destination.ingestion.gate.model.Transit;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.jdbc.JDBCDataStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * JDBC connection implementation for store transit objects
 * 
 * @author adiaz
 */
public class TransitDaoJDBCImpl extends AbstractTransitDao implements TransitDao {

private final static Logger LOGGER = LoggerFactory
        .getLogger(TransitDaoJDBCImpl.class);

/**
 * Database connection for the insert
 */
private JDBCDataStore dataStore;

/**
 * Sequence manager to generate transits PKs
 */
private SequenceManager transitSequenceManager;

public TransitDaoJDBCImpl(JDBCDataStore dataStore){
    // init datastore
    this.dataStore = (JDBCDataStore) dataStore;
    transitSequenceManager = new SequenceManager(this.dataStore,
            "transit_seq");
}


/**
 * Creates a new transit in the transit table.
 * 
 * @return id of the transit
 * @throws Exception if an exception occur when try to insert
 */
public Long createTransit(Transit transit) throws Exception{

    Transaction transaction = null;
    Connection conn = null;
    try {
        transaction = new DefaultTransaction();
        conn = dataStore.getConnection(transaction);

        // ignored pk (use generated) or not
        Long id = (Boolean.TRUE.equals(ignorePks) ? transitSequenceManager
                .retrieveValue() : transit.getIdTransito());

        Timestamp timestamp = TimeUtils.getTimeStamp(transit
                .getDataRilevamento());

        // null value should throw an exception
        String arriveDate = timestamp != null ? "'" + timestamp + "'" : null;

        // sql insert into transit
        String sql = "insert into siig_gate_t_dato(" + "id_dato, "
                + "fk_gate, " + "data_rilevamento, " + "data_ricezione, "
                + "flg_corsia, " + "direzione, " + "codice_kemler, "
                + "codice_onu)" + " values(" + id + ", " + transit.getIdGate()
                + ", " + arriveDate + ", '" + TimeUtils.getTodayTimestamp()
                + "', " + transit.getCorsia() + ", '" + transit.getDirezione()
                + "', '" + transit.getKemlerCode() + "', '"
                + transit.getOnuCode() + "')";

        // trace sql
        if (LOGGER.isTraceEnabled()) {
            LOGGER.trace("SQL insert: " + sql);
        }

        DbUtils.executeSql(conn, transaction, sql, true);
        return id;
    } catch (SQLException e) {
        throw new IOException(e);
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                throw new IOException(e);
            }
        }
        if (transaction != null) {
            transaction.close();
        }
    }

}

/**
 * Check if exists one transit with all data stored
 * 
 * @param idTransit id of the transit stored
 * @param transit bean with the data
 * @throws Exception if an error occur when check the data
 */
public boolean exists(Long idTransit, Transit transit) throws Exception{

    // Date
    Timestamp timestamp = TimeUtils.getTimeStamp(transit
            .getDataRilevamento());
    String arriveDate = timestamp != null ? "'" + timestamp + "'" : null;
    
    // sql count
    String sql = "select count(*) from siig_gate_t_dato "
            + "where id_dato = " + idTransit
            + " and fk_gate = " + transit.getIdGate()
            + " and data_rilevamento = " + arriveDate
            + " and data_ricezione = " + arriveDate
            + " and flg_corsia = "  + transit.getCorsia()
            + " and direzione = '" + transit.getDirezione() + "'"
            + " and codice_kemler = '" + transit.getKemlerCode() + "'"
            + " and codice_onu = '" + transit.getOnuCode() + "'";
    
    // must return one
    long scalar = (Long) executeScalar(sql); 
    if(new Long(1).equals(scalar)){
        return true;
    }else{
        return false;
    }
}

/**
 * Clean all transit stored
 * 
 * @param transitIds
 * @throws Exception if an error occur when try to clean data
 */
public void cleanAll(List<Long> transitIds) throws Exception{

    String sql = "delete from siig_gate_t_dato where id_dato in (";
    int count = 0;
    for (Long id : transitIds) {
        count++;
        sql += id;
        if (count == transitIds.size()) {
            sql += ")";
        } else {
            sql += ",";
        }
    }

    // Execute transaction with the remove
    executeSQL(sql);
}

/**
 * Store a gate for test proposal
 * 
 * @param idGate identifier of the gate
 * @param description of the gate
 * 
 * @throws Exception if an error occur when we try to store the gate
 */
public void createGate(Long idGate, String description) throws Exception{
    // Execute transaction with the insert
    executeSQL("INSERT INTO siig_gate_geo_gate(" + "id_gate, descrizione) "
            + "VALUES (" + idGate + ", '" + description + "')");
}

/**
 * Delete a gate for testing proposal
 * 
 * @param idGate identifier of the date to be removed
 * 
 * @throws Exception if an error occur when we try to delete the gate
 */
public void deleteGate(Long idGate) throws Exception{
    // delete gate
    executeSQL("delete from siig_gate_geo_gate where id_gate = " + idGate);
}

/**
 * Execute a transaction with sql sentence
 * 
 * @param sql
 * @throws IOException if an error occur on the execution
 */
private void executeSQL(String sql) throws IOException {
    Transaction transaction = null;
    Connection conn = null;
    try {
        transaction = new DefaultTransaction();
        conn = dataStore.getConnection(transaction);
        DbUtils.executeSql(conn, transaction, sql, true);
    } catch (SQLException e) {
        throw new IOException(e);
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                throw new IOException(e);
            }
        }
        if (transaction != null) {
            transaction.close();
        }
    }
}

/**
 * Execute a transaction with sql sentence
 * 
 * @param sql
 * @throws IOException if an error occur on the execution
 */
private Object executeScalar(String sql) throws IOException {
    Transaction transaction = null;
    Object scalar = null;
    try {
        transaction = new DefaultTransaction();
        scalar = DbUtils.executeScalar(dataStore, transaction, sql);
        return scalar;
    } catch (SQLException e) {
        throw new IOException(e);
    } finally {
        if (transaction != null) {
            transaction.close();
        }
    }
}

}

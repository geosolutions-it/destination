/*
 *  Copyright (C) 2007-2012 GeoSolutions S.A.S.
 *  http://www.geo-solutions.it
 *
 *  GPLv3 + Classpath exception
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package it.geosolutions.geobatch.destination.common;

import it.geosolutions.geobatch.destination.DbUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.jdbc.JDBCDataStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author DamianoG
 * 
 */
public class SequenceManager {

    private final static Logger LOGGER = LoggerFactory.getLogger(SequenceManager.class);
    
    private Transaction transaction = null;
    private JDBCDataStore datastore = null;
    private String seqName = null;
    
    public SequenceManager(JDBCDataStore dataStore, String seqName){
        try {
            seqName = seqName.replaceAll("-", "_");
            seqName = seqName.replaceAll("\\.", "_");
            seqName = seqName.toLowerCase();
            createSequence(dataStore, seqName);
            this.transaction = new DefaultTransaction();
            this.datastore = dataStore;
            this.seqName = seqName;
        } catch (IOException e) {
            LOGGER.error(e.getMessage(), e);
        }
    }
    
    public long retrieveValue() throws IOException {

        String sql = null;
        Long id = null;
        try {
            sql = "SELECT nextval('" + this.seqName + "')";
            id = (Long)DbUtils.executeScalar(datastore, transaction, sql);
        } catch (SQLException e) {
            throw new IOException(e);
        } 
        return id;
    }
    
    public void disposeManager(){
          datastore = null;
          if (transaction != null) {
              try {
                transaction.close();
            } catch (IOException e) {
                LOGGER.error(e.getMessage(), e);
            }
          }
    }

    private boolean createSequence(JDBCDataStore dataStore, String seqName)
            throws IOException {

        String sql = null;

        Transaction transaction = null;
        Connection conn = null;

        transaction = new DefaultTransaction();
        conn = dataStore.getConnection(transaction);
        try {
            sql = "CREATE SEQUENCE " + seqName;
            DbUtils.executeSql(conn, transaction, sql, true, true);
        } catch (SQLException e) {
            if ("42P07".equals(e.getSQLState())) {
                return false;
            } else {
                throw new IOException(e);
            }
        } finally {
            if (conn != null) {
                try {
                    conn.commit();
                    conn.close();
                } catch (SQLException e) {
                    throw new IOException(e);
                }
            }
            if (transaction != null) {
                transaction.close();
            }
        }
        return true;
    }

    

    

}

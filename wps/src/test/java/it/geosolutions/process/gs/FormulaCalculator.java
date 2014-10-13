package it.geosolutions.process.gs;

import it.geosolutions.destination.utils.Formula;
import it.geosolutions.destination.utils.FormulaUtils;

import java.io.Serializable;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.geotools.data.DataStoreFinder;
import org.geotools.data.DefaultTransaction;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.jdbc.JDBCDataStore;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;

public class FormulaCalculator {
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
        DefaultTransaction t = new DefaultTransaction();
        try {
        	dataStore = (JDBCDataStore)DataStoreFinder.getDataStore(datastoreParams);
        	Connection c = dataStore.getConnection(t);
        	
        	Formula formula = Formula.load(c, 1, 26, 100);
        	
        	Map<Number, SimpleFeature> temp = new HashMap<Number, SimpleFeature>();
        	SimpleFeatureTypeBuilder builder = new SimpleFeatureTypeBuilder();
        	builder.setName("risk");
        	builder.add("rischio1", Double.class);
        	builder.add("rischio2", Double.class);
        	SimpleFeatureType schema = builder.buildFeatureType();
        	SimpleFeatureBuilder featureBuilder = new SimpleFeatureBuilder(schema);
        	featureBuilder.add(0.0);
        	featureBuilder.add(0.0);
        	
        	temp.put(28525, featureBuilder.buildFeature("28525"));
        	FormulaUtils.calculateSimulationFormulaValuesOnSingleArc(
                    c, 1, 1,
                    formula, 28525,
                    "","6", "10", 
                    "0", "1,2,3,4,5", "fp_scen_centrale",
                    6, null, temp, 15,
                    null, null, null, null,
                    null, false);
        			
        			
        } catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	t.close();
        	if(dataStore != null) {
        		dataStore.dispose();
        	}        	
        }
	}
}

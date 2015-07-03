package it.geosolutions.process.gs;

import it.geosolutions.destination.utils.Formula;
import it.geosolutions.destination.utils.FormulaUtils;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
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
        	
        	List<List<Integer>> ids = new ArrayList<List<Integer>>();
        	
        	Connection c = dataStore.getConnection(t);
        	PreparedStatement stmt = c.prepareStatement("select id_geo_arco from siig_geo_ln_arco_1 where fk_partner='2' and id_geo_arco in (60160,60161,60168,60169,60170,60171,60172,60173,60174,60175,60196,60197,60198,60199,60208,60209,60210,60211,60212,60213,60214,60215,60216,60217,60218,60219,60220,60221,60222,60223) order by id_geo_arco");
        	ResultSet rs = stmt.executeQuery();
        	List<Integer> tempIds = new ArrayList<Integer>();
        	int count = 1;
        	while(rs.next()) {
        	    tempIds.add(rs.getInt(1));
        	    if(count % 1000 == 0) {
        	        ids.add(tempIds);
        	        tempIds = new ArrayList<Integer>();
        	    }
        	    count++;
        	}
        	if(tempIds.size() > 0) {
        	    ids.add(tempIds);
        	}
        	rs.close();
        	stmt.close();
        	Formula formula = Formula.load(c, 1, 18, 99);
        	System.out.println(formula);
        	
        	Map<Number, SimpleFeature> temp = new HashMap<Number, SimpleFeature>();
        	SimpleFeatureTypeBuilder builder = new SimpleFeatureTypeBuilder();
        	builder.setName("risk");
        	builder.add("rischio1", Double.class);
        	builder.add("rischio2", Double.class);
        	SimpleFeatureType schema = builder.buildFeatureType();
        	SimpleFeatureBuilder featureBuilder = new SimpleFeatureBuilder(schema);
        	PrintWriter writer = new PrintWriter(new FileWriter("J:\\Develop\\gasolio_am2.txt"));
        	int written = 0;
        	for(List<Integer> batch : ids) {
        	    temp.clear();
        	    for(int id : batch) {
        	        featureBuilder.add(0.0);
                        featureBuilder.add(0.0);
                        temp.put(id, featureBuilder.buildFeature(id+""));
                        featureBuilder.reset();
        	    }
        	    FormulaUtils.calculateFormulaValues(c,1,1,formula,StringUtils.join(batch.iterator(), ","),"","9","0","1,2,3,4,5,6,7,8,9,10,11,12,13,14","1","5","fp_scen_centrale",99,temp,15,false);
        	    for(Number id : temp.keySet()) {
        	        SimpleFeature feature = temp.get(id);
        	        writer.println(id+","+feature.getAttribute("rischio1")+","+feature.getAttribute("rischio2"));
        	        written++;
        	    }
        	    if(written % 1000 == 0) {
        	        System.out.println(written);
        	    }
        	    writer.flush();
        	}
        	writer.close();
        	
        	
        	

        			
        			
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

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
        /*Map<String, Integer> codici = new HashMap<String, Integer>();
        codici.put("A", 1);
        codici.put("B", 2);
        codici.put("C", 3);
        codici.put("D", 4);
        codici.put("E", 5);
        codici.put("F", 6);
        codici.put("G", 7);
        codici.put("H", 8);
        codici.put("I", 9);
        codici.put("L", 10);
        codici.put("M", 11);
        codici.put("J", 12);
        codici.put("K", 13);
        codici.put("N", 14);
        String[] columnsName = new String[] {"A", "B", "C", "D", "E", "F", "G", "H", "I" ,"J", "K", "L", "M", "N"};
        
        try (BufferedReader reader = new BufferedReader(new FileReader("J:\\Develop\\destination-gs26\\nuove_sostanze\\sostanze_db (rev. GPS).txt"))) {
            String line = null;
            while((line = reader.readLine()) != null) {
                String[] columns = line.split("\t");
                int id_sostanza = Integer.parseInt(columns[0]);
                int fk_modello = Integer.parseInt(columns[3]);
                for(int col = 4; col < columns.length; col++) {
                    String scenario = columns[col].trim();
                    if(!scenario.isEmpty()) {
                        for(int flg_lieve = 0; flg_lieve <=1; flg_lieve++) {
                            String codice = columnsName[col - 4];
                            int id_scenario = codici.get(codice);
                            System.out.println("update siig_r_scenario_sostanza set psc=(select psc from siig_r_scenario_sostanza where id_sostanza="+fk_modello+" and id_scenario="+id_scenario+" and flg_lieve="+flg_lieve+") where id_sostanza="+id_sostanza + " and id_scenario=" + id_scenario +" and flg_lieve="+flg_lieve+";");
                        }
                    }
                }
            }
        } catch(IOException e) {
            e.printStackTrace();
        }*/
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
            dataStore = (JDBCDataStore) DataStoreFinder.getDataStore(datastoreParams);

            List<List<Integer>> ids = new ArrayList<List<Integer>>();

            Connection c = dataStore.getConnection(t);
            PreparedStatement stmt = c
                    .prepareStatement("select id_geo_arco from siig_geo_pl_arco_4 where fk_partner='2' order by id_geo_arco");
            ResultSet rs = stmt.executeQuery();
            List<Integer> tempIds = new ArrayList<Integer>();
            int count = 1;
            while (rs.next()) {
                tempIds.add(rs.getInt(1));
                if (count % 1000 == 0) {
                    ids.add(tempIds);
                    tempIds = new ArrayList<Integer>();
                }
                count++;
            }
            if (tempIds.size() > 0) {
                ids.add(tempIds);
            }
            rs.close();
            stmt.close();
            Formula formula = Formula.load(c, 1, 26, 98);
            System.out.println(formula);

            Map<Number, SimpleFeature> temp = new HashMap<Number, SimpleFeature>();
            SimpleFeatureTypeBuilder builder = new SimpleFeatureTypeBuilder();
            builder.setName("risk");
            builder.add("rischio1", Double.class);
            builder.add("rischio2", Double.class);
            SimpleFeatureType schema = builder.buildFeatureType();
            SimpleFeatureBuilder featureBuilder = new SimpleFeatureBuilder(schema);
            int written = 0;
            for (List<Integer> batch : ids) {
                temp.clear();
                for (int id : batch) {
                    featureBuilder.add(0.0);
                    featureBuilder.add(0.0);
                    temp.put(id, featureBuilder.buildFeature(id + ""));
                    featureBuilder.reset();
                }
                FormulaUtils.calculateFormulaValues(c, 4, 1, formula,
                        StringUtils.join(batch.iterator(), ","), "", "1,2,3,4,5,6,7,8,9,10,11,12", "1,2,3,4,5,6,7,8,9,10,11,12",
                        "1,2,3,4,5,6,7,8,9,10,11,12,13,14", "0,1", "1,2,3,4", "fp_scen_centrale", 98, temp,
                        15, false);
                for (Number id : temp.keySet()) {
                    SimpleFeature feature = temp.get(id);
                    
                }
                if (written % 1000 == 0) {
                    System.out.println(written);
                }
                
            }
            

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            t.close();
            if (dataStore != null) {
                dataStore.dispose();
            }
        }
    }
}

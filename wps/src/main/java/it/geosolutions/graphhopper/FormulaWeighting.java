package it.geosolutions.graphhopper;

import it.geosolutions.destination.utils.Formula;
import it.geosolutions.destination.utils.FormulaUtils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.sql.DataSource;

import org.geotools.util.logging.Logging;

import com.graphhopper.routing.util.FlagEncoder;
import com.graphhopper.routing.util.Weighting;
import com.graphhopper.util.EdgeIteratorState;

public class FormulaWeighting implements Weighting {

    private static final Logger LOGGER = Logging.getLogger(FormulaWeighting.class);
    
    public static final String NAME = "FORMULA";
    public static final int EDGE_ID = 102;
    
    public static final String PARAM_FORMULA_ID = "FORMULA_ID";
    public static final String PARAM_TARGET = "TARGET";
    public static final String PARAM_FIELD = "FIELD";
    public static final String PARAM_MATERIALS = "MATERIALS";
    public static final String PARAM_KEMLER = "KEMLER";
    public static final String PARAM_SCENARIOS = "SCENARIOS";
    public static final String PARAM_ENTITIES = "ENTITIES";
    public static final String PARAM_SEVERENESS = "SEVERENESS";
    public static final String PARAM_FPFIELD = "FPFIELD";
    public static final String PARAM_LEVEL = "LEVEL";
    public static final String PARAM_BLOCKED = Utils.BLOCKED_EDGE_IDS_KEY;
    
    private static final int DEFAULT_FORMULA_ID = 141;
    private static final int DEFAULT_TARGET = 100; // all targets
    private static final String DEFAULT_FIELD = "rischio1";
    private static final String DEFAULT_MATERIALS = "1,2,3,4,5,6,7,8,9,10,11,12"; // all materials
    public static final String DEFAULT_KEMLER = "0";
    private static final String DEFAULT_SCENARIOS = "1,2,3,4,5,6,7,8,9,10,11,12,13,14"; // all scenarios
    private static final String DEFAULT_ENTITIES = "0,1";
    public static final String DEFAULT_SEVERENESS = "1,2,3,4,5";
    public static final String DEFAULT_FPFIELD = "fp_scen_centrale";
    private static final int DEFAULT_LEVEL = 1;
    private static final Set<Integer> DEFAULT_BLOCKED = Collections.emptySet();
    
    private DataSource ds;
    private Map<String, Object> formulaParams;
    
    private final FlagEncoder encoder;
    private Formula formulaDescriptor;
    
    public FormulaWeighting(FlagEncoder encoder, DataSource dataSource, Map<String, Object> formulaParams) {
        this.encoder = encoder;
        this.ds = dataSource;
        this.formulaParams = formulaParams;
        if (this.formulaParams == null) {
            this.formulaParams = new HashMap<String, Object>();
        }
        loadFormulaDescriptor();
    }
    
    private void loadFormulaDescriptor() {
        int formulaId = getOrDefault(formulaParams, PARAM_FORMULA_ID, DEFAULT_FORMULA_ID);
        int target = getOrDefault(formulaParams, PARAM_TARGET, DEFAULT_TARGET);
        
        Connection conn = null;
        try {
            conn = ds.getConnection();
            this.formulaDescriptor = Formula.load(conn, 1, formulaId, target);
        } catch (SQLException e) {
            throw new RuntimeException("Could not load formula", e);
        } finally {
            closeConnection(conn);
        }
    }
    
    @Override
    public double getMinWeight(double distance) {
        return 0;
    }
    
    @Override
    public double calcWeight(EdgeIteratorState edgeState, boolean reverse, int prevOrNextEdgeId) {
        long edgeDbId = encoder.getLong(edgeState.getFlags(), EDGE_ID);
        Set<Integer> blockedEdges = getOrDefault(formulaParams, PARAM_BLOCKED, DEFAULT_BLOCKED);
        if (blockedEdges.contains(new Long(edgeDbId).intValue())) {
            return Double.POSITIVE_INFINITY;
        } else {
            String field = getOrDefault(formulaParams, PARAM_FIELD, DEFAULT_FIELD);
            String materials = getOrDefault(formulaParams, PARAM_MATERIALS, DEFAULT_MATERIALS);
            String kemler = getOrDefault(formulaParams, PARAM_KEMLER, DEFAULT_KEMLER);
            String scenarios = getOrDefault(formulaParams, PARAM_SCENARIOS, DEFAULT_SCENARIOS);
            String entities = getOrDefault(formulaParams, PARAM_ENTITIES, DEFAULT_ENTITIES);
            String severeness = getOrDefault(formulaParams, PARAM_SEVERENESS, DEFAULT_SEVERENESS);
            String fpfield = getOrDefault(formulaParams, PARAM_FPFIELD, DEFAULT_FPFIELD);
            int level = getOrDefault(formulaParams, PARAM_LEVEL, DEFAULT_LEVEL);
            
            Connection conn = null;
            try {
                conn = ds.getConnection();
                Number formulaOutput = FormulaUtils.calculateFormulaValues(conn, 
                        level,
                        1, // processing,
                        formulaDescriptor,
                        "" + edgeDbId,
                        null, // fk_partner
                        materials,
                        kemler,
                        scenarios,
                        entities,
                        severeness,
                        fpfield,
                        formulaDescriptor.getSql(),
                        field,
                        "1,2,4,5,6,7,8", // targets
                        null, // changedTargets
                        null, // features
                        4, // precision,
                        null, // cff // optional List of csv "id_bersaglo,cff" values to use on the simulation
                        null, // psc, // optional List of csv id_sostanza,psc values to use
                                          // on the simulation
                        null, // padr, // optional List of csv id_sostanza,padr values to use on the simulation
                        null, // pis, // optional List of csv id_geo_arco,pis values to use on the simulation
                        null); // damageValues)
                
                return (formulaOutput != null) ? formulaOutput.doubleValue() : null;
            } catch (SQLException e) {
                throw new RuntimeException("Formula calculation failed", e);
            } finally {
                closeConnection(conn);
            }
        }
    }

    private <T> T getOrDefault(Map<String, Object> params, String key, Object defaultValue) {
        if (params.containsKey(key)) {
            return (T) params.get(key);
        } else {
            return (T) defaultValue;
        }
    }
    
    private void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.FINER, "Failed to close connection", e);
            }
        }
    }
}

package it.geosolutions.graphhopper;

import java.util.Map;

import javax.sql.DataSource;

import com.graphhopper.routing.util.FlagEncoder;
import com.graphhopper.routing.util.Weighting;

public class WeightingFactory {

    private static WeightingFactory instance;
    
    private WeightingFactory() {
    }
    
    public static WeightingFactory getInstance() {
        if (instance == null) {
            synchronized (WeightingFactory.class) {
                if (instance == null) {
                    instance = new WeightingFactory();
                }
            }
        }
        
        return instance;
    }
    
    public Weighting create(FlagEncoder encoder, DataSource dataSource, WeightType weightType) throws Exception {
        return create(encoder, dataSource, weightType, null);
    }
    
    public Weighting create(FlagEncoder encoder, DataSource dataSource, WeightType weightType, Map<String, Object> weightParams) throws Exception {
        if (weightType == null) {
            throw new IllegalArgumentException("weightType not specified");
        }
        
        switch (weightType) {
            case RISK_SOC:
            case RISK_ENV:
            case NUM_ACC:
                return new PrecalculatedRiskWeighting(encoder);
            case DYNAMIC:
                return new FormulaWeighting(encoder, dataSource, weightParams);
            default:
                throw new IllegalArgumentException("Unknown weight type: " + weightType);
        }
    }
}

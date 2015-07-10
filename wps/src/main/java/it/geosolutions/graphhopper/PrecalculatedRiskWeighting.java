package it.geosolutions.graphhopper;

import com.graphhopper.routing.util.FlagEncoder;
import com.graphhopper.routing.util.Weighting;
import com.graphhopper.util.EdgeIteratorState;

public class PrecalculatedRiskWeighting implements Weighting {

    public static final String NAME = "PRECALC_RISK";
    public static final int RISK = 101;
    
    private final FlagEncoder encoder;
    
    public PrecalculatedRiskWeighting(FlagEncoder encoder) {
        this.encoder = encoder;
    }

    @Override
    public double getMinWeight(double distance) {
        return 0;
    }

    @Override
    public double calcWeight(EdgeIteratorState edgeState, boolean reverse, int prevOrNextEdgeId) {
        double risk = encoder.getDouble(edgeState.getFlags(), RISK);
        
        return risk;
    }

    @Override
    public String toString() {
        return NAME;
    }

}

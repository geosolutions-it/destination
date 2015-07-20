package it.geosolutions.graphhopper;

import java.util.Collections;
import java.util.Set;

import com.graphhopper.routing.util.FlagEncoder;
import com.graphhopper.routing.util.Weighting;
import com.graphhopper.util.EdgeIteratorState;

public class PrecalculatedRiskWeighting implements Weighting {

    public static final String NAME = "PRECALC_RISK";
    public static final int RISK = 101;
    
    private final FlagEncoder encoder;
    private Set<Integer> blockedEdges; 
    
    public PrecalculatedRiskWeighting(FlagEncoder encoder, Set<Integer> blockedEdges) {
        this.encoder = encoder;
        this.blockedEdges = blockedEdges;
        if (this.blockedEdges == null) {
            this.blockedEdges = Collections.emptySet();
        }
    }

    @Override
    public double getMinWeight(double distance) {
        return 0;
    }

    @Override
    public double calcWeight(EdgeIteratorState edgeState, boolean reverse, int prevOrNextEdgeId) {
        int edgeDbId = Integer.valueOf(edgeState.getName());
        
        if (blockedEdges.contains(edgeDbId)) {
            return Double.POSITIVE_INFINITY;
        } else {
            double risk = encoder.getDouble(edgeState.getFlags(), RISK);
            
            return risk;
        }
    }

    @Override
    public String toString() {
        return NAME;
    }

}

package it.geosolutions.graphhopper;

import java.util.Collections;
import java.util.Set;

import com.graphhopper.routing.util.ShortestWeighting;
import com.graphhopper.util.EdgeIteratorState;

public class BlockingShortestWeighting extends ShortestWeighting {

    private Set<Integer> blockedEdges;

    public BlockingShortestWeighting(Set<Integer> blockedEdges) {
        this.blockedEdges = blockedEdges;
        if (this.blockedEdges == null) {
            this.blockedEdges = Collections.emptySet();
        }
    }

    @Override
    public double calcWeight(EdgeIteratorState edgeState, boolean reverse, int prevOrNextEdgeId) {
        int edgeDbId = Integer.valueOf(edgeState.getName());
        if (blockedEdges.contains(edgeDbId)) {
            return Double.POSITIVE_INFINITY;
        } else {
            return super.calcWeight(edgeState, reverse, prevOrNextEdgeId);
        }
    }

}

package it.geosolutions.graphhopper;

import com.graphhopper.routing.util.CarFlagEncoder;
import com.graphhopper.routing.util.EncodedDoubleValue;

public class PrecalculatedRiskFlagEncoder extends CarFlagEncoder {

    private EncodedDoubleValue preCalcRiskEncoder;
    
    public PrecalculatedRiskFlagEncoder() {
    }
    
    @Override
    public int defineWayBits(int index, int shift) {
        shift = super.defineWayBits(index, shift);

        preCalcRiskEncoder = new EncodedDoubleValue("Precalculated Risk", shift, 56, 1E-10, 0, (int) (Math.pow(2, 20)));
        shift += preCalcRiskEncoder.getBits();
        
        return shift;
    }
    
    @Override
    public double getDouble(long flags, int key) {
        switch (key)
        {
            case PrecalculatedRiskWeighting.RISK:
                return preCalcRiskEncoder.getDoubleValue(flags);
            default:
                return super.getDouble(flags, key);
        }
    }
    
    @Override
    public long setDouble(long flags, int key, double value) {
        switch (key) {
            case PrecalculatedRiskWeighting.RISK:
                return preCalcRiskEncoder.setDoubleValue(flags, value);
            default:
                return super.setDouble(flags, key, value);
        }
    }

    @Override
    public String toString() {
        return PrecalculatedRiskWeighting.NAME;
    }

}

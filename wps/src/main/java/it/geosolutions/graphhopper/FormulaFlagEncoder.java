package it.geosolutions.graphhopper;

import com.graphhopper.routing.util.CarFlagEncoder;
import com.graphhopper.routing.util.EncodedValue;

public class FormulaFlagEncoder extends CarFlagEncoder {

    private EncodedValue dbEdgeIdEncoder;
    
    public FormulaFlagEncoder() {
    }
    
    @Override
    public int defineWayBits(int index, int shift) {
        shift = super.defineWayBits(index, shift);
        
        dbEdgeIdEncoder = new EncodedValue("DB edge ID", shift, 20, 1, 0, (int) 1E+06);
        shift += dbEdgeIdEncoder.getBits();
        
        return shift;
    }
    
    @Override
    public long getLong(long flags, int key) {
        switch (key)
        {
            case FormulaWeighting.EDGE_ID:
                return dbEdgeIdEncoder.getValue(flags);
            default:
                return super.getLong(flags, key);
        }
    }
    
    @Override
    public long setLong(long flags, int key, long value) {
        switch (key) {
            case FormulaWeighting.EDGE_ID:
                return dbEdgeIdEncoder.setValue(flags, value);
            default:
                return super.setLong(flags, key, value);
        }
    }
    
    @Override
    public String toString() {
        return FormulaWeighting.NAME;
    }

}

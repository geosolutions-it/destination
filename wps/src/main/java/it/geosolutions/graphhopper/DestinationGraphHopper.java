package it.geosolutions.graphhopper;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.sql.DataSource;

import org.geotools.util.logging.Logging;

import com.graphhopper.GraphHopper;
import com.graphhopper.reader.DataReader;
import com.graphhopper.routing.util.FlagEncoder;
import com.graphhopper.routing.util.ShortestWeighting;
import com.graphhopper.routing.util.Weighting;
import com.graphhopper.routing.util.WeightingMap;
import com.graphhopper.storage.GraphStorage;

public class DestinationGraphHopper extends GraphHopper {

    private static final Logger LOGGER = Logging.getLogger(DestinationGraphHopper.class);
    
    private DataSource dataSource;
    private WeightType weightType;
    private Map<String, Object> weightingParams;

    public DestinationGraphHopper(DataSource dataSource, WeightType weightType) {
        this.dataSource = dataSource;
        this.weightType = weightType;
    }

    public DestinationGraphHopper(DataSource dataSource, WeightType weightType, Map<String, Object> weightingParams) {
        this.dataSource = dataSource;
        this.weightType = weightType;
        if (weightingParams != null) {
            this.weightingParams = new HashMap<String, Object>(weightingParams);
        } else {
            this.weightingParams = new HashMap<String, Object>();
        }
    }

    @Override
    protected DataReader createReader(GraphStorage tmpGraph) {
        return new DestinationDataReader(tmpGraph, dataSource, weightType);
    }
    
    @Override
    public Weighting createWeighting(WeightingMap weightingMap, FlagEncoder encoder) {
        try {
            if (WeightType.valueOf(weightingMap.getWeighting()) == weightType) {
                return WeightingFactory.getInstance().create(encoder, dataSource, weightType, weightingParams);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Could not instantiate custom weighting function: " + weightType, e);
        }
        
        // by default, compute shortest path
        return new ShortestWeighting();
    }

}

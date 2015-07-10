package it.geosolutions.graphhopper;

import java.util.ArrayList;
import java.util.List;

import com.graphhopper.routing.util.AbstractFlagEncoder;
import com.graphhopper.routing.util.Bike2WeightFlagEncoder;
import com.graphhopper.routing.util.BikeFlagEncoder;
import com.graphhopper.routing.util.CarFlagEncoder;
import com.graphhopper.routing.util.EncodingManager;
import com.graphhopper.routing.util.FlagEncoder;
import com.graphhopper.routing.util.FootFlagEncoder;
import com.graphhopper.routing.util.MotorcycleFlagEncoder;
import com.graphhopper.routing.util.MountainBikeFlagEncoder;
import com.graphhopper.routing.util.RacingBikeFlagEncoder;

public class DestinationEncodingManager extends EncodingManager {

    public static final String PRECALC_RISK = "precalc_risk";
    public static final String FORMULA = "formula";
    
    /**
     * Instantiate manager with the given list of encoders. The manager knows the default encoders:
     * CAR, FOOT and BIKE (ignoring the case). Custom encoders can be specified by giving a full
     * class name e.g. "car:com.graphhopper.myproject.MyCarEncoder"
     * <p/>
     * @param flagEncodersStr comma delimited list of encoders. The order does not matter.
     */
    public DestinationEncodingManager( String flagEncodersStr )
    {
        this(flagEncodersStr, 4);
    }

    public DestinationEncodingManager( String flagEncodersStr, int bytesForFlags )
    {
        super(parseEncoderString(flagEncodersStr), bytesForFlags);
    }
    
    static List<FlagEncoder> parseEncoderString( String encoderList )
    {
        if (encoderList.contains(":"))
            throw new IllegalArgumentException("EncodingManager does no longer use reflection instantiate encoders directly.");

        String[] entries = encoderList.split(",");
        List<FlagEncoder> resultEncoders = new ArrayList<FlagEncoder>();

        for (String entry : entries)
        {
            entry = entry.trim().toLowerCase();
            if (entry.isEmpty())
                continue;

            String entryVal = "";
            if (entry.contains("|"))
            {
                entryVal = entry;
                entry = entry.split("\\|")[0];
            }

            AbstractFlagEncoder fe;
            if (entry.equals(CAR))
                fe = new CarFlagEncoder(entryVal);

            else if (entry.equals(BIKE))
                fe = new BikeFlagEncoder(entryVal);

            else if (entry.equals(BIKE2))
                fe = new Bike2WeightFlagEncoder(entryVal);

            else if (entry.equals(RACINGBIKE))
                fe = new RacingBikeFlagEncoder(entryVal);

            else if (entry.equals(MOUNTAINBIKE))
                fe = new MountainBikeFlagEncoder(entryVal);

            else if (entry.equals(FOOT))
                fe = new FootFlagEncoder(entryVal);

            else if (entry.equals(MOTORCYCLE))
                fe = new MotorcycleFlagEncoder(entryVal);
            else if (entry.equals(PRECALC_RISK))
                fe = new PrecalculatedRiskFlagEncoder();
            else if (entry.equals(FORMULA))
                fe = new FormulaFlagEncoder();
            else
                throw new IllegalArgumentException("entry in encoder list not supported " + entry);

            resultEncoders.add(fe);
        }
        return resultEncoders;
    }

    /**
     * Create encoding manager supporting 'car' and 'formula' routing profiles.
     *  
     * @return the encoding manager
     */
    public static DestinationEncodingManager createDefault() {
        return new DestinationEncodingManager(CAR + "," + FORMULA, 8);
    }
}

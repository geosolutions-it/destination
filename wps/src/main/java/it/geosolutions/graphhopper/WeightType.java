package it.geosolutions.graphhopper;

public enum WeightType {

    RISK_SOC(DestinationEncodingManager.PRECALC_RISK),
    RISK_ENV(DestinationEncodingManager.PRECALC_RISK),
    NUM_ACC(DestinationEncodingManager.PRECALC_RISK),
    FORMULA(DestinationEncodingManager.FORMULA),
    SHORTEST(DestinationEncodingManager.CAR);
    
    private WeightType(String encoderName) {
        this.encoderName = encoderName;
    }
    
    private String encoderName;
    
    public String encoderName() {
        return encoderName;
    }
    
    public static WeightType fromEncoder(String encoder) {
        if (encoder == null || encoder.isEmpty()) {
            throw new IllegalArgumentException("Encoder must be specified");
        }
        
        for (WeightType enumValue: values()) {
            if (enumValue.encoderName.equals(encoder.toLowerCase())) {
                return enumValue;
            }
        }
        
        throw new IllegalArgumentException("Unknown encoder type: " + encoder);
    }

}

<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>risk</Name>
    <UserStyle>
      <Title>risk</Title>
      <Abstract>risk</Abstract>
      <FeatureTypeStyle>
   <Rule>
    <Title>Basso
      <Localized lang="it">Basso</Localized>
      <Localized lang="en">Low</Localized>
      <Localized lang="fr">Faible</Localized>
      <Localized lang="de">Basso</Localized>
    </Title>
    <Abstract>Basso</Abstract>
   <ogc:Filter>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>low</ogc:Literal>
            <ogc:Literal>100</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>

   </ogc:Filter>
     <MinScaleDenominator>150000</MinScaleDenominator>
     <MaxScaleDenominator>550000</MaxScaleDenominator>
   <PolygonSymbolizer>
   <Fill>
     <CssParameter name="fill">#14F200</CssParameter>
     <CssParameter name="fill-opacity">0.7</CssParameter>
    </Fill>
   </PolygonSymbolizer>
   </Rule>
   <Rule>
    <Title>Medio
      <Localized lang="it">Medio</Localized>
      <Localized lang="en">Medium</Localized>
      <Localized lang="fr">Moyen</Localized>
      <Localized lang="de">Medio</Localized>
    </Title>
    <Abstract>Medio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>medium</ogc:Literal>
            <ogc:Literal>500</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>low</ogc:Literal>
            <ogc:Literal>100</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        
     </ogc:And>
   </ogc:Filter>
     <MinScaleDenominator>150000</MinScaleDenominator>
     <MaxScaleDenominator>550000</MaxScaleDenominator>
   <PolygonSymbolizer>
   <Fill>
     <CssParameter name="fill">#FFFB00</CssParameter>
     <CssParameter name="fill-opacity">0.7</CssParameter>
    </Fill>
   </PolygonSymbolizer>
   </Rule>
   <Rule>
    <Title>Alto
      <Localized lang="it">Alto</Localized>
      <Localized lang="en">High</Localized>
      <Localized lang="fr">Haut</Localized>
      <Localized lang="de">Alto</Localized>
    </Title>
    <Abstract>Alto</Abstract>
   <ogc:Filter>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>medium</ogc:Literal>
            <ogc:Literal>500</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
   </ogc:Filter>
     <MinScaleDenominator>150000</MinScaleDenominator>
     <MaxScaleDenominator>550000</MaxScaleDenominator>
   <PolygonSymbolizer>
   <Fill>
     <CssParameter name="fill">#FF0000</CssParameter>
     <CssParameter name="fill-opacity">0.7</CssParameter>
    </Fill>
   </PolygonSymbolizer>
   </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
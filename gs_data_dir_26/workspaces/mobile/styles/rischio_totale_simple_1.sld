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
      <Localized lang="de">Niedriges</Localized>
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
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#14F200</CssParameter>
      <CssParameter name="stroke-width">12</CssParameter>
     </Stroke>
   </LineSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="startPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>4</Size>
    </Graphic>
   </PointSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="endPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>2</Size>
    </Graphic>
   </PointSymbolizer>
   <TextSymbolizer>
     <Label>
        <ogc:PropertyName>rischio</ogc:PropertyName>
     </Label>
     <Halo>
       <Radius>2</Radius>
         <Fill>
          <CssParameter name="fill">#FFFFFF</CssParameter>
         </Fill>
     </Halo>
     <Font>
       <CssParameter name="font-family">Arial</CssParameter>
       <CssParameter name="font-size">10</CssParameter>
       <CssParameter name="font-style">normal</CssParameter>
       <CssParameter name="font-weight">bold</CssParameter>
     </Font>
     <LabelPlacement>
       <PointPlacement>
           <AnchorPoint>
            <AnchorPointX>0.5</AnchorPointX>
            <AnchorPointY>0.0</AnchorPointY>
           </AnchorPoint>
           <Displacement>
             <DisplacementX>0</DisplacementX>
             <DisplacementY>0</DisplacementY>
           </Displacement>
           <Rotation>-45</Rotation>
       </PointPlacement>
       </LabelPlacement>
       <Fill>
          <CssParameter name="fill">#990099</CssParameter>
       </Fill>
       <VendorOption name="followLine">true</VendorOption>
       <VendorOption name="repeat">100</VendorOption>
       <VendorOption name="group">yes</VendorOption>
   </TextSymbolizer>
   </Rule>
   <Rule>
          <Title>Medio
    <Localized lang="it">Medio</Localized>
      <Localized lang="en">Medium</Localized>
      <Localized lang="fr">Moyen</Localized>
      <Localized lang="de">Mittleres</Localized>
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
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FFFB00</CssParameter>
      <CssParameter name="stroke-width">14</CssParameter>
     </Stroke>
   </LineSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="startPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>4</Size>
    </Graphic>
   </PointSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="endPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>2</Size>
    </Graphic>
   </PointSymbolizer>
   <TextSymbolizer>
     <Label>
        <ogc:PropertyName>rischio</ogc:PropertyName>
     </Label>
     <Halo>
       <Radius>2</Radius>
         <Fill>
          <CssParameter name="fill">#FFFFFF</CssParameter>
         </Fill>
     </Halo>
     <Font>
       <CssParameter name="font-family">Arial</CssParameter>
       <CssParameter name="font-size">10</CssParameter>
       <CssParameter name="font-style">normal</CssParameter>
       <CssParameter name="font-weight">bold</CssParameter>
     </Font>
     <LabelPlacement>
       <PointPlacement>
           <AnchorPoint>
            <AnchorPointX>0.5</AnchorPointX>
            <AnchorPointY>0.0</AnchorPointY>
           </AnchorPoint>
           <Displacement>
             <DisplacementX>0</DisplacementX>
             <DisplacementY>0</DisplacementY>
           </Displacement>
           <Rotation>-45</Rotation>
       </PointPlacement>
       </LabelPlacement>
       <Fill>
          <CssParameter name="fill">#990099</CssParameter>
       </Fill>
       <VendorOption name="followLine">true</VendorOption>
       <VendorOption name="repeat">100</VendorOption>
       <VendorOption name="group">yes</VendorOption>
   </TextSymbolizer>
   </Rule>
   <Rule>
    <Title>Alto
    <Localized lang="it">Alto</Localized>
      <Localized lang="en">High</Localized>
      <Localized lang="fr">Haut</Localized>
      <Localized lang="de">Hohes</Localized>
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
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FF0000</CssParameter>
      <CssParameter name="stroke-width">16</CssParameter>
     </Stroke>
   </LineSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="startPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>4</Size>
    </Graphic>
   </PointSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="endPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>2</Size>
    </Graphic>
   </PointSymbolizer>
   <TextSymbolizer>
     <Label>
        <ogc:PropertyName>rischio</ogc:PropertyName>
     </Label>
     <Halo>
       <Radius>2</Radius>
         <Fill>
          <CssParameter name="fill">#FFFFFF</CssParameter>
         </Fill>
     </Halo>
     <Font>
       <CssParameter name="font-family">Arial</CssParameter>
       <CssParameter name="font-size">10</CssParameter>
       <CssParameter name="font-style">normal</CssParameter>
       <CssParameter name="font-weight">bold</CssParameter>
     </Font>
     <LabelPlacement>
       <PointPlacement>
           <AnchorPoint>
            <AnchorPointX>0.5</AnchorPointX>
            <AnchorPointY>0.0</AnchorPointY>
           </AnchorPoint>
           <Displacement>
             <DisplacementX>0</DisplacementX>
             <DisplacementY>0</DisplacementY>
           </Displacement>
           <Rotation>-45</Rotation>
       </PointPlacement>
       </LabelPlacement>
       <Fill>
          <CssParameter name="fill">#990099</CssParameter>
       </Fill>
       <VendorOption name="followLine">true</VendorOption>
       <VendorOption name="repeat">100</VendorOption>
       <VendorOption name="group">yes</VendorOption>
   </TextSymbolizer>
   </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
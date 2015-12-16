<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>risk</Name>
    <UserStyle>
      <Title>risk</Title>
      <Abstract>risk</Abstract>
      <FeatureTypeStyle>
   <Rule>
    <Title>Basso-Basso
    <Localized lang="it">Basso-Basso</Localized>
      <Localized lang="en">Low-Low</Localized>
      <Localized lang="fr">Faible-Faible</Localized>
      <Localized lang="de">Niedriges-Niedriges</Localized>
  </Title>
    <Abstract>Basso-Basso</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
     </ogc:And>
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
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
 -         <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
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
    <Title>Basso-Medio
    <Localized lang="it">Basso-Medio</Localized>
      <Localized lang="en">Low-Medium</Localized>
      <Localized lang="fr">Faible-Moyen</Localized>
      <Localized lang="de">Niedriges-Mittleres</Localized>
  </Title>
    <Abstract>Basso-Medio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#0A7900</CssParameter>
      <CssParameter name="stroke-width">13</CssParameter>
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
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
 -         <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
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
    <Title>Basso-Alto
    <Localized lang="it">Basso-Alto</Localized>
      <Localized lang="en">Low-High</Localized>
      <Localized lang="fr">Faible-Haut</Localized>
      <Localized lang="de">Niedriges-Hohes</Localized>  
  </Title>
    <Abstract>Basso-Alto</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#053800</CssParameter>
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
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
 -         <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
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
    <Title>Medio-Basso
    <Localized lang="it">Medio-Basso</Localized>
      <Localized lang="en">Medium-Low</Localized>
      <Localized lang="fr">Moyen-Faible</Localized>
      <Localized lang="de">Mittleres-Niedriges</Localized>    
  </Title>
    <Abstract>Medio-Basso</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#A5FB00</CssParameter>
      <CssParameter name="stroke-width">13</CssParameter>
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
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
 -         <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
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
    <Title>Medio-Medio
    <Localized lang="it">Medio-Medio</Localized>
      <Localized lang="en">Medium-Medium</Localized>
      <Localized lang="fr">Moyen-Moyen</Localized>
      <Localized lang="de">Mittleres-Mittleres</Localized>    
  </Title>
    <Abstract>Medio-Medio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>

          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
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
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
 -         <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
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
    <Title>Medio-Alto
    <Localized lang="it">Medio-Alto</Localized>
      <Localized lang="en">Medium-High</Localized>
      <Localized lang="fr">Moyen-Haut</Localized>
      <Localized lang="de">Mittleres-Hohes</Localized>  
  </Title>
    <Abstract>Medio-Alto</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FF9800</CssParameter>
      <CssParameter name="stroke-width">15</CssParameter>
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
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
 -         <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
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
    <Title>Alto-Basso
    <Localized lang="it">Alto-Basso</Localized>
      <Localized lang="en">High-Low</Localized>
      <Localized lang="fr">Haut-Faible</Localized>
      <Localized lang="de">Hohes-Niedriges</Localized>
  </Title>
    <Abstract>Alto-Basso</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FFB4B4</CssParameter>
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
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
 -         <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
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
    <Title>Alto-Medio
    <Localized lang="it">Alto-Medio</Localized>
      <Localized lang="en">High-Medium</Localized>
      <Localized lang="fr">Haut-Moyen</Localized>
      <Localized lang="de">Hohes-Mittleres</Localized>  
  </Title>
    <Abstract>Alto-Medio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FF6A6A</CssParameter>
      <CssParameter name="stroke-width">15</CssParameter>
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
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
 -         <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
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
    <Title>Alto-Alto
    <Localized lang="it">Alto-Alto</Localized>
      <Localized lang="en">High-High</Localized>
      <Localized lang="fr">Haut-Haut</Localized>
      <Localized lang="de">Hohes-Hohes</Localized>  
  </Title>
    <Abstract>Alto-Alto</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
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
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
 -         <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
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
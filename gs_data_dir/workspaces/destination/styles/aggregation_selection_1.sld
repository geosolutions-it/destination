<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>Default Line</Name>
    <UserStyle>
      <Title>1 px blue line</Title>
      <Abstract>Default line style, 1 pixel wide blue</Abstract>

      <FeatureTypeStyle>
        <Rule>
          <Title>Basso (0-${low})</Title>
          <Abstract>Linea per Basso Incidentale</Abstract>
          <ogc:Filter>
              <ogc:PropertyIsLessThanOrEqualTo>
                   <ogc:Function name="round">
                     <ogc:Div>
                       <ogc:PropertyName>calc_formula_tot</ogc:PropertyName>
                       <ogc:PropertyName>lunghezza</ogc:PropertyName>
                     </ogc:Div>             
                   </ogc:Function>
                   <ogc:Literal>${low}</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator>17061</MaxScaleDenominator>
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
             <Size>2</Size>
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
             <ogc:Function name="round">
               <ogc:Div>
                 <ogc:PropertyName>calc_formula_tot</ogc:PropertyName>
                 <ogc:PropertyName>lunghezza</ogc:PropertyName>
               </ogc:Div>             
             </ogc:Function>
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
          <Title>Medio (${low}-${medium})</Title>
          <Abstract>Linea per Medio Incidentale</Abstract>
          <ogc:Filter>
              <ogc:And>
                <ogc:PropertyIsLessThanOrEqualTo>
                   <ogc:Function name="round">
               <ogc:Div>
                 <ogc:PropertyName>calc_formula_tot</ogc:PropertyName>
                 <ogc:PropertyName>lunghezza</ogc:PropertyName>
               </ogc:Div>             
             </ogc:Function>
                   <ogc:Literal>${medium}</ogc:Literal>
                </ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyIsGreaterThanOrEqualTo>
                   <ogc:Function name="round">
                     <ogc:Div>
                       <ogc:PropertyName>calc_formula_tot</ogc:PropertyName>
                       <ogc:PropertyName>lunghezza</ogc:PropertyName>
                     </ogc:Div>             
                   </ogc:Function>
                   <ogc:Literal>${low}</ogc:Literal>
                </ogc:PropertyIsGreaterThanOrEqualTo>
              </ogc:And>
          </ogc:Filter>
          <MaxScaleDenominator>17061</MaxScaleDenominator>
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
             <ogc:Function name="round">
               <ogc:Div>
                 <ogc:PropertyName>calc_formula_tot</ogc:PropertyName>
                 <ogc:PropertyName>lunghezza</ogc:PropertyName>
               </ogc:Div>             
             </ogc:Function>
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
          <Title>Alto (&gt; ${medium})</Title>
          <Abstract>Linea per Alto Incidentale</Abstract>
          <ogc:Filter>
            <ogc:PropertyIsGreaterThanOrEqualTo>
               <ogc:Function name="round">
                 <ogc:Div>
                   <ogc:PropertyName>calc_formula_tot</ogc:PropertyName>
                   <ogc:PropertyName>lunghezza</ogc:PropertyName>
                 </ogc:Div>             
               </ogc:Function>
               <ogc:Literal>${medium}</ogc:Literal>
            </ogc:PropertyIsGreaterThanOrEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator>17061</MaxScaleDenominator>
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
             <Size>6</Size>
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
             <ogc:Function name="round">
               <ogc:Div>
                 <ogc:PropertyName>calc_formula_tot</ogc:PropertyName>
                 <ogc:PropertyName>lunghezza</ogc:PropertyName>
               </ogc:Div>             
             </ogc:Function>
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
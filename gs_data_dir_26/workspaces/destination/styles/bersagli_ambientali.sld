<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>Bersagli Style</Name>
    <UserStyle>
      <Title>Bersagli style</Title>
      <Abstract>Bersagli</Abstract>
      <FeatureTypeStyle>
        <Rule>
          <Title>Zone Urbanizzate
            <Localized lang="it">Zone Urbanizzate</Localized>
            <Localized lang="en">Urbanized Zones</Localized>
            <Localized lang="fr">Zones urbanisées</Localized>
            <Localized lang="de">Urbanisierte Gebiete</Localized>          
          </Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>10</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://plus</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#1C1CD9</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#1C1CD9</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Aree boscate
            <Localized lang="it">Aree boscate</Localized>
            <Localized lang="en">Forest Area</Localized>
            <Localized lang="fr">Superficie forestière</Localized>
            <Localized lang="de">Waldflächen</Localized>
          </Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>11</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://vertline</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#7FFFD4</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>6</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#7FFFD4</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
           
          </PolygonSymbolizer>
          
        </Rule>
		<Rule>
          <Title>Aree protette
            <Localized lang="it">Aree protette</Localized>
            <Localized lang="en">Protected Areas</Localized>
            <Localized lang="fr">Les aires protégées</Localized>
            <Localized lang="de">Schutzgebiete</Localized>
          </Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>12</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://slash</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#C2AC9B</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                   
                 </Mark>
                 <Size>6</Size>
                
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#C2AC9B</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
            
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Aree agricole
            <Localized lang="it">Aree agricole</Localized>
            <Localized lang="en">Coltivated Area</Localized>
            <Localized lang="fr">Coltivated Région</Localized>
            <Localized lang="de">Landwirtschaftliche Flächen</Localized>
          </Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>13</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://horline</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#FFAA7F</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>6</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#FFAA7F</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
            
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Acque sotterranee
            <Localized lang="it">Acque sotterranee</Localized>
            <Localized lang="en">Underground Waters</Localized>
            <Localized lang="fr">Eaux souterraines</Localized>
            <Localized lang="de">Tiefbrunnen</Localized>
          </Title>
         <Filter>
            <PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>14</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://backslash</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#32735C</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                   
                 </Mark>
                 <Size>6</Size>
                
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#32735C</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
            
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Acque superficiali
            <Localized lang="it">Acque superficiali</Localized>
            <Localized lang="en">Surface Waters</Localized>
            <Localized lang="fr">Eaux de surface</Localized>
            <Localized lang="de">Oberflächengewässer</Localized>
          </Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>15</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://backslash</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#9C8783</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                   
                 </Mark>
                 <Size>6</Size>
                
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#9C8783</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
            
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Beni culturali
            <Localized lang="it">Beni culturali</Localized>
            <Localized lang="en">Cultural Sites</Localized>
            <Localized lang="fr">Sites culturels</Localized>
            <Localized lang="de">Kulturerbe</Localized>
          </Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>16</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://dot</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#871CD9</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#871CD9</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
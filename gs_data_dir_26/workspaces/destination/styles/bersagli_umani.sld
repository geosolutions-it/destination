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
          <Title>Popolazione Residente
            <Localized lang="it">Popolazione Residente</Localized>
            <Localized lang="en">Resident People</Localized>
            <Localized lang="fr">Les gens résidents</Localized>
            <Localized lang="de">Wohnbevölkerung</Localized>
          </Title>
          <Filter>
          	<PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>1</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://times</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#FF7FFF</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#FF7FFF</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Popolazione Turistica
            <Localized lang="it">Popolazione Turistica</Localized>
            <Localized lang="en">Tourist People</Localized>
            <Localized lang="fr">Les gens touristiques</Localized>
            <Localized lang="de">Tourismus</Localized>
          </Title>
          <Filter>
          	<PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>2</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://times</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#1CD6D9</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                     <CssParameter name="stroke-opacity">0.2</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
                 <Opacity>0.2</Opacity>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#1CD6D9</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.2</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Addetti industria e servizi
            <Localized lang="it">Addetti industria e servizi</Localized>
            <Localized lang="en">Industry and Service Employees</Localized>
            <Localized lang="fr">Industrie et employ�s de services</Localized>
            <Localized lang="de">Industrie und Dienstleistungen</Localized>
          </Title>
          <Filter>
          	<PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>4</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://oarrow</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#AAB310</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#AAB310</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
		<Rule>
          <Title>Addetti e utenti strutture sanitarie
            <Localized lang="it">Addetti e utenti strutture sanitarie</Localized>
            <Localized lang="en">Sanitary Structrures Employees and Users</Localized>
            <Localized lang="fr">Structrures sanitaires employés et utilisateurs</Localized>
            <Localized lang="de">Sanitäre Strukturen</Localized>
          </Title>
          <Filter>
          	<PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>5</Literal>
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
                     <CssParameter name="stroke">#C74C68</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#C74C68</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Addetti e utenti strutture scolastiche
            <Localized lang="it">Addetti e utenti strutture scolastiche</Localized>
            <Localized lang="en">Scholastic Structrures Employees and Users</Localized>
            <Localized lang="fr">Scholastic Structrures employés et utilisateurs</Localized>
            <Localized lang="de">Schulen und Kindergärten</Localized>
          </Title>          
          <Filter>
          	<PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>6</Literal>
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
                     <CssParameter name="stroke">#354A66</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#354A66</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Addetti e utenti centri Commerciali
            <Localized lang="it">Addetti e utenti centri Commerciali</Localized>
            <Localized lang="en">Supermarket Employees and Users</Localized>
            <Localized lang="fr">Supermarché employés et utilisateurs</Localized>
            <Localized lang="de">Einkaufszentren und Großmärkte</Localized>
          </Title>
          <Filter>
          	<PropertyIsEqualTo>
              <PropertyName>id_bersaglio</PropertyName>
              <Literal>7</Literal>
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
                     <CssParameter name="stroke">#B36410</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#B36410</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
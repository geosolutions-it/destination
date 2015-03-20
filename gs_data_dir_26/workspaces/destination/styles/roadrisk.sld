<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" 
    xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
    xmlns="http://www.opengis.net/sld" 
    xmlns:ogc="http://www.opengis.net/ogc" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <!-- a named layer is the basic building block of an sld document -->

  <NamedLayer>
    <Name>Default Line</Name>
    <UserStyle>
        <!-- they have names, titles and abstracts -->
      
      <Title>A boring default style</Title>
      <Abstract>A sample style that just prints out a green line</Abstract>
      <!-- FeatureTypeStyles describe how to render different features -->
      <!-- a feature type for lines -->

      <FeatureTypeStyle>
        <!--FeatureTypeName>Feature</FeatureTypeName-->
        <Rule>
          <Name>Rule 1</Name>
          <Title>Basso Rischio (minore di 5 )</Title>
          <Abstract>Basso Rischio (minore di 5 )</Abstract>
          <Filter>
             <PropertyIsLessThan>
               <PropertyName>nr_incidenti_elab</PropertyName>
               <Literal>5</Literal>
            </PropertyIsLessThan>
          </Filter>
          <!-- like a polygonsymbolizer -->
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#00FF00</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        <Rule>
          <Name>Rule 2</Name>
          <Title>Medio Rischio (tra 5 e 20)</Title>
          <Abstract>Medio Rischio (tra 5 e 20)</Abstract>
          <Filter>
            <And>
             <PropertyIsGreaterThanOrEqualTo>
               <PropertyName>nr_incidenti_elab</PropertyName>
               <Literal>5</Literal>
            </PropertyIsGreaterThanOrEqualTo>
             <PropertyIsLessThan>
               <PropertyName>nr_incidenti_elab</PropertyName>
               <Literal>20</Literal>
            </PropertyIsLessThan>
            </And>
          </Filter>
          <!-- like a polygonsymbolizer -->
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#FFFF00</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        <Rule>
          <Name>Rule 3</Name>
          <Title>Alto Rischio (maggiore di 20 )</Title>
          <Abstract>Alto Rischio (maggiore di 20 )</Abstract>
          <Filter>
           
             <PropertyIsGreaterThan>
               <PropertyName>nr_incidenti_elab</PropertyName>
               <Literal>20</Literal>
            </PropertyIsGreaterThan>
             
          </Filter>
          <!-- like a polygonsymbolizer -->
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#FF0000</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
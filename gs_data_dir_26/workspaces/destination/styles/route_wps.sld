<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0"
    xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
    <NamedLayer>
        <Name>Default Line</Name>
        <UserStyle>
            <Title>Route</Title>
            <Abstract>Style for minimal risk routes</Abstract>

            <FeatureTypeStyle>
                <Transformation>
                    <ogc:Function name="gs:RoutePlannerGH">
                        <ogc:Function name="parameter">
                            <ogc:Literal>features</ogc:Literal>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>store</ogc:Literal>
                            <ogc:Literal>destination</ogc:Literal>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>start</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>start</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>end</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>end</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>precision</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>precision</ogc:Literal>
                                <ogc:Literal>4</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>processing</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>processing</ogc:Literal>
                                <ogc:Literal>1</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>formula</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>formula</ogc:Literal>
                                <ogc:Literal>141</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>target</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>target</ogc:Literal>
                                <ogc:Literal>98</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>materials</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>materials</ogc:Literal>
                                <ogc:Literal>1,2,3,4,5,6,7,8,9,10,11,12
                                </ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>scenarios</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>scenarios</ogc:Literal>
                                <ogc:Literal>1,2,3,4,5,6,7,8,9,10,11,12,13,14
                                </ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>entities</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>entities</ogc:Literal>
                                <ogc:Literal>0,1</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>severeness</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>severeness</ogc:Literal>
                                <ogc:Literal>1,2,3,4,5</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>fp</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>fp</ogc:Literal>
                                <ogc:Literal>fp_scen_centrale
                                </ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                        <ogc:Function name="parameter">
                            <ogc:Literal>level</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>resolution</ogc:Literal>
                                <ogc:Literal>1</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                      	<ogc:Function name="parameter">
                            <ogc:Literal>blocked</ogc:Literal>
                            <ogc:Function name="env">
                                <ogc:Literal>blocked</ogc:Literal>
                            </ogc:Function>
                        </ogc:Function>
                    </ogc:Function>
                </Transformation>
                <Rule>
                    <Title>Percorso a rischio minimo</Title>
                    <Abstract>Percorso a rischio minimo</Abstract>
                  	<ogc:Filter>
                      <ogc:PropertyIsEqualTo>
                        <ogc:PropertyName>blocked</ogc:PropertyName>
                        <ogc:Literal>false</ogc:Literal>
                      </ogc:PropertyIsEqualTo>
                   	</ogc:Filter>
                    <LineSymbolizer
                        uom="http://www.opengeospatial.org/se/units/metre">
                        <Stroke>
                            <!--<CssParameter name="stroke">#FF00D8</CssParameter>-->
                          	<CssParameter name="stroke">#FCFF08</CssParameter>
                            <CssParameter name="stroke-width">28</CssParameter>
                        </Stroke>
                    </LineSymbolizer>
                    <PointSymbolizer
                        uom="http://www.opengeospatial.org/se/units/metre">
                        <Geometry>
                            <ogc:Function name="startPoint">
                                <ogc:PropertyName>geometria
                                </ogc:PropertyName>
                            </ogc:Function>
                        </Geometry>
                        <Graphic>
<!--                             <Mark> -->
<!--                                 <WellKnownName>circle</WellKnownName> -->
<!--                                 <Fill> -->
<!--                                     <CssParameter name="fill">#000000 -->
<!--                                     </CssParameter> -->
<!--                                 </Fill> -->
<!--                             </Mark> -->
<!--                             <Size>4</Size> -->
                            <ExternalGraphic>
                                <OnlineResource xlink:type="simple" xlink:href="start_displaced.png" />
                                <Format>image/png</Format>
                            </ExternalGraphic>
                        </Graphic>
                    </PointSymbolizer>
                    <PointSymbolizer
                        uom="http://www.opengeospatial.org/se/units/metre">
                        <Geometry>
                            <ogc:Function name="endPoint">
                                <ogc:PropertyName>geometria
                                </ogc:PropertyName>
                            </ogc:Function>
                        </Geometry>
                        <Graphic>
<!--                             <Mark> -->
<!--                                 <WellKnownName>circle</WellKnownName> -->
<!--                                 <Fill> -->
<!--                                     <CssParameter name="fill">#000000 -->
<!--                                     </CssParameter> -->
<!--                                 </Fill> -->
<!--                             </Mark> -->
<!--                             <Size>2</Size> -->
                            <ExternalGraphic>
                                <OnlineResource xlink:type="simple" xlink:href="end_displaced.png" />
                                <Format>image/png</Format>
                            </ExternalGraphic>
                        </Graphic>
                    </PointSymbolizer>
                    <TextSymbolizer>
                        <Label>
                          <!--<ogc:PropertyName>weight</ogc:PropertyName>-->
                          <!--<ogc:Literal>Percorso a rischio minimo</ogc:Literal>-->
                          <ogc:Function name="env">
                            <ogc:Literal>title</ogc:Literal>
                            <ogc:Literal>Percorso minimo</ogc:Literal>
                          </ogc:Function>
                        </Label>
                        <Font>
                            <CssParameter name="font-family">Arial
                            </CssParameter>
                            <CssParameter name="font-size">10
                            </CssParameter>
                            <CssParameter name="font-style">normal
                            </CssParameter>
                            <CssParameter name="font-weight">bold
                            </CssParameter>
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
                        <Halo>
                            <Radius>2</Radius>
                            <Fill>
                                <CssParameter name="fill">#FFFFFF
                                </CssParameter>
                            </Fill>
                        </Halo>
                        <Fill>
                            <CssParameter name="fill">#990099
                            </CssParameter>
                        </Fill>
                        <VendorOption name="followLine">true</VendorOption>
                        <VendorOption name="repeat">100</VendorOption>
                        <VendorOption name="group">yes</VendorOption>
                    </TextSymbolizer>
                </Rule>
              	<Rule>
                    <Title>Tratta bloccata</Title>
                    <Abstract>Tratta bloccata</Abstract>
                  	<ogc:Filter>
                      <ogc:PropertyIsEqualTo>
                        <ogc:PropertyName>blocked</ogc:PropertyName>
                        <ogc:Literal>true</ogc:Literal>
                      </ogc:PropertyIsEqualTo>
                   	</ogc:Filter>
                    <LineSymbolizer
                        uom="http://www.opengeospatial.org/se/units/metre">
                        <Stroke>
                          <GraphicStroke>
                             <Graphic>
                               <Mark>
                                 <WellKnownName>x</WellKnownName>
                                 <Fill>
                                   <CssParameter name="fill">#FCFF08</CssParameter>
                                 </Fill>
                                 <Stroke>
                                   <CssParameter name="stroke">#000000</CssParameter>
                                   <CssParameter name="stroke-width">4</CssParameter>
                                 </Stroke>
                               </Mark>
                               <Size>96</Size>
                             </Graphic>
                           </GraphicStroke>
                            <CssParameter name="stroke-dasharray">76 32</CssParameter>
                        </Stroke>
                    </LineSymbolizer>
              </Rule>
            </FeatureTypeStyle>
        </UserStyle>
    </NamedLayer>
</StyledLayerDescriptor>
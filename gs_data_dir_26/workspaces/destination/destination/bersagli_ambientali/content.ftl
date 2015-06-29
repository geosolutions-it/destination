<div id="main" class="links">
    <a href="${environment.SIIG_URL}" target="_blank"><img src="${environment.SIIG_URL}theme/app/img/BannerDestination_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

<#assign locale = {"en":0,"it":1,"fr":2,"de":3}[request.ENV.LOCALE]/>

<#list features as feature>
<table class="featureInfo">
  <tr>

    <th class="title">${["Attribute","Attribute","Attribute","Attribut"][locale]}</th><th class="title">${["Value","Value","Value","Wert"][locale]}</th>

  </tr>

<#assign odd = false>
    <#if feature.id_bersaglio.value == '10'>
        <#list feature.attributes as attribute>
            <#if !attribute.isGeometry>
             <#if odd>
             <tr class="odd">
             <#else>
                    <tr>
                    </#if>  

                    <#assign odd = !odd>                                                           
                        <#if attribute.name == 'codice_clc'>
                            <th>${["CLC Code","Codice CLC","Codice CLC","Kodex aus Corine Land Cover"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'descrizione_clc_' + request.ENV.LOCALE>
                            <th>${["CLC Description","Descrizione CLC","Descrizione CLC","Beschreibung gemäß Corine Land Cover"][locale]}C</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'superficie'>
                            <th>${["Area","Superficie","Superficie","Fläche"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Urbanized Area","Zone urbanizzate","Zone urbanizzate","Urbanisierte Gebiete"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '11'>
        <#list feature.attributes as attribute>
            <#if !attribute.isGeometry>
             <#if odd>
             <tr class="odd">
             <#else>
                    <tr>
                    </#if>  

                    <#assign odd = !odd>                                                           
                        <#if attribute.name == 'codice_clc'>
                            <th>${["CLC Code","Codice CLC","Codice CLC","Kodex aus Corine Land Cover"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'descrizione_clc_' + request.ENV.LOCALE>
                            <th>${["CLC Description","Descrizione CLC","Descrizione CLC","Beschreibung gemäß Corine Land Cover"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'superficie'>
                            <th>${["Area","Superficie","Superficie","Fläche"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Forest Areas","Aree boscate","Aree boscate","Waldflächen"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '12'>
        <#list feature.attributes as attribute>
            <#if !attribute.isGeometry>
             <#if odd>
             <tr class="odd">
             <#else>
                    <tr>
                    </#if>  

                    <#assign odd = !odd>
                        <#if attribute.name == 'denominazione_' + request.ENV.LOCALE>
                            <th>${["Name","Denominazione","Denominazione","Benennung"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'denominazione_ente_' + request.ENV.LOCALE>
                            <th>${["Authority","Ente","Ente","Benennung der verwaltenden Institution"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                                                                                                                                                
                        <#if attribute.name == 'descrizione_iucn_' + request.ENV.LOCALE>
                            <th>${["IUCN Description","Descrizione IUCN","Descrizione IUCN","Beschreibung IUCN"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'superficie'>
                            <th>${["Area","Superficie","Superficie","Fläche"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Protected Areas","Aree protette","Aree protette","Schutzgebiete"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '13'>
        <#list feature.attributes as attribute>
            <#if !attribute.isGeometry>
             <#if odd>
             <tr class="odd">
             <#else>
                    <tr>
                    </#if>  

                    <#assign odd = !odd>                                                             					                                                          
                        <#if attribute.name == 'codice_clc'>
                            <th>${["CLC Code","Codice CLC","Codice CLC","Kodex aus Corine Land Cover"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'descrizione_clc_' + request.ENV.LOCALE>
                            <th>${["CLC Description","Descrizione CLC","Descrizione CLC","Beschreibung gemäß Corine Land Cover"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        
                        <#if attribute.name == 'superficie'>
                            <th>${["Area","Superficie","Superficie","Fläche"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Coltivated Areas","Aree agricole","Aree agricole","Landwirtschaftliche Flächen"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '14'>
        <#list feature.attributes as attribute>
            <#if !attribute.isGeometry>
             <#if odd>
             <tr class="odd">
             <#else>
                    <tr>
                    </#if>  

                    <#assign odd = !odd>
                        <#if attribute.name == 'denominazione_' + request.ENV.LOCALE>
                            <th>${["Name","Denominazione","Denominazione","Benennung"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                                                                                     
                        <#if attribute.name == 'tipo_captazione_' + request.ENV.LOCALE>
                            <th>${["Captation Type","Tipo captazione","Tipo captazione","Fassungstyp"][locale]}</th><td>${attribute.value}</td> 
                        </#if>					
                        <#if attribute.name == 'superficie'>
                            <th>${["Area","Superficie","Superficie","Fläche"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Underground Waters","Acque sotterranee","Acque sotterranee","Tiefbrunnen"][locale]}</td>
    </#if>
    <#if feature.id_bersaglio.value == '15'>
        <#list feature.attributes as attribute>
            <#if !attribute.isGeometry>
             <#if odd>
             <tr class="odd">
             <#else>
                    <tr>
                    </#if>  

                    <#assign odd = !odd>
                        <#if attribute.name == 'denominazione_' + request.ENV.LOCALE>
                            <th>${["Name","Denominazione","Denominazione","Benennung"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'toponimo_completo_' + request.ENV.LOCALE>
                            <th>${["Full Toponym","Toponimo completo","Toponimo completo","offizielle Benennung"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                                                                                  
                        <#if attribute.name == 'codice_clc'>
                            <th>${["CLC Code","Codice CLC","Codice CLC","Kodex aus Corine Land Cover"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'descrizione_clc_' + request.ENV.LOCALE>
                            <th>${["CLC Description","Descrizione CLC","Descrizione CLC","Beschreibung gemäß Corine Land Cover"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        
                        <#if attribute.name == 'superficie'>
                            <th>${["Area","Superficie","Superficie","Fläche"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'profondita_max'>
                            <th>${["Maximum depth", "Profondità max", "Profondeur maximale", "Maximale Tiefe"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'quota_pdc'>
                            <th>${["Ground level altitude", "Quota", "Altitude du niveau du sol", "Höhe der Geländeoberfläche"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Surface Waters","Acque superficiali","Acque superficiali","Oberflächengewässer"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '16'>
        <#list feature.attributes as attribute>
            <#if !attribute.isGeometry>
             <#if odd>
             <tr class="odd">
             <#else>
                    <tr>
                    </#if>  

                    <#assign odd = !odd>
                        <#if attribute.name == 'denominazione_bene_' + request.ENV.LOCALE>
                            <th>${["Site Name","Denominazione Bene","Denominazione Bene","Benennung des Gutes"][locale]}</th><td>${attribute.value}</td> 
                        </#if> 
                        <#if attribute.name == 'superficie'>
                            <th>${["Area","Superficie","Superficie","Fläche"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'tipologia_' + request.ENV.LOCALE>
                            <th>${["Tipe","Tipologia","Tipologia","Art des Gutes"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Cultural Sites","Beni culturali","Beni culturali","Kulturerbe"][locale]}</td> 
    </#if>

</table>
<hr />
</#list>
<br/>

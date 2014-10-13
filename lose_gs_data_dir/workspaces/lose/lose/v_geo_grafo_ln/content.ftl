<div id="main" class="links">
    <a href="http://lose.geo-solutions.it/lose/" target="_blank"><img src="http://lose.geo-solutions.it/lose/theme/app/img/BannerLose_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

<#assign locale = {"en":0,"it":1,"fr":2,"de":3}[request.ENV.LOCALE]/>

<#list features as feature>
<table class="featureInfo">
  <tr>

    <th class="title">${["Attribute","Attribute","Attribute","Attribut"][locale]}</th><th class="title">${["Value","Value","Value","Wert"][locale]}</th>

  </tr>

<#assign odd = false>
    <#list feature.attributes as attribute>
        <#if !attribute.isGeometry>
         <#if odd>
         <tr class="odd">
         <#else>
                <tr>
                </#if>  

                <#assign odd = !odd>
					<#if attribute.name == 'nr_incidenti'>
						<th>${["Accidents #","N. Incidenti","Nombre d'incidents","Anzahl der Unfälle"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
                    <#if attribute.name == 'flg_nr_incidenti'>
						<th>${["Accidents Flag","Flag Incidenti","Accidents de drapeau","Quelle der Unfälle"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                    
					<#if attribute.name == 'nr_corsie'>
						<th>${["Lanes #","N. Corsie","Nombre de voies","Anzahl der Fahrbahnen"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
                    <#if attribute.name == 'fl_nr_corsie'>
						<th>${["Accidents Flag","Flag Incidenti","Accidents de drapeau","Quelle der Unfälle"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'lunghezza'>
						<th>${["Length","Lunghezza","Longueur","Länge"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'densita_veicolare'>
						<th>${["Vehicular density","Densità Veicolare","Densité de véhicules","Durchschnittlicher Tagesverkehr (DTV)"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'tipo_densita_veicolare_leggeri_pesanti_it'>
						<th>${["Vehicular density type","Tipo Densità Veicolare","Type de densité des véhicules","Quelle DTV"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'velocita_media'>
						<th>${["Average speed","Velocità Media","Vitesse moyenne","Mittlere Geschwindigkeit"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'tipo_velocita_media_leggeri_pesanti_it'>
						<th>${["Average speed type","Tipo Velocità Media","Type de support Vitesse","Quelle Mittlere Geschwindigkeit"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'elenco_dissesti'>
						<th>${["Instabilities list","Elenco Dissesti","Liste des échecs","Quelle Gefahrenzonenkategorisierung"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
									
                </tr>
        </#if>
    </#list>
	
    </tr>

</table>
<hr />
</#list>
<br/>

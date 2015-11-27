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
    <#list feature.attributes as attribute>
        <#if !attribute.isGeometry>
         <#if odd>
         <tr class="odd">
         <#else>
                <tr>
                </#if>
                
                <#assign odd = !odd>
					<#if attribute.name == 'id_gate'>
						<th>${["Id","Id","Id","Id"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'descrizione'>
						<th>${["Description","Denominazione","Description","Description"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'concessionaria_sito'>
						<th>${["Concessionaria","Concessionaria","Concessionaria","Concessionaria"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'direzione'>
						<th>${["Direction","Direzione","Direction","Direction"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'collocazione'>
						<th>${["Position","Ubicazione","Position","Position"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'nr_corsie_carreggiata'>
						<th>${["Lanes","Numero corsie carreggiata","Lanes","Lanes"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'corsia_emergenza'>
						<th>${["Emergency Lanes","Corsia di emergenza","Emergency Lanes","Emergency Lanes"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'tipo_struttura'>
						<th>${["Structure type","Tipo struttura","Structure type","Structure type"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
									
                </tr>
        </#if>
    </#list>
	


</table>
<hr />
</#list>
<br/>

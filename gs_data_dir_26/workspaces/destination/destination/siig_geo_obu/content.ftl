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
					<#if attribute.name == 'tipo'>
						<th>${["Event","Evento","Event","Event"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'semirimorchio'>
						<th>${["Semirimorchio","Semirimorchio","Semirimorchio","Semirimorchio"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
                    <#if attribute.name == 'id'>
						<th>${["Id","Id","Id","Id"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
                    <#if attribute.name == 'autista'>
						<th>${["Driver","Autista","Autista","Autista"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
                    <#if attribute.name == 'trattore'>
						<th>${["Trattore","Trattore","Trattore","Trattore"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
                    <#if attribute.name == 'velocita'>
						<th>${["Speed","Velocita","Velocita","Velocita"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
                    <#if attribute.name == 'direzione'>
						<th>${["Direction","Direzione","Direzione","Direzione"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
					<#if attribute.name == 'data_creazione'>
						<th>${["Date","Data","Date","Date"][locale]}</th><td>${attribute.value}</td> 
                    </#if> 
							
                </tr>
        </#if>
    </#list>
	


</table>
<hr />
</#list>
<br/>

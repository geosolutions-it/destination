<div id="main" class="links">
    <a href="${environment.SIIG_URL}" target="_blank"><img src="${environment.SIIG_URL}theme/app/img/BannerDestination_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

<#assign locale = {"en":0,"it":1,"fr":2,"de":3}[request.ENV.LOCALE]/>

<#list features as feature>
<table class="featureInfo">
  <tr>

    <th class="title">${["Attribute","Attribute","Attribute","Attribut"][locale]}</th><th class="title">${["Value","Value","Value","Wert"][locale]}</th>

  </tr>

    <#list feature.attributes as attribute>
        <#if !attribute.isGeometry>
                
                
                
                    <#if attribute.name == 'rischio_sociale'>
                        <#assign sociale=attribute.value>
                    </#if>
					<#if attribute.name == 'rischio_ambientale'>
                        <#assign ambientale=attribute.value>
                    </#if>
                    <#if attribute.name == 'lunghezza'>
                        <#assign length=attribute.value>
                    </#if>                                 
        </#if>
    </#list>
    <tr class="odd">
    <th>${["Social Risk","Rischio Sociale","Rischio Sociale","Anthropologischen Risiken"][locale]}</th><td>${sociale}</td>
	</tr>
	<tr>
	<th>${["Environmental Risk","Rischio Ambientale","Rischio Ambientale","Umweltrisiken"][locale]}</th><td>${ambientale}</td>
    </tr>

</table>
<hr />
</#list>
<br/>

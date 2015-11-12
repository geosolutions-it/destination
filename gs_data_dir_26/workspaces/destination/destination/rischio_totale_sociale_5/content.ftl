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
                    <#if attribute.name == 'rischio'>
                        <#assign tot=attribute.value>
                    </#if>
                                                 
                </tr>
        </#if>
    </#list>
    <th>${["Risk","Rischio","Rischio","Risiko"][locale]}</th><td>${tot} [morti/arco/anno]</td>


</table>
<hr />
</#list>
<br/>

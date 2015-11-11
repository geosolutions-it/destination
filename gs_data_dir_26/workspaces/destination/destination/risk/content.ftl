<div id="main" class="links">
    <a href="${environment.SIIG_URL}" target="_blank"><img src="${environment.SIIG_URL}theme/app/img/BannerDestination_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

<#assign mixed = false/>

<#list request.ENV?keys as key>
  <#if key == 'LOWSOCIALE'>
    <#assign mixed = true/>
  </#if>
</#list>

<#assign locale = {"en":0,"it":1,"fr":2,"de":3}[request.ENV.LOCALE]/>


<#list features as feature>
<table class="featureInfo">
  <tr>

    <th class="title">${["Attribute","Attributo","Attribute","Attribut"][locale]}</th>
    <th class="title">${["Value","Valore","Value","Wert"][locale]}</th>
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
                    <#if attribute.name == 'viadotto'>
                        <#assign viadotto=attribute.value>
                    </#if>
                    <#if attribute.name == 'galleria'>
                        <#assign galleria=attribute.value>
                    </#if>
                    <#if attribute.name == 'rischio1'>
                        <#assign rischio1=attribute.value>
                    </#if>
                    <#if attribute.name == 'rischio2'>
                        <#assign rischio2=attribute.value>
                    </#if>
					                              
                </tr>
        </#if>
    </#list>
    <#if viadotto == "true">
        <th>${["Type","Tipo","type","Art"][locale]}</th><td>${["Viaduct","Viadotto","Viaduc","Viaduct"][locale]}</td>
    <#elseif galleria == "true">
        <th>${["Type","Tipo","type","Art"][locale]}</th><td>${["Gallery","Galleria","Galerie","Galerie"][locale]}</td>
    <#else>
    
        <#if mixed>
        <th>${["Processed Value - Social","Valore Elaborazione - Sociale","Valore Elaborazione - Sociale","Wertentwicklung - Anthropologisches"][locale]}</th><td>${rischio1} ${request.ENV.FORMULAUDM1}</td>
        </tr><tr>
        <th>${["Processed Value - Environmental","Valore Elaborazione - Ambientale","Valore Elaborazione - Ambientale","Wertentwicklung - Umwelt"][locale]}</th><td>${rischio2} ${request.ENV.FORMULAUDM2}</td>
        <#else>
        <th>${["Processed Value","Valore Elaborazione","Valore Elaborazione","Wertentwicklung"][locale]}</th><td>${rischio1} ${request.ENV.FORMULAUDM}</td>
        </#if>
    </#if>
</table>
<hr />
</#list>
<br/>

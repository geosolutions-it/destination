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
    <#if feature.id_bersaglio.value == '1'>
    <#list feature.attributes as attribute>
        <#if !attribute.isGeometry>
         <#if odd>
         <tr class="odd">
         <#else>
                <tr>
                </#if>
                
                
                <#assign odd = !odd>
                    
                        <#if attribute.name == 'residenti'>
                            <th>${["Resident People","Residenti","Residenti","Anzahl der Anwohner"][locale]}</th><td>${attribute.value}</td> 
                        </#if> 
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'fonte_residenti_' + request.ENV.LOCALE>
                            <th>${["Residents number source (Estimated / calculated)", "Fonte residenti", "Source du nombre de résidents (Estimé/calculé)", "Quelle der Anzahl der Anwohner (geschätzt/berechnet)"][locale]}</th><td>${attribute.value}</td> 
                        </#if>					
                    
                    
                </tr>
        </#if>
    </#list>
	<th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Resident People","Popolazione residente","Popolazione residente","Wohnbevölkerung"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '2'>
        <#list feature.attributes as attribute>
            <#if !attribute.isGeometry>
             <#if odd>
             <tr class="odd">
             <#else>
                    <tr>
                    </#if>
                    
                    
                    <#assign odd = !odd>
                        <#if attribute.name == 'nat_code'>
                            <th>${["NAT Code","NAT Code","NAT Code","Gemeindekodex"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'pres_max'>
                            <th>${["Max Presence","Presenza massima","Presenza massima","maximale Nächtigungen"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'pres_med'>
                            <th>${["Mean Presence","Presenza media","Presenza media","mittlere Nächtigungen"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'denominazione_comune_' + request.ENV.LOCALE>
                            <th>${["Municipality","Comune","Comune","Gemeinde"][locale]}</th><td>${attribute.value}</td> 
                        </#if>   
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>					
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Tourist People","Popolazione turistica","Popolazione turistica","Tourismus"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '4'>
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
                        <#if attribute.name == 'cod_fisc'>
                            <th>${["Fiscal Code","Codice Fiscale","Codice Fiscale","Mehrwertssteuer-Nummer"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'descrizione_ateco_' + request.ENV.LOCALE>
                            <th>${["ATECO Description","Descrizione ATECO","Descrizione ATECO","Beschreibung des ATECO Kodex"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'addetti'>
                            <th>${["Employees Number","N. Addetti","N. Addetti","Anzahl der Beschäftigten"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'fonte_addetti_' + request.ENV.LOCALE>
                            <th>${["Employees number source (Estimated / calculated)", "Fonte addetti", "Source du nombre d'employés (Estimé/calculé)", "Quelle der Anzahl der Beschäftigten (geschätzt/berechnet)"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Industry and Services Users/Employees","Utenti/Addetti industria e servizi","Utenti/Addetti industria e servizi","Industrie und Dienstleistungen"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '5'>
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
                        <#if attribute.name == 'descrizione_uso_' + request.ENV.LOCALE>
                            <th>${["Use Description","Descrizione Uso","Descrizione Uso","Nutzungsbeschreibung"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'fonte_addetti_' + request.ENV.LOCALE>
                            <th>${["Employees number source (Estimated / calculated)", "Fonte addetti", "Source du nombre d'employés (Estimé/calculé)", "Quelle der Bedienstetenzahlen"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'addetti'>
                            <th>${["Employees number", "N. Addetti", "Nombre d'employés", "Anzahl der Bediensteten"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'fonte_numero_letti_day_h_' + request.ENV.LOCALE>
                            <th>${["Day-Hospital beds number source (Estimated / calculated)", "Fonte N. Letti day hosp.", "Source du nombre de lits d'hôpital de jour (Estimé/calculé)s", "Quelle der Bettenzahlen des Day-Hospital (geschätzt/erhoben))"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'nr_letti_dh'>
                            <th>${["Day-Hospital beds number", "N. Letti day hosp.", "Nombre de lits d'hôpital de jour", "Anzahl der Betten im Tageskrankenhaus/Day-Hospital"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'fonte_numero_letti_ordinari_' + request.ENV.LOCALE>
                            <th>${["Ordinary beds number source (Estimated / calculated)", "Fonte N. Letti day ordin.", "Source du nombre de lits ordinaires (Estimé/calculé)", "Quelle der ordentlichen Bettenzahlen (geschätzt/erhoben)"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'letti_ordinari'>
                            <th>${["Ordinary beds number", "N. Letti day ordin.", "Nombre de lits ordinaires", "Anzahl ordentliche Betten"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Sanitary Structures Users/Employees","Utenti/Addetti strutture sanitarie","Utenti/Addetti strutture sanitarie","Sanitäre Strukturen"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '6'>
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
                        <#if attribute.name == 'descrizione_uso_' + request.ENV.LOCALE>
                            <th>${["Use Description","Descrizione Uso","Descrizione Uso","Nutzungsbeschreibung"][locale]}</th><td>${attribute.value}</td> 
                        </#if>	
                        <#if attribute.name == 'fonte_iscritti_' + request.ENV.LOCALE>
                            <th>${["Students number source (Estimated / calculated)", "Fonte Iscritti", "Source du nombre d'élèves inscrits (Estimé/calculé)", " Quelle der Inskribiertenzahlen (geschätzt/erhoben)"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'iscritti'>
                            <th>${["Students number", "N. Iscritti", "Nombre d'élèves inscrits", "Anzahl der Inskribierten "][locale]}</th><td>${attribute.value}</td> 
                        </#if>	
                        <#if attribute.name == 'fonte_addetti_scuole_' + request.ENV.LOCALE>
                            <th>${["Employees number source (Estimated / calculated)", "Fonte Addetti", "Source du nombre d'employés (Estimé/calculé)", "Quelle der Beschäftigtenzahlen (geschätzt/erhoben)"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'addetti'>
                            <th>${["Employees number", "N. Addetti", "Nombre d'employés", "Anzahl der Beschäftigten"][locale]}</th><td>${attribute.value}</td> 
                        </#if>			
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Scholastic Structures Users/Employees","Iscritti/Addetti strutture scolastiche","Iscritti/Addetti strutture scolastiche","Schulen und Kindergärten"][locale]}</td> 
    </#if>
    <#if feature.id_bersaglio.value == '7'>
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
                        <#if attribute.name == 'insegna_' + request.ENV.LOCALE>
                            <th>${["Signboard","Insegna","Insegna","Firmenbezeichnung"][locale]}</th><td>${attribute.value}</td> 
                        </#if>                                                             
                        <#if attribute.name == 'sup_vendita'>
                            <th>${["Sale Area","Sup. di vendita","Sup. di vendita","Verkaufsfläche"][locale]}</th><td>${attribute.value}</td> 
                        </#if>	
                        <#if attribute.name == 'fonte_utenti_' + request.ENV.LOCALE>
                            <th>${["Customers number source (Estimated / calculated)", "Fonte utenti", "Source du nombre de clients (Estimé/calculé)", "Quelle der Anzahl der Kunden (geschätzt/berechnet)"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'utenti'>
                            <th>${["Customers number", "N. Utenti", "Nombre de clients", "Anzahl der Kunden"][locale]}</th><td>${attribute.value}</td> 
                        </#if>	
                        <#if attribute.name == 'fonte_addetti_commercio_' + request.ENV.LOCALE>
                            <th>${["Employees number source (Estimated / calculated)", "Fonte Addetti", "Source du nombre d'employés (Estimé/calculé)", "Quelle der Anzahl der Beschäftigten (geschätzt/berechnet)"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'addetti'>
                            <th>${["Employees number", "N. Addetti", "Nombre d'employés", "Anzahl der Beschäftigten"][locale]}</th><td>${attribute.value}</td> 
                        </#if>
                        <#if attribute.name == 'partner_' + request.ENV.LOCALE>
                            <th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                        </#if>					
                    </tr>
            </#if>
        </#list>
        <th>${["Type","Tipologia","Tipologia","Typologie"][locale]}</th><td>${["Supermarket Users/Employees","Utenti/Addetti centri commerciali","Utenti/Addetti centri commerciali","Einkaufszentren und Großmärkte"][locale]}</td> 
    </#if>
    </tr>
</table>
<hr />
</#list>
<br/>

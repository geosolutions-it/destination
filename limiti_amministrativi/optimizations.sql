   
-- completiamo le tabelle di decodifica per evitare null nel calcolo delle formule
insert into siig_p.siig_r_scenario_gravita(id_scenario,id_bersaglio,id_gravita,suscettibilita)
select id_scenario,id_bersaglio,id_gravita,0
from
siig_p.siig_t_scenario, siig_p.siig_t_bersaglio, siig_d_gravita
where not exists (
select suscettibilita from
siig_p.siig_r_scenario_gravita 
where id_bersaglio = siig_t_bersaglio.id_bersaglio
and id_scenario = siig_t_scenario.id_scenario
and id_gravita = siig_d_gravita.id_gravita);

insert into siig_r_scenario_sostanza(id_scenario,id_sostanza,flg_lieve,psc)
select id_scenario,id_sostanza,flg_lieve,0
from
siig_p.siig_t_scenario, siig_p.siig_t_sostanza, (select 0 as flg_lieve union select 1 as flg_lieve) as entita
where not exists (
select psc from
siig_p.siig_r_scenario_sostanza
where id_sostanza = siig_t_sostanza.id_sostanza
and id_scenario = siig_t_scenario.id_scenario
and flg_lieve = entita.flg_lieve);

ALTER TABLE siig_r_area_danno ADD COLUMN valid boolean DEFAULT true;
update siig_r_area_danno set valid = true;

insert into siig_r_area_danno(id_scenario,id_sostanza,id_bersaglio,flg_lieve,id_gravita,fk_distanza,valid)
select id_scenario,id_sostanza,id_bersaglio,flg_lieve,4 as id_gravita,
(select fk_distanza from siig_r_area_danno 
where id_sostanza = siig_t_sostanza.id_sostanza
and id_scenario = siig_t_scenario.id_scenario
and flg_lieve = entita.flg_lieve
and id_gravita = 3
and id_bersaglio = siig_t_bersaglio.id_bersaglio
),false
from
siig_p.siig_t_scenario, siig_p.siig_t_sostanza, (select 0 as flg_lieve union select 1 as flg_lieve) as entita,siig_d_gravita,siig_t_bersaglio
where not exists (
select fk_distanza from
siig_p.siig_r_area_danno
where id_sostanza = siig_t_sostanza.id_sostanza
and id_scenario = siig_t_scenario.id_scenario
and flg_lieve = entita.flg_lieve
and id_gravita = siig_d_gravita.id_gravita
and id_bersaglio = siig_t_bersaglio.id_bersaglio
) and id_bersaglio > 0 and id_bersaglio < 9 and id_gravita < 5
group by id_scenario,id_sostanza,id_bersaglio,flg_lieve
having count(*) = 1
order by id_scenario,id_sostanza,id_bersaglio,flg_lieve;

insert into siig_r_area_danno(id_scenario,id_sostanza,id_bersaglio,flg_lieve,id_gravita,fk_distanza,valid)
select id_scenario,id_sostanza,id_bersaglio,flg_lieve,4 as id_gravita,
(select fk_distanza from siig_r_area_danno 
where id_sostanza = siig_t_sostanza.id_sostanza
and id_scenario = siig_t_scenario.id_scenario
and flg_lieve = entita.flg_lieve
and id_gravita = 2
and id_bersaglio = siig_t_bersaglio.id_bersaglio
),false
from
siig_p.siig_t_scenario, siig_p.siig_t_sostanza, (select 0 as flg_lieve union select 1 as flg_lieve) as entita,siig_d_gravita,siig_t_bersaglio
where not exists (
select fk_distanza from
siig_p.siig_r_area_danno
where id_sostanza = siig_t_sostanza.id_sostanza
and id_scenario = siig_t_scenario.id_scenario
and flg_lieve = entita.flg_lieve
and id_gravita = siig_d_gravita.id_gravita
and id_bersaglio = siig_t_bersaglio.id_bersaglio
) and id_bersaglio > 0 and id_bersaglio < 9 and id_gravita < 5
group by id_scenario,id_sostanza,id_bersaglio,flg_lieve
having count(*) = 2
order by id_scenario,id_sostanza,id_bersaglio,flg_lieve;

insert into siig_r_area_danno(id_scenario,id_sostanza,id_bersaglio,flg_lieve,id_gravita,fk_distanza,valid)
select id_scenario,id_sostanza,id_bersaglio,flg_lieve,3 as id_gravita,
(select fk_distanza from siig_r_area_danno 
where id_sostanza = siig_t_sostanza.id_sostanza
and id_scenario = siig_t_scenario.id_scenario
and flg_lieve = entita.flg_lieve
and id_gravita = 2
and id_bersaglio = siig_t_bersaglio.id_bersaglio
),false
from
siig_p.siig_t_scenario, siig_p.siig_t_sostanza, (select 0 as flg_lieve union select 1 as flg_lieve) as entita,siig_d_gravita,siig_t_bersaglio
where not exists (
select fk_distanza from
siig_p.siig_r_area_danno
where id_sostanza = siig_t_sostanza.id_sostanza
and id_scenario = siig_t_scenario.id_scenario
and flg_lieve = entita.flg_lieve
and id_gravita = siig_d_gravita.id_gravita
and id_bersaglio = siig_t_bersaglio.id_bersaglio
) and id_bersaglio > 0 and id_bersaglio < 9 and id_gravita < 5
group by id_scenario,id_sostanza,id_bersaglio,flg_lieve
having count(*) = 1
order by id_scenario,id_sostanza,id_bersaglio,flg_lieve;



-- aggiornamento formule
insert into siig_mtd_t_formula (id_formula, flg_visibile, flg_i_grid, ordine_visibilita, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, udm_it, udm_en, udm_de, udm_fr, formula, flg_i, flg_m, flg_g, tema_low, tema_medium, tema_max, fk_formula_env, fk_formula_soc) values (137, 0, 0, 0, '? (Psc x S x (1- Cff))', '? (Psc x S x (1- Cff))', '? (Psc x S x (1- Cff))', '? (Psc x S x (1- Cff))', null, null, null, null, '(select sum(siig_r_scenario_sostanza.psc * ((%formula(140)%)*(%formula(139,id_scenario,siig_r_scenario_sostanza.id_scenario)%)*(%formula(130)%))) from siig_r_scenario_sostanza where siig_r_scenario_sostanza.id_sostanza = %id_sostanza% and siig_r_scenario_sostanza.id_scenario in (%id_scenario%) and flg_lieve in (%flg_lieve%))', 0, 0, 0, 100.0, 500.0, 1000.0, null, null);
insert into siig_mtd_t_formula (id_formula, flg_visibile, flg_i_grid, ordine_visibilita, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, udm_it, udm_en, udm_de, udm_fr, formula, flg_i, flg_m, flg_g, tema_low, tema_medium, tema_max, fk_formula_env, fk_formula_soc) values (138, 0, 0, 0, '? (Padr x ? (Psc x S x (1- Cff)))', '? (Padr x ? (Psc x S x (1- Cff)))', '? (Padr x ? (Psc x S x (1- Cff)))', '? (Padr x ? (Psc x S x (1- Cff)))', null, null, null, null, '(select sum(%simulazione(padr,siig_r_arco_%livello%_sostanza.id_sostanza)% * %formula(137,id_sostanza,siig_r_arco_%livello%_sostanza.id_sostanza)%) from siig_r_arco_%livello%_sostanza where siig_r_arco_%livello%_sostanza.id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco and id_sostanza in (%id_sostanza%))', 0, 0, 0, 100.0, 500.0, 1000.0, null, null);
insert into siig_mtd_t_formula (id_formula, flg_visibile, flg_i_grid, ordine_visibilita, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, udm_it, udm_en, udm_de, udm_fr, formula, flg_i, flg_m, flg_g, tema_low, tema_medium, tema_max, fk_formula_env, fk_formula_soc) values (139, 0, 0, 0, 'S - average', 'S - average', 'S - average', 'S - average', null, null, null, null, '(select avg(suscettibilita) from siig_r_scenario_gravita where id_scenario = %id_scenario% and id_bersaglio in (%id_bersaglio%) and id_gravita = %id_gravita%)', 0, 0, 0, 100.0, 500.0, 1000.0, null, null);
insert into siig_mtd_t_formula (id_formula, flg_visibile, flg_i_grid, ordine_visibilita, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, udm_it, udm_en, udm_de, udm_fr, formula, flg_i, flg_m, flg_g, tema_low, tema_medium, tema_max, fk_formula_env, fk_formula_soc) values (140, 0, 0, 0, '1 - Cff - average', '1 - Cff - average', '1 - Cff - average', '1 - Cff - average', null, null, null, null, '(1-(select avg(%simulazione(cff,id_bersaglio)%) from siig_r_arco_%livello%_scen_tipobers where id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco and id_bersaglio in (%id_bersaglio%)))', 0, 0, 0, 100.0, 500.0, 1000.0, null, null);

update siig_mtd_t_formula set formula='select %fp_field% from siig_t_bersaglio where id_bersaglio = %id_bersaglio%' where id_formula=106;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(109)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) ' where id_formula=17;
update siig_mtd_t_formula set formula='(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,%id_gravita%)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,%id_gravita%)%)' where id_formula=113;
update siig_mtd_t_formula set formula='%simulazione(pis,nr_incidenti_elab/lunghezza*1000)%*(%formula(119)%*%elaborazione(2)%)' where id_formula=117;
update siig_mtd_t_formula set formula='select (%formula(38)%)' where id_formula=36;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(117)%*1000*(%formula(116)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) ' where id_formula=45;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(107,id_gravita,4)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=13;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(108)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=14;
update siig_mtd_t_formula set formula='select id_geo_arco,%simulazione(padr,id_sostanza)% from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %id_sostanza%' where id_formula=20;
update siig_mtd_t_formula set formula='select id_geo_arco,avg(%simulazione(cff,id_bersaglio)%) from siig_r_arco_%livello%_scen_tipobers where id_geo_arco in (%id_geo_arco%) and id_bersaglio in (%id_bersaglio%) group by id_geo_arco' where id_formula=2;
update siig_mtd_t_formula set formula='select sum(psc) from siig_r_scenario_sostanza where id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%)' where id_formula=16;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(110)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) ' where id_formula=18;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(111)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) ' where id_formula=19;
update siig_mtd_t_formula set formula='(select %danno% from siig_t_bersaglio where id_bersaglio=%id_bersaglio%)' where id_formula=121;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(112)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) ' where id_formula=21;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(117)% from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=22;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(118)% from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=23;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(117)%*(%formula(138,id_gravita,5)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%)' where id_formula=40;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(117)%*(%formula(138,id_gravita,4)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) ' where id_formula=39;
update siig_mtd_t_formula set formula='select suscettibilita from siig_r_scenario_gravita where id_scenario = %id_scenario% and id_bersaglio = %id_bersaglio% and id_gravita = %id_gravita%' where id_formula=38;
update siig_mtd_t_formula set formula='(%formula(102,field,nr_pers_residenti,id_gravita,4,id_bersaglio,1)%*%bersaglio(1)%)+(%formula(102,field,nr_turisti_max,id_gravita,4,id_bersaglio,2)%*%bersaglio(2)%)+(%formula(102,field,nr_pers_servizi,id_gravita,4,id_bersaglio,4)%*%bersaglio(4)%)+(%formula(102,field,nr_pers_ospedali,id_gravita,4,id_bersaglio,5)%*%bersaglio(5)%)+(%formula(102,field,nr_pers_scuole,id_gravita,4,id_bersaglio,6)%*%bersaglio(6)%)+(%formula(102,field,nr_pers_distrib,id_gravita,4,id_bersaglio,7)%*%bersaglio(7)%)+(%formula(125,field,utenti_carr_sede_inc,id_gravita,4,id_bersaglio,8)%*%bersaglio(8)%)' where id_formula=100;
update siig_mtd_t_formula set formula='select (%formula(38,id_gravita,5)%)' where id_formula=37;
update siig_mtd_t_formula set formula='(%formula(104,id_bersaglio,%id_bersaglio%)%) * (%formula(113,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,5)%) * (%formula(106,id_bersaglio,%id_bersaglio%)%)' where id_formula=105;
update siig_mtd_t_formula set formula='(%formula(105,field,mq_zone_urbanizzate,id_bersaglio,10)%*%bersaglio(10)%)+(%formula(105,field,mq_aree_boscate,id_bersaglio,11)%*%bersaglio(11)%)+(%formula(105,field,mq_aree_protette,id_bersaglio,12)%*%bersaglio(12)%)+(%formula(105,field,mq_aree_agricole,id_bersaglio,13)%*%bersaglio(13)%)+(%formula(105,field,mq_acque_sotterranee,id_bersaglio,14)%*%bersaglio(14)%)+(%formula(105,field,mq_acque_superficiali,id_bersaglio,15)%*%bersaglio(15)%)+(%formula(105,field,mq_beni_culturali,id_bersaglio,16)%*%bersaglio(16)%)' where id_formula=108;
update siig_mtd_t_formula set formula='(select sum(siig_r_scenario_sostanza.psc * (%formula(107,id_gravita,4,id_scenario,siig_r_scenario_sostanza.id_scenario,flg_lieve,siig_r_scenario_sostanza.flg_lieve)%)) from siig_r_scenario_sostanza  where siig_r_scenario_sostanza.id_sostanza = %id_sostanza% and siig_r_scenario_sostanza.id_scenario in (%id_scenario%) and flg_lieve in (%flg_lieve%))' where id_formula=109;
update siig_mtd_t_formula set formula='(select sum(siig_r_scenario_sostanza.psc * (%formula(108,id_scenario,siig_r_scenario_sostanza.id_scenario,flg_lieve,siig_r_scenario_sostanza.flg_lieve)%)) from siig_r_scenario_sostanza  where siig_r_scenario_sostanza.id_sostanza = %id_sostanza% and siig_r_scenario_sostanza.id_scenario in (%id_scenario%) and flg_lieve in (%flg_lieve%))' where id_formula=110;
update siig_mtd_t_formula set formula='coalesce((select %field%+%simulazione(bersaglio)% from siig_t_vulnerabilita_%livello% where siig_t_vulnerabilita_%livello%.id_geo_arco=siig_geo_ln_arco_%livello%.id_geo_arco and id_distanza = (select coalesce(max(fk_distanza),5) from siig_r_area_danno where id_gravita = %id_gravita% and id_bersaglio = %id_bersaglio% and id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%))),0)' where id_formula=102;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(118)%*(%formula(116)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) ' where id_formula=46;
update siig_mtd_t_formula set formula='(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,1)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,1)%)+(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,2)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,2)%)+(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,3)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,3)%)+(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,4)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,4)%)-(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,1)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,2)%)-(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,2)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,3)%)-(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,3)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,4)%)' where id_formula=114;
update siig_mtd_t_formula set formula='(%formula(104,id_bersaglio,%id_bersaglio%)%) * (%formula(114,id_bersaglio,%id_bersaglio%,field,%field%)%) * (%formula(106,id_bersaglio,%id_bersaglio%)%)' where id_formula=115;
update siig_mtd_t_formula set formula='select sum(%simulazione(padr,siig_r_arco_%livello%_sostanza.id_sostanza)% * (%formula(16)%)) from siig_r_arco_%livello%_sostanza where id_sostanza in (%id_sostanza%) and  siig_r_arco_%livello%_sostanza.id_geo_arco =  siig_geo_ln_arco_%livello%.id_geo_arco' where id_formula=116;
update siig_mtd_t_formula set formula='%simulazione(pis,nr_incidenti_elab/5)%*(%formula(119)%*%elaborazione(2)%)' where id_formula=118;
update siig_mtd_t_formula set formula='(%formula(115,field,nr_pers_residenti,id_bersaglio,1)%*%bersaglio(1)%)+(%formula(115,field,nr_turisti_max,id_bersaglio,2)%*%bersaglio(2)%)+(%formula(115,field,nr_pers_servizi,id_bersaglio,4)%*%bersaglio(4)%)+(%formula(115,field,nr_pers_ospedali,id_bersaglio,5)%*%bersaglio(5)%)+(%formula(115,field,nr_pers_scuole,id_bersaglio,6)%*%bersaglio(6)%)+(%formula(115,field,nr_pers_distrib,id_bersaglio,7)%*%bersaglio(7)%)+(%formula(127,field,utenti_carr_sede_inc,id_bersaglio,8)%*%bersaglio(8)%)' where id_formula=107;
update siig_mtd_t_formula set formula='select coalesce(nmul(pter),1) from siig_d_dissesto inner join siig_r_arco_%livello%_dissesto on siig_r_arco_%livello%_dissesto.id_dissesto = siig_d_dissesto.id_dissesto where siig_r_arco_%livello%_dissesto.id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco' where id_formula=119;
update siig_mtd_t_formula set formula='(%formula(121,id_bersaglio,%id_bersaglio%)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,%id_gravita%)%)' where id_formula=120;
update siig_mtd_t_formula set formula=' (%formula(104,id_bersaglio,%id_bersaglio%)%) * (%formula(120,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,%id_gravita%)%) * (%formula(106,id_bersaglio,%id_bersaglio%)%)' where id_formula=122;
update siig_mtd_t_formula set formula='(%formula(122,field,nr_pers_residenti,id_bersaglio,1,id_gravita,4)%*%bersaglio(1)%)+(%formula(122,field,nr_turisti_max,id_bersaglio,2,id_gravita,4)%*%bersaglio(2)%)+(%formula(122,field,nr_pers_servizi,id_bersaglio,4,id_gravita,4)%*%bersaglio(4)%)+(%formula(122,field,nr_pers_ospedali,id_bersaglio,5,id_gravita,4)%*%bersaglio(5)%)+(%formula(122,field,nr_pers_scuole,id_bersaglio,6,id_gravita,4)%*%bersaglio(6)%)+(%formula(122,field,nr_pers_distrib,id_bersaglio,7,id_gravita,4)%*%bersaglio(7)%)+(%formula(122,field,mq_zone_urbanizzate,id_bersaglio,10,id_gravita,5)%*%bersaglio(10)%)+(%formula(122,field,mq_aree_boscate,id_bersaglio,11,id_gravita,5)%*%bersaglio(11)%)+(%formula(122,field,mq_aree_protette,id_bersaglio,12,id_gravita,5)%*%bersaglio(12)%)+(%formula(122,field,mq_aree_agricole,id_bersaglio,13,id_gravita,5)%*%bersaglio(13)%)+(%formula(122,field,mq_acque_sotterranee,id_bersaglio,14,id_gravita,5)%*%bersaglio(14)%)+(%formula(122,field,mq_acque_superficiali,id_bersaglio,15,id_gravita,5)%*%bersaglio(15)%)+(%formula(122,field,mq_beni_culturali,id_bersaglio,16,id_gravita,5)%*%bersaglio(16)%)' where id_formula=123;
update siig_mtd_t_formula set formula='(%formula(125,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,1)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,1)%)+(%formula(125,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,2)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,2)%)+(%formula(125,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,3)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,3)%)+(%formula(125,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,4)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,4)%)-(%formula(125,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,1)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,2)%)-(%formula(125,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,2)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,3)%)-(%formula(125,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,3)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,4)%)' where id_formula=126;
update siig_mtd_t_formula set formula='(%formula(126,id_bersaglio,%id_bersaglio%,field,%field%)%) * (%formula(106,id_bersaglio,%id_bersaglio%)%)' where id_formula=127;
update siig_mtd_t_formula set formula='1-(select (%simulazione(cff,siig_r_arco_%livello%_scen_tipobers.id_bersaglio)%)/10 from siig_r_arco_%livello%_scen_tipobers where siig_r_arco_%livello%_scen_tipobers.id_geo_arco=siig_geo_ln_arco_%livello%.id_geo_arco and id_bersaglio in (%id_bersaglio%))' where id_formula=104;
update siig_mtd_t_formula set formula='coalesce((select sum(%field%) from siig_r_scen_vuln_%livello% where siig_r_scen_vuln_%livello%.id_geo_arco=siig_geo_ln_arco_%livello%.id_geo_arco and id_scenario in (%id_scenario%) and id_distanza = (select coalesce(max(fk_distanza),5) from siig_r_area_danno where id_gravita = %id_gravita% and id_bersaglio = %id_bersaglio% and id_scenario = siig_r_scen_vuln_%livello%.id_scenario and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%))),0)' where id_formula=125;
update siig_mtd_t_formula set formula='(select sum(%simulazione(padr,siig_r_arco_%livello%_sostanza.id_sostanza)% * (%formula(109,id_sostanza,siig_r_arco_%livello%_sostanza.id_sostanza)%)) from siig_r_arco_%livello%_sostanza where siig_r_arco_%livello%_sostanza.id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco and id_sostanza in (%id_sostanza%))' where id_formula=111;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(123)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=124;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(117)%*((%formula(111)%) + (%formula(112)%)) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=26;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(118)%*((%formula(111)%) + (%formula(112)%)) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=29;
update siig_mtd_t_formula set formula='(%formula(102,field,mq_zone_urbanizzate,id_gravita,5,id_bersaglio,10)%*%bersaglio(10)%)+(%formula(102,field,mq_aree_boscate,id_gravita,5,id_bersaglio,11)%*%bersaglio(11)%)+(%formula(102,field,mq_aree_protette,id_gravita,5,id_bersaglio,12)%*%bersaglio(12)%)+(%formula(102,field,mq_aree_agricole,id_gravita,5,id_bersaglio,13)%*%bersaglio(13)%)+(%formula(102,field,mq_acque_sotterranee,id_gravita,5,id_bersaglio,14)%*%bersaglio(14)%)+(%formula(102,field,mq_acque_superficiali,id_gravita,5,id_bersaglio,15)%*%bersaglio(15)%)+(%formula(102,field,mq_beni_culturali,id_gravita,5,id_bersaglio,16)%*%bersaglio(16)%)' where id_formula=101;
update siig_mtd_t_formula set formula='(select sum(%simulazione(padr,siig_r_arco_%livello%_sostanza.id_sostanza)% * (%formula(110,id_sostanza,siig_r_arco_%livello%_sostanza.id_sostanza)%)) from siig_r_arco_%livello%_sostanza where siig_r_arco_%livello%_sostanza.id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco and id_sostanza in (%id_sostanza%))' where id_formula=112;
update siig_mtd_t_formula set formula='select (%formula(38)%)' where id_formula=128;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(100)%+%formula(101)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=32;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(123)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=134;
update siig_mtd_t_formula set formula='select id_geo_arco,(%formula(100)%+%formula(101)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco' where id_formula=135;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(117)%*(%formula(111)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) ' where id_formula=136;
update siig_mtd_t_formula set formula='select id_geo_arco,%simulazione(padr,id_sostanza)% from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %id_sostanza%' where id_formula=129;
update siig_mtd_t_formula set formula='select sum(psc) from siig_r_scenario_sostanza where id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%)' where id_formula=130;
update siig_mtd_t_formula set formula='select id_geo_arco,avg(%simulazione(cff,id_bersaglio)%) from siig_r_arco_%livello%_scen_tipobers where id_geo_arco in (%id_geo_arco%) and id_bersaglio in (%id_bersaglio%) group by id_geo_arco' where id_formula=131;
update siig_mtd_t_formula set formula='select (%formula(38,id_gravita,5)%)' where id_formula=132;
update siig_mtd_t_formula set formula='select id_geo_arco,%formula(117)%*1000*(%formula(112)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) ' where id_formula=133;

insert into siig_p.siig_r_scenario_gravita(id_scenario,id_bersaglio,id_gravita,suscettibilita)
select id_scenario,id_bersaglio,id_gravita,0
from
siig_p.siig_t_scenario, siig_p.siig_t_bersaglio, siig_d_gravita
where not exists (
select suscettibilita from
siig_p.siig_r_scenario_gravita 
where id_bersaglio = siig_t_bersaglio.id_bersaglio
and id_scenario = siig_t_scenario.id_scenario
and id_gravita = siig_d_gravita.id_gravita);

update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=3 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=3 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=3 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=3 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=3 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=3 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=3 and id_bersaglio=8;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=3 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=3 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=3 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=3 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=3 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=3 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=3 and id_bersaglio=8;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=3 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=3 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=3 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=3 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=3 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=3 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=3 and id_bersaglio=8;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=3 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=3 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=3 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=3 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=3 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=3 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=3 and id_bersaglio=8;

update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=4 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=4 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=4 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=4 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=4 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=4 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=2 and id_gravita=4 and id_bersaglio=8;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=4 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=4 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=4 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=4 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=4 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=4 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=3 and id_gravita=4 and id_bersaglio=8;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=4 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=4 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=4 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=4 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=4 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=4 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=7 and id_gravita=4 and id_bersaglio=8;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=4 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=4 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=4 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=4 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=4 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=4 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.1563 where id_scenario=9 and id_gravita=4 and id_bersaglio=8;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=12 and id_gravita=4 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=12 and id_gravita=4 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=12 and id_gravita=4 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=12 and id_gravita=4 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=12 and id_gravita=4 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=12 and id_gravita=4 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=12 and id_gravita=4 and id_bersaglio=8;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=13 and id_gravita=4 and id_bersaglio=1;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=13 and id_gravita=4 and id_bersaglio=2;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=13 and id_gravita=4 and id_bersaglio=4;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=13 and id_gravita=4 and id_bersaglio=5;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=13 and id_gravita=4 and id_bersaglio=6;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=13 and id_gravita=4 and id_bersaglio=7;
update siig_r_scenario_gravita set suscettibilita=0.0195 where id_scenario=13 and id_gravita=4 and id_bersaglio=8;


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
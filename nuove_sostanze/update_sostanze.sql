ALTER TABLE siig_t_sostanza ADD COLUMN fk_modello numeric(3);
ALTER TABLE siig_t_sostanza ADD CONSTRAINT fk_siig_t_sostanza_modello FOREIGN KEY (fk_modello) REFERENCES siig_t_sostanza (id_sostanza);

ALTER TABLE siig_t_sostanza ALTER COLUMN nome_sostanza_it TYPE character varying(255);
ALTER TABLE siig_t_sostanza ALTER COLUMN nome_sostanza_en TYPE character varying(255);
ALTER TABLE siig_t_sostanza ALTER COLUMN nome_sostanza_fr TYPE character varying(255);
ALTER TABLE siig_t_sostanza ALTER COLUMN nome_sostanza_de TYPE character varying(255);

insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(100,1,1,1,1,'223','gas liquefatto refrigerato, infiammabile',5);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(101,1,1,1,1,'238','gas infiammabile, corrosivo',5);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(102,1,1,1,1,'239','gas infiammabile, che pu� produrre spontaneamente una reazione violenta',5);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(103,1,1,1,1,'26','gas tossico',4);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(104,1,1,1,1,'265','gas tossico e comburente (favorisce l''incendio)',4);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(105,1,1,1,1,'323','materia liquida infiammabile che reagisce con l''acqua, con sviluppo di gas infiammabili',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(106,1,1,1,1,'X323','materia liquida infiammabile che reagisce pericolosamente con l''acqua con sviluppo di gas infiammabili',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(107,1,1,1,1,'333','materia liquida piroforica',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(108,1,1,1,1,'X333','materia liquida piroforica che reagisce pericolosamente con l''acqua',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(109,1,1,1,1,'338','materia liquida molto infiammabile e corrosiva',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(110,1,1,1,1,'X338','materia liquida molto infiammabile e corrosiva, che reagisce pericolosamente con l''acqua',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(111,1,1,1,1,'339','materia liquida molto infiammabile, che pu� produrre spontaneamente una reazione violenta',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(112,1,1,1,1,'36','materia liquida infiammabile (punto d�infiammabilit� compreso tra 23�C e 60�C), debolmente tossica, o materia liquida autoriscaldante e tossica',11);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(113,1,1,1,1,'362','materia liquida infiammabile e tossica, che reagisce con l''acqua, con sviluppo di gas infiammabili',11);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(114,1,1,1,1,'X362','materia liquida infiammabile e tossica, che reagisce pericolosamente con l''acqua, con sviluppo di gas infiammabili',11);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(115,1,1,1,1,'368','materia liquida infiammabile tossica e corrosiva',11);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(116,1,1,1,1,'38','materia liquida infiammabile (punto d�infiammabilit� compreso tra 23�C e 60�C), debolmente corrosiva, o materia liquida autoriscaldante e corrosiva',9);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(117,1,1,1,1,'382','materia liquida infiammabile e corrosiva, che reagisce con l''acqua, con sviluppo di gas infiammabili',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(118,1,1,1,1,'X382','materia liquida infiammabile e corrosiva, che reagisce pericolosamente con l''acqua, con sviluppo di gas infiammabili',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(119,1,1,1,1,'39','materia liquida infiammabile, che pu� produrre spontaneamente una reazione violenta',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(120,1,1,1,1,'50','materia comburente (favorisce l''incendio)',2);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(121,1,1,1,1,'539','perossido organico infiammabile',11);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(122,1,1,1,1,'55','materia molto comburente (favorisce l''incendio)',2);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(123,1,1,1,1,'556','materia molto comburente (favorisce l''incendio) e tossica',2);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(124,1,1,1,1,'558','materia molto comburente (favorisce l''incendio) e corrosiva',2);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(125,1,1,1,1,'559','materia molto comburente (favorisce l''incendio) che pu� produrre spontaneamente una reazione violenta',2);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(126,1,1,1,1,'56','materia comburente (favorisce l''incendio) e tossica',2);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(127,1,1,1,1,'568','materia comburente (favorisce l''incendio) e tossica e corrosiva',2);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(128,1,1,1,1,'58','materia comburente (favorisce l''incendio) e corrosiva',2);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(129,1,1,1,1,'59','materia comburente (favorisce l''incendio) che pu� produrre spontaneamente una reazione violenta',2);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(130,1,1,1,1,'60','materia tossica o debolmente tossica',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(131,1,1,1,1,'623','materia tossica liquida, che reagisce con l''acqua, con sviluppo di gas infiammabili',11);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(132,1,1,1,1,'638','materia tossica e infiammabile (punto d''infiammabilit� compreso tra 23�C e 60�C) e corrosiva',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(133,1,1,1,1,'639','materia tossica e infiammabile (punto d''infiammabilit� inferiore o uguale a 60�C), che pu� produrre spontaneamente una reazione violenta',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(134,1,1,1,1,'65','materia tossica e comburente (favorisce l''incendio)�',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(135,1,1,1,1,'66','materia molto tossica',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(136,1,1,1,1,'663','materia molto tossica infiammabile (punto d''infiammabilit� inferiore o uguale a 60�C)',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(137,1,1,1,1,'665','materia molto tossica e comburente (favorisce l�incendio)',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(138,1,1,1,1,'668','materia molto tossica e corrosiva',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(139,1,1,1,1,'X668','materia altamente tossica, corrosiva, che reagisce pericolosamente con l�acqua',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(140,1,1,1,1,'669','materia molto tossica, che pu� produrre spontaneamente una reazione violenta',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(141,1,1,1,1,'68','materia tossica e corrosiva',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(142,1,1,1,1,'69','materia tossica, o debolmente tossica, che pu� produrre spontaneamente una reazione violenta',12);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(143,1,1,1,1,'823','materia corrosiva liquida, che reagisce con l''acqua, con sviluppo di gas infiammabili�',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(144,1,1,1,1,'83','materia corrosiva o debolmente corrosiva e infiammabile (punto d''infiammabilit� compreso tra 23�C e 60�C)',9);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(145,1,1,1,1,'X83','materia corrosiva o debolmente corrosiva e infiammabile (punto d''infiammabilit� compreso tra 23�C e 60�C), che reagisce pericolosamente con l''acqua',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(146,1,1,1,1,'839','materia corrosiva o debolmente corrosiva e infiammabile (punto d''infiammabilit� compreso tra 23�C e 60�C), pu� produrre spontaneamente una reazione violenta',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(147,1,1,1,1,'X839','materia corrosiva o debolmente corrosiva e infiammabile (punto d''infiammabilit� compreso tra 23�C e 60�C), pu� produrre spontaneamente una reazione violenta, e che reagisce pericolosamente con l''acqua',10);
insert into siig_t_sostanza(id_sostanza,fk_classe_adr,fk_tipo_contenitore,fk_tipo_trasporto,fk_stato_fisico,numero_kemler,nome_sostanza_it,fk_modello) values(148,1,1,1,1,'90','materia pericolosa per l''ambiente, materie pericolose diverse',12);

update siig_t_sostanza set nome_sostanza_en = nome_sostanza_it, nome_sostanza_fr = nome_sostanza_it, nome_sostanza_de = nome_sostanza_it where id_sostanza >= 100;

update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=2,fk_tipo_contenitore=2,fk_tipo_trasporto=1 where id_sostanza=100;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=2,fk_tipo_contenitore=2,fk_tipo_trasporto=1 where id_sostanza=101;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=2,fk_tipo_contenitore=2,fk_tipo_trasporto=1 where id_sostanza=102;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=2,fk_tipo_contenitore=3,fk_tipo_trasporto=1 where id_sostanza=103;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=2,fk_tipo_contenitore=3,fk_tipo_trasporto=1 where id_sostanza=104;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=105;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=106;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=107;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=108;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=109;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=110;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=111;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=112;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=113;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=114;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=115;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=116;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=117;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=118;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=119;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=1,fk_tipo_contenitore=1,fk_tipo_trasporto=1 where id_sostanza=120;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=121;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=1,fk_tipo_contenitore=1,fk_tipo_trasporto=1 where id_sostanza=122;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=1,fk_tipo_contenitore=1,fk_tipo_trasporto=1 where id_sostanza=123;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=1,fk_tipo_contenitore=1,fk_tipo_trasporto=1 where id_sostanza=124;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=1,fk_tipo_contenitore=1,fk_tipo_trasporto=1 where id_sostanza=125;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=1,fk_tipo_contenitore=1,fk_tipo_trasporto=1 where id_sostanza=126;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=1,fk_tipo_contenitore=1,fk_tipo_trasporto=1 where id_sostanza=127;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=1,fk_tipo_contenitore=1,fk_tipo_trasporto=1 where id_sostanza=128;
update siig_t_sostanza set fk_classe_adr=2,fk_stato_fisico=1,fk_tipo_contenitore=1,fk_tipo_trasporto=1 where id_sostanza=129;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=130;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=131;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=132;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=133;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=134;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=135;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=136;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=137;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=138;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=139;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=140;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=141;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=142;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=143;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=144;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=145;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=146;
update siig_t_sostanza set fk_classe_adr=3,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=147;
update siig_t_sostanza set fk_classe_adr=6,fk_stato_fisico=3,fk_tipo_contenitore=2,fk_tipo_trasporto=2 where id_sostanza=148;

insert into siig_r_arco_1_sostanza(id_geo_arco,id_sostanza,padr,fk_partner)
select id_geo_arco, s2.id_sostanza,padr ,s1.fk_partner
from siig_r_arco_1_sostanza s1
inner join siig_t_sostanza s2 on s1.id_sostanza = s2.fk_modello and s2.fk_modello <> s2.id_sostanza;

insert into siig_r_arco_2_sostanza(id_geo_arco,id_sostanza,padr,fk_partner)
select id_geo_arco, s2.id_sostanza,padr ,s1.fk_partner
from siig_r_arco_2_sostanza s1
inner join siig_t_sostanza s2 on s1.id_sostanza = s2.fk_modello and s2.fk_modello <> s2.id_sostanza;

insert into siig_r_arco_3_sostanza(id_geo_arco,id_sostanza,padr,fk_partner)
select id_geo_arco, s2.id_sostanza,padr ,s1.fk_partner
from siig_r_arco_3_sostanza s1
inner join siig_t_sostanza s2 on s1.id_sostanza = s2.fk_modello and s2.fk_modello <> s2.id_sostanza;

insert into siig_r_arco_4_sostanza(id_geo_arco,id_sostanza,padr,fk_partner)
select id_geo_arco, s2.id_sostanza,padr ,s1.fk_partner
from siig_r_arco_4_sostanza s1
inner join siig_t_sostanza s2 on s1.id_sostanza = s2.fk_modello and s2.fk_modello <> s2.id_sostanza;

insert into siig_r_arco_5_sostanza(id_geo_arco,id_sostanza,padr,fk_partner)
select id_geo_arco, s2.id_sostanza,padr ,s1.fk_partner
from siig_r_arco_5_sostanza s1
inner join siig_t_sostanza s2 on s1.id_sostanza = s2.fk_modello and s2.fk_modello <> s2.id_sostanza;

update siig_mtd_t_formula set formula='select sum(psc) from siig_r_scenario_sostanza where id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%)' where id_formula=16;

update siig_mtd_t_formula set formula='select id_geo_arco,%simulazione(padr,id_sostanza)% from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %kemler%' where id_formula=20;

update siig_mtd_t_formula set formula='(select sum(siig_r_scenario_sostanza.psc * (%formula(107,id_gravita,4,id_scenario,siig_r_scenario_sostanza.id_scenario,flg_lieve,siig_r_scenario_sostanza.flg_lieve)%)) from siig_r_scenario_sostanza  where siig_r_scenario_sostanza.id_sostanza = %id_sostanza% and siig_r_scenario_sostanza.id_scenario in (%id_scenario%) and flg_lieve in (%flg_lieve%))' where id_formula=109;
update siig_mtd_t_formula set formula='(select sum(siig_r_scenario_sostanza.psc * (%formula(108,id_scenario,siig_r_scenario_sostanza.id_scenario,flg_lieve,siig_r_scenario_sostanza.flg_lieve)%)) from siig_r_scenario_sostanza  where siig_r_scenario_sostanza.id_sostanza = %id_sostanza% and siig_r_scenario_sostanza.id_scenario in (%id_scenario%) and flg_lieve in (%flg_lieve%))' where id_formula=110;

update siig_mtd_t_formula set formula='(select sum(%simulazione(padr,siig_r_arco_%livello%_sostanza.id_sostanza)% * (%formula(109,id_sostanza,siig_r_arco_%livello%_sostanza.fk_modello)%)) from siig_r_arco_%livello%_sostanza where siig_r_arco_%livello%_sostanza.id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco and id_sostanza in (%kemler%))' where id_formula=111;
update siig_mtd_t_formula set formula='(select sum(%simulazione(padr,siig_r_arco_%livello%_sostanza.id_sostanza)% * (%formula(110,id_sostanza,siig_r_arco_%livello%_sostanza.fk_modello)%)) from siig_r_arco_%livello%_sostanza where siig_r_arco_%livello%_sostanza.id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco and id_sostanza in (%kemler%))' where id_formula=112;

update siig_mtd_t_formula set formula='select sum(%simulazione(padr,siig_r_arco_%livello%_sostanza.id_sostanza)% * (%formula(16)%)) from siig_r_arco_%livello%_sostanza where id_sostanza in (%kemler%) and  siig_r_arco_%livello%_sostanza.id_geo_arco =  siig_geo_ln_arco_%livello%.id_geo_arco' where id_formula=116;

update siig_mtd_t_formula set formula='select id_geo_arco,%simulazione(padr,id_sostanza)% from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %kemler%' where id_formula=129;
update siig_mtd_t_formula set formula='select sum(psc) from siig_r_scenario_sostanza where id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%)' where id_formula=130;

update siig_mtd_t_formula set formula='(select sum(siig_r_scenario_sostanza.psc * ((%formula(140)%)*(%formula(139,id_scenario,siig_r_scenario_sostanza.id_scenario)%)*(%formula(130)%))) from siig_r_scenario_sostanza where siig_r_scenario_sostanza.id_sostanza = %id_sostanza% and siig_r_scenario_sostanza.id_scenario in (%id_scenario%) and flg_lieve in (%flg_lieve%))' where id_formula=137;
update siig_mtd_t_formula set formula='(select sum(%simulazione(padr,siig_r_arco_%livello%_sostanza.id_sostanza)% * %formula(137,id_sostanza,siig_r_arco_%livello%_sostanza.fk_modello)%) from siig_r_arco_%livello%_sostanza where siig_r_arco_%livello%_sostanza.id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco and id_sostanza in (%kemler%))' where id_formula=138;

alter table siig_r_arco_1_sostanza add column fk_modello numeric(3,0);
alter table siig_r_arco_2_sostanza add column fk_modello numeric(3,0);
alter table siig_r_arco_3_sostanza add column fk_modello numeric(3,0);
alter table siig_r_arco_4_sostanza add column fk_modello numeric(3,0);
alter table siig_r_arco_5_sostanza add column fk_modello numeric(3,0);

update siig_r_arco_1_sostanza set fk_modello = (select fk_modello from siig_t_sostanza where siig_t_sostanza.id_sostanza = siig_r_arco_1_sostanza.id_sostanza);
update siig_r_arco_2_sostanza set fk_modello = (select fk_modello from siig_t_sostanza where siig_t_sostanza.id_sostanza = siig_r_arco_2_sostanza.id_sostanza);
update siig_r_arco_3_sostanza set fk_modello = (select fk_modello from siig_t_sostanza where siig_t_sostanza.id_sostanza = siig_r_arco_3_sostanza.id_sostanza);
update siig_r_arco_4_sostanza set fk_modello = (select fk_modello from siig_t_sostanza where siig_t_sostanza.id_sostanza = siig_r_arco_4_sostanza.id_sostanza);
update siig_r_arco_5_sostanza set fk_modello = (select fk_modello from siig_t_sostanza where siig_t_sostanza.id_sostanza = siig_r_arco_5_sostanza.id_sostanza);
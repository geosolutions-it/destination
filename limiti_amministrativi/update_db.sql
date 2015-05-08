CREATE TABLE
    siig_geo_pl_comuni
    (
        cod_comune CHARACTER VARYING(7) NOT NULL,
        cod_provincia CHARACTER VARYING(5) NOT NULL,
        descrizione CHARACTER VARYING(100),
        geometria GEOMETRY(MULTIPOLYGON, 32632),
        CONSTRAINT pk_siig_geo_pl_comuni PRIMARY KEY (cod_comune)
    );
    
CREATE INDEX siig_geo_pl_comuni_gidx ON siig_geo_pl_comuni USING GIST ( geometria );
CREATE INDEX siig_geo_pl_province_gidx ON siig_geo_pl_province USING GIST ( geometria );

--insert into siig_geo_pl_comuni(cod_comune, cod_provincia, descrizione, geometria)
--select cod_istat, LPAD(cod_pro::text, 3, '0'), nome, geom
--from com2011_ed50
--where cod_reg in (1,2,3) or cod_pro = 21;

ALTER TABLE siig_geo_ln_arco_1 ADD COLUMN cod_comune varchar(7);
ALTER TABLE siig_geo_ln_arco_1 ADD COLUMN cod_provincia varchar(5);
ALTER TABLE siig_geo_ln_arco_2 ADD COLUMN cod_comune varchar(7);
ALTER TABLE siig_geo_ln_arco_2 ADD COLUMN cod_provincia varchar(5);
ALTER TABLE siig_geo_ln_arco_3 ADD COLUMN cod_comune varchar(7);
ALTER TABLE siig_geo_ln_arco_3 ADD COLUMN cod_provincia varchar(5);
ALTER TABLE siig_geo_pl_arco_3 ADD COLUMN cod_comune varchar(7);
ALTER TABLE siig_geo_pl_arco_3 ADD COLUMN cod_provincia varchar(5);

CREATE INDEX idx_geo_arco_1_prov ON siig_geo_ln_arco_1(cod_provincia);
CREATE INDEX idx_geo_arco_1_com ON siig_geo_ln_arco_1(cod_comune);
CREATE INDEX idx_geo_arco_2_prov ON siig_geo_ln_arco_2(cod_provincia);
CREATE INDEX idx_geo_arco_2_com ON siig_geo_ln_arco_2(cod_comune);
CREATE INDEX idx_geo_arco_3_prov ON siig_geo_ln_arco_3(cod_provincia);
CREATE INDEX idx_geo_arco_3_com ON siig_geo_ln_arco_3(cod_comune);
CREATE INDEX idx_geo_arco_pl_3_prov ON siig_geo_pl_arco_3(cod_provincia);
CREATE INDEX idx_geo_arco_pl_3_com ON siig_geo_pl_arco_3(cod_comune);

CREATE TABLE
    siig_geo_pl_arco_4
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        nr_incidenti DOUBLE PRECISION,
        nr_incidenti_elab DOUBLE PRECISION,
        nr_corsie NUMERIC(2,0) DEFAULT 2,
        lunghezza NUMERIC(8,0),
        nr_bers_umani_strada NUMERIC(5,0),
        id_tematico_shape NUMERIC(9,0),
        fk_partner CHARACTER VARYING(5) NOT NULL,
        geometria GEOMETRY(MULTIPOLYGON, 32632),
        id_origine NUMERIC(9,0),
        flg_nr_corsie CHARACTER VARYING(1),
        flg_nr_incidenti CHARACTER VARYING(1),
        cod_comune CHARACTER VARYING(7),
        cod_provincia CHARACTER VARYING(5),
        PRIMARY KEY (id_geo_arco),
        CONSTRAINT fk_siig_d_partner_08 FOREIGN KEY (fk_partner) REFERENCES siig_p.siig_d_partner
        (id_partner),
        CONSTRAINT dom_14_scm CHECK ((flg_nr_incidenti)::text = ANY (ARRAY[('C'::CHARACTER VARYING)
        ::text, ('S'::CHARACTER VARYING)::text, ('M'::CHARACTER VARYING)::text])),
        CONSTRAINT dom_13_scm CHECK ((flg_nr_corsie)::text = ANY (ARRAY[('C'::CHARACTER VARYING)::
        text, ('S'::CHARACTER VARYING)::text, ('M'::CHARACTER VARYING)::text]))
    );
    
CREATE INDEX idx_geo_arco_pl_4_prov ON siig_geo_pl_arco_4(cod_provincia);
CREATE INDEX idx_geo_arco_pl_4_com ON siig_geo_pl_arco_4(cod_comune);
CREATE INDEX siig_geo_pl_arco_4_gidx ON siig_geo_pl_arco_4 USING GIST ( geometria );

CREATE TABLE
    siig_geo_pl_arco_5
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        nr_incidenti DOUBLE PRECISION,
        nr_incidenti_elab DOUBLE PRECISION,
        nr_corsie NUMERIC(2,0) DEFAULT 2,
        lunghezza NUMERIC(8,0),
        nr_bers_umani_strada NUMERIC(5,0),
        id_tematico_shape NUMERIC(9,0),
        fk_partner CHARACTER VARYING(5) NOT NULL,
        geometria GEOMETRY(MULTIPOLYGON, 32632),
        id_origine NUMERIC(9,0),
        flg_nr_corsie CHARACTER VARYING(1),
        flg_nr_incidenti CHARACTER VARYING(1),
        cod_comune CHARACTER VARYING(7),
        cod_provincia CHARACTER VARYING(5),
        PRIMARY KEY (id_geo_arco),
        CONSTRAINT fk_siig_d_partner_09 FOREIGN KEY (fk_partner) REFERENCES siig_p.siig_d_partner
        (id_partner),
        CONSTRAINT dom_16_scm CHECK ((flg_nr_incidenti)::text = ANY (ARRAY[('C'::CHARACTER VARYING)
        ::text, ('S'::CHARACTER VARYING)::text, ('M'::CHARACTER VARYING)::text])),
        CONSTRAINT dom_15_scm CHECK ((flg_nr_corsie)::text = ANY (ARRAY[('C'::CHARACTER VARYING)::
        text, ('S'::CHARACTER VARYING)::text, ('M'::CHARACTER VARYING)::text]))
    );
    
CREATE INDEX idx_geo_arco_pl_5_prov ON siig_geo_pl_arco_5(cod_provincia);
CREATE INDEX idx_geo_arco_pl_5_com ON siig_geo_pl_arco_5(cod_comune);
CREATE INDEX siig_geo_pl_arco_5_gidx ON siig_geo_pl_arco_5 USING GIST ( geometria );

CREATE TABLE
    siig_r_arco_4_dissesto
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_dissesto CHARACTER VARYING(20) NOT NULL,
        fk_partner CHARACTER VARYING(5),
        CONSTRAINT pk_siig_r_arco_4_dissesto PRIMARY KEY (id_geo_arco, id_dissesto),
        CONSTRAINT fk_siig_d_dissesto_04 FOREIGN KEY (id_dissesto) REFERENCES
        siig_p.siig_d_dissesto (id_dissesto),
        CONSTRAINT siig_r_arco_4_dissesto_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_4 (id_geo_arco) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_dissesto_4_partner
ON
    siig_r_arco_4_dissesto
    (
        fk_partner
    );
    
CREATE INDEX
    idx_dissesto_geo_arco_4
ON
    siig_r_arco_4_dissesto
    (
        id_geo_arco
    );
    

    
CREATE TABLE
    siig_r_arco_5_dissesto
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_dissesto CHARACTER VARYING(20) NOT NULL,
        fk_partner CHARACTER VARYING(5),
        CONSTRAINT pk_siig_r_arco_5_dissesto PRIMARY KEY (id_geo_arco, id_dissesto),
        CONSTRAINT fk_siig_d_dissesto_05 FOREIGN KEY (id_dissesto) REFERENCES
        siig_p.siig_d_dissesto (id_dissesto),
        CONSTRAINT siig_r_arco_5_dissesto_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_5 (id_geo_arco) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_dissesto_5_partner
ON
    siig_r_arco_5_dissesto
    (
        fk_partner
    );
    
CREATE INDEX
    idx_dissesto_geo_arco_5
ON
    siig_r_arco_5_dissesto
    (
        id_geo_arco
    );
    
CREATE TABLE
    siig_r_arco_4_scen_tipobers
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_bersaglio NUMERIC(6,0) NOT NULL,
        fk_partner CHARACTER VARYING(5),
        cff DOUBLE PRECISION,
        CONSTRAINT pk_siig_r_arco_4_scen_tipobers PRIMARY KEY (id_geo_arco, id_bersaglio),
        CONSTRAINT fk_siig_d_bersaglio_05 FOREIGN KEY (id_bersaglio) REFERENCES
        siig_p.siig_t_bersaglio (id_bersaglio),
        CONSTRAINT siig_r_arco_4_scen_tipobers_id_geo_arco_fkey FOREIGN KEY (id_geo_arco)
        REFERENCES siig_p.siig_geo_pl_arco_4 (id_geo_arco) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_arco_4_scen_tipo_bers_arco
ON
    siig_r_arco_4_scen_tipobers
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_4_scen_tipo_bers_partner
ON
    siig_r_arco_4_scen_tipobers
    (
        fk_partner
    );
    
CREATE TABLE
    siig_r_arco_5_scen_tipobers
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_bersaglio NUMERIC(6,0) NOT NULL,
        fk_partner CHARACTER VARYING(5),
        cff DOUBLE PRECISION,
        CONSTRAINT pk_siig_r_arco_5_scen_tipobers PRIMARY KEY (id_geo_arco, id_bersaglio),
        CONSTRAINT fk_siig_d_bersaglio_06 FOREIGN KEY (id_bersaglio) REFERENCES
        siig_p.siig_t_bersaglio (id_bersaglio),
        CONSTRAINT siig_r_arco_5_scen_tipobers_id_geo_arco_fkey FOREIGN KEY (id_geo_arco)
        REFERENCES siig_p.siig_geo_pl_arco_5 (id_geo_arco) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_arco_5_scen_tipo_bers_arco
ON
    siig_r_arco_5_scen_tipobers
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_5_scen_tipo_bers_partner
ON
    siig_r_arco_5_scen_tipobers
    (
        fk_partner
    );    
    
CREATE TABLE
    siig_r_arco_4_sostanza
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_sostanza NUMERIC(3,0) NOT NULL,
        padr NUMERIC(6,5),
        fk_partner CHARACTER VARYING(5),
        CONSTRAINT pk_siig_r_arco_4_sostanza PRIMARY KEY (id_geo_arco, id_sostanza),
        CONSTRAINT fk_siig_t_sostanza_04 FOREIGN KEY (id_sostanza) REFERENCES
        siig_p.siig_t_sostanza (id_sostanza),
        CONSTRAINT siig_r_arco_4_sostanza_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_4 (id_geo_arco) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_arco_4_sostanza_arco
ON
    siig_r_arco_4_sostanza
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_4_sostanza_partner
ON
    siig_r_arco_4_sostanza
    (
        fk_partner
    );
    
CREATE TABLE
    siig_r_arco_5_sostanza
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_sostanza NUMERIC(3,0) NOT NULL,
        padr NUMERIC(6,5),
        fk_partner CHARACTER VARYING(5),
        CONSTRAINT pk_siig_r_arco_5_sostanza PRIMARY KEY (id_geo_arco, id_sostanza),
        CONSTRAINT fk_siig_t_sostanza_05 FOREIGN KEY (id_sostanza) REFERENCES
        siig_p.siig_t_sostanza (id_sostanza),
        CONSTRAINT siig_r_arco_5_sostanza_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_5 (id_geo_arco) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_arco_5_sostanza_arco
ON
    siig_r_arco_5_sostanza
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_5_sostanza_partner
ON
    siig_r_arco_5_sostanza
    (
        fk_partner
    );
    
CREATE TABLE
    siig_r_tipovei_geoarco4
    (
        id_tipo_veicolo NUMERIC(2,0) NOT NULL,
        id_geo_arco NUMERIC(9,0) NOT NULL,
        densita_veicolare NUMERIC(8,2),
        velocita_media NUMERIC(8,2),
        fk_partner CHARACTER VARYING(5),
        flg_velocita CHARACTER VARYING(1),
        flg_densita_veicolare CHARACTER VARYING(1),
        CONSTRAINT pk_siig_r_tipovei_geoarco4 PRIMARY KEY (id_tipo_veicolo, id_geo_arco),
        CONSTRAINT fk_siig_d_tipo_veicolo_04 FOREIGN KEY (id_tipo_veicolo) REFERENCES
        siig_p.siig_d_tipo_veicolo (id_tipo_veicolo),
        CONSTRAINT siig_r_tipovei_geoarco4_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_4 (id_geo_arco) ON
    DELETE
        CASCADE,
        CONSTRAINT dom_7_scm CHECK ((flg_velocita)::text = ANY (ARRAY[('C'::CHARACTER VARYING)::
        text, ('S'::CHARACTER VARYING)::text, ('M'::CHARACTER VARYING)::text])),
        CONSTRAINT dom_8_scm CHECK ((flg_densita_veicolare)::text = ANY (ARRAY[('C'::CHARACTER
        VARYING)::text, ('S'::CHARACTER VARYING)::text, ('M'::CHARACTER VARYING)::text]))
    );
    
CREATE INDEX
    idx_arco_4_tipovei_partner
ON
    siig_r_tipovei_geoarco4
    (
        fk_partner
    );
    
CREATE INDEX
    idx_tipovei_geo_arco_4
ON
    siig_r_tipovei_geoarco4
    (
        id_geo_arco
    );
    
CREATE TABLE
    siig_r_tipovei_geoarco5
    (
        id_tipo_veicolo NUMERIC(2,0) NOT NULL,
        id_geo_arco NUMERIC(9,0) NOT NULL,
        densita_veicolare NUMERIC(8,2),
        velocita_media NUMERIC(8,2),
        fk_partner CHARACTER VARYING(5),
        flg_velocita CHARACTER VARYING(1),
        flg_densita_veicolare CHARACTER VARYING(1),
        CONSTRAINT pk_siig_r_tipovei_geoarco5 PRIMARY KEY (id_tipo_veicolo, id_geo_arco),
        CONSTRAINT fk_siig_d_tipo_veicolo_05 FOREIGN KEY (id_tipo_veicolo) REFERENCES
        siig_p.siig_d_tipo_veicolo (id_tipo_veicolo),
        CONSTRAINT siig_r_tipovei_geoarco5_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_5 (id_geo_arco) ON
    DELETE
        CASCADE,
        CONSTRAINT dom_9_scm CHECK ((flg_velocita)::text = ANY (ARRAY[('C'::CHARACTER VARYING)::
        text, ('S'::CHARACTER VARYING)::text, ('M'::CHARACTER VARYING)::text])),
        CONSTRAINT dom_10_scm CHECK ((flg_densita_veicolare)::text = ANY (ARRAY[('C'::CHARACTER
        VARYING)::text, ('S'::CHARACTER VARYING)::text, ('M'::CHARACTER VARYING)::text]))
    );
    
CREATE INDEX
    idx_arco_5_tipovei_partner
ON
    siig_r_tipovei_geoarco5
    (
        fk_partner
    );
    
CREATE INDEX
    idx_tipovei_geo_arco_5
ON
    siig_r_tipovei_geoarco5
    (
        id_geo_arco
    );
    
CREATE TABLE
    siig_t_vulnerabilita_4
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_distanza NUMERIC(4,0) NOT NULL,
        nr_pers_scuole NUMERIC(10,0),
        nr_pers_ospedali NUMERIC(10,0),
        nr_pers_distrib NUMERIC(10,0),
        nr_pers_residenti NUMERIC(10,0),
        nr_pers_servizi NUMERIC(10,0),
        nr_turisti_medi NUMERIC(10,0),
        nr_turisti_max NUMERIC(10,0),
        mq_aree_protette NUMERIC(15,2),
        mq_aree_agricole NUMERIC(15,2),
        mq_aree_boscate NUMERIC(15,2),
        mq_beni_culturali NUMERIC(15,2),
        mq_zone_urbanizzate NUMERIC(15,2),
        mq_acque_superficiali NUMERIC(15,0),
        mq_acque_sotterranee NUMERIC(15,0),
        fk_partner CHARACTER VARYING(5),
        flag INTEGER,
        CONSTRAINT pk_siig_t_vulnerabilita_4 PRIMARY KEY (id_geo_arco, id_distanza),
        CONSTRAINT fk_siig_d_distanza_04 FOREIGN KEY (id_distanza) REFERENCES
        siig_p.siig_d_distanza (id_distanza),
        CONSTRAINT siig_t_vulnerabilita_4_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_4 (id_geo_arco) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_arco_4_vuln_arco
ON
    siig_t_vulnerabilita_4
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_4_vuln_partner
ON
    siig_t_vulnerabilita_4
    (
        fk_partner
    );
    
CREATE TABLE
    siig_t_vulnerabilita_5
    (
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_distanza NUMERIC(4,0) NOT NULL,
        nr_pers_scuole NUMERIC(7,0),
        nr_pers_ospedali NUMERIC(7,0),
        nr_pers_distrib NUMERIC(7,0),
        nr_pers_residenti NUMERIC(7,0),
        nr_pers_servizi NUMERIC(7,0),
        nr_turisti_medi NUMERIC(7,0),
        nr_turisti_max NUMERIC(7,0),
        mq_aree_protette NUMERIC(10,2),
        mq_aree_agricole NUMERIC(10,2),
        mq_aree_boscate NUMERIC(10,2),
        mq_beni_culturali NUMERIC(10,2),
        mq_zone_urbanizzate NUMERIC(10,2),
        mq_acque_superficiali NUMERIC(12,0),
        mq_acque_sotterranee NUMERIC(12,0),
        fk_partner CHARACTER VARYING(5),
        flag INTEGER,
        CONSTRAINT pk_siig_t_vulnerabilita_5 PRIMARY KEY (id_geo_arco, id_distanza),
        CONSTRAINT fk_siig_d_distanza_05 FOREIGN KEY (id_distanza) REFERENCES
        siig_p.siig_d_distanza (id_distanza),
        CONSTRAINT siig_t_vulnerabilita_5_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_5 (id_geo_arco) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_arco_5_vuln_arco
ON
    siig_t_vulnerabilita_5
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_5_vuln_partner
ON
    siig_t_vulnerabilita_5
    (
        fk_partner
    );
    
CREATE TABLE
    siig_r_scen_vuln_4
    (
        id_scenario NUMERIC(9,0) NOT NULL,
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_distanza NUMERIC(4,0) NOT NULL,
        utenti_carr_bersaglio NUMERIC(10,0),
        utenti_carr_sede_inc NUMERIC(10,0),
        fk_partner CHARACTER VARYING(5),
        CONSTRAINT pk_siig_r_scen_vuln_4 PRIMARY KEY (id_scenario, id_geo_arco, id_distanza),
        CONSTRAINT fk_siig_t_scenario_04 FOREIGN KEY (id_scenario) REFERENCES
        siig_p.siig_t_scenario (id_scenario),
        CONSTRAINT fk_siig_t_vulnerabilita_4_02 FOREIGN KEY (id_geo_arco, id_distanza) REFERENCES
        siig_p.siig_t_vulnerabilita_4 (id_geo_arco, id_distanza) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_arco_4_scen_vuln_arco
ON
    siig_r_scen_vuln_4
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_4_scen_vuln_partner
ON
    siig_r_scen_vuln_4
    (
        fk_partner
    );
    
CREATE TABLE
    siig_r_scen_vuln_5
    (
        id_scenario NUMERIC(9,0) NOT NULL,
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_distanza NUMERIC(4,0) NOT NULL,
        utenti_carr_bersaglio NUMERIC(10,0),
        utenti_carr_sede_inc NUMERIC(10,0),
        fk_partner CHARACTER VARYING(5),
        CONSTRAINT pk_siig_r_scen_vuln_5 PRIMARY KEY (id_scenario, id_geo_arco, id_distanza),
        CONSTRAINT fk_siig_t_scenario_05 FOREIGN KEY (id_scenario) REFERENCES
        siig_p.siig_t_scenario (id_scenario),
        CONSTRAINT fk_siig_t_vulnerabilita_5_02 FOREIGN KEY (id_geo_arco, id_distanza) REFERENCES
        siig_p.siig_t_vulnerabilita_5 (id_geo_arco, id_distanza) ON
    DELETE
        CASCADE
    );
    
CREATE INDEX
    idx_arco_5_scen_vuln_arco
ON
    siig_r_scen_vuln_5
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_5_scen_vuln_partner
ON
    siig_r_scen_vuln_5
    (
        fk_partner
    );
    
CREATE TABLE
    siig_t_elab_standard_4
    (
        flg_lieve NUMERIC(1,0) DEFAULT 0 NOT NULL,
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_scenario NUMERIC(9,0) NOT NULL,
        id_sostanza NUMERIC(3,0) NOT NULL,
        id_distanza NUMERIC(4,0) NOT NULL,
        calc_formula_tot NUMERIC(8,0),
        calc_formula_soc double precision,
        calc_formula_amb double precision,
        calc_formula_scuole NUMERIC(8,0),
        calc_formula_ospedali NUMERIC(8,0),
        calc_formula_distrib NUMERIC(8,0),
        calc_formula_residenti NUMERIC(8,0),
        calc_formula_servizi NUMERIC(8,0),
        calc_formula_turisti_medi NUMERIC(8,0),
        calc_formula_turisti_max NUMERIC(8,0),
        calc_formula_flusso NUMERIC(8,0),
        calc_formula_aree_protette NUMERIC(12,2),
        calc_formula_aree_agricole NUMERIC(12,2),
        calc_formula_aree_boscate NUMERIC(12,2),
        calc_formula_beni_culturali NUMERIC(12,2),
        calc_formula_zone_urbanizzate NUMERIC(12,2),
        calc_formula_acque_superf NUMERIC(14,0),
        calc_formula_acque_sotterranee NUMERIC(14,0),
        fk_partner CHARACTER VARYING(5),
        CONSTRAINT pk_siig_t_elab_standard_4 PRIMARY KEY (flg_lieve, id_geo_arco, id_scenario,
        id_sostanza, id_distanza),
        CONSTRAINT siig_t_elab_standard_4_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_4 (id_geo_arco) ON
    DELETE
        CASCADE,
        CONSTRAINT dom_01722 CHECK (flg_lieve = ANY (ARRAY[(0)::NUMERIC, (1)::NUMERIC]))
    );
    
CREATE INDEX
    idx_arco_4_elab_arco
ON
    siig_t_elab_standard_4
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_4_elab_partner
ON
    siig_t_elab_standard_4
    (
        fk_partner
    );
    
CREATE TABLE
    siig_t_elab_standard_5
    (
        flg_lieve NUMERIC(1,0) DEFAULT 0 NOT NULL,
        id_geo_arco NUMERIC(9,0) NOT NULL,
        id_scenario NUMERIC(9,0) NOT NULL,
        id_sostanza NUMERIC(3,0) NOT NULL,
        id_distanza NUMERIC(4,0) NOT NULL,
        calc_formula_tot NUMERIC(8,0),
        calc_formula_soc double precision,
        calc_formula_amb double precision,
        calc_formula_scuole NUMERIC(8,0),
        calc_formula_ospedali NUMERIC(8,0),
        calc_formula_distrib NUMERIC(8,0),
        calc_formula_residenti NUMERIC(8,0),
        calc_formula_servizi NUMERIC(8,0),
        calc_formula_turisti_medi NUMERIC(8,0),
        calc_formula_turisti_max NUMERIC(8,0),
        calc_formula_flusso NUMERIC(8,0),
        calc_formula_aree_protette NUMERIC(12,2),
        calc_formula_aree_agricole NUMERIC(12,2),
        calc_formula_aree_boscate NUMERIC(12,2),
        calc_formula_beni_culturali NUMERIC(12,2),
        calc_formula_zone_urbanizzate NUMERIC(12,2),
        calc_formula_acque_superf NUMERIC(14,0),
        calc_formula_acque_sotterranee NUMERIC(14,0),
        fk_partner CHARACTER VARYING(5),
        CONSTRAINT pk_siig_t_elab_standard_5 PRIMARY KEY (flg_lieve, id_geo_arco, id_scenario,
        id_sostanza, id_distanza),
        CONSTRAINT siig_t_elab_standard_5_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES
        siig_p.siig_geo_pl_arco_5 (id_geo_arco) ON
    DELETE
        CASCADE,
        CONSTRAINT dom_01723 CHECK (flg_lieve = ANY (ARRAY[(0)::NUMERIC, (1)::NUMERIC]))
    );
    
CREATE INDEX
    idx_arco_5_elab_arco
ON
    siig_t_elab_standard_5
    (
        id_geo_arco
    );
    
CREATE INDEX
    idx_arco_5_elab_partner
ON
    siig_t_elab_standard_5
    (
        fk_partner
    );
    
create view v_province(cod_provincia,sigla_provincia,descrizione) as
select cod_provincia,sigla_provincia,descrizione,ST_Envelope(geometria) as geometria from siig_geo_pl_province;

create view v_comuni(cod_comune,cod_provincia,descrizione) as
select cod_comune,cod_provincia,descrizione,ST_Envelope(geometria) as geometria from siig_geo_pl_comuni;

-- griglia a 2km
CREATE TABLE siig_geo_grid_2(
        gid NUMERIC(9,0) NOT NULL,
        geometria geometry(POLYGON,32632),
        PRIMARY KEY (gid)
);

CREATE INDEX
    siig_geo_grid_2_gidx
ON siig_geo_grid_2 using GIST(geometria);

CREATE OR REPLACE FUNCTION public.makegrid_2d (
  bound_polygon public.geometry,
  grid_step integer,
  metric_srid integer = 32632
)
RETURNS public.geometry AS
$body$
DECLARE
  BoundM public.geometry; --Bound polygon transformed to metric projection (with metric_srid SRID)
  Xmin DOUBLE PRECISION;
  Xmax DOUBLE PRECISION;
  Ymax DOUBLE PRECISION;
  X DOUBLE PRECISION;
  Y DOUBLE PRECISION;
  sectors public.geometry[];
  i INTEGER;
BEGIN
  BoundM := ST_Transform($1, $3); --From WGS84 (SRID 4326) to metric projection, to operate with step in meters
  Xmin := ST_XMin(BoundM);
  Xmax := ST_XMax(BoundM);
  Ymax := ST_YMax(BoundM);

  Y := ST_YMin(BoundM); --current sector's corner coordinate
  i := -1;
  <<yloop>>
  LOOP
    IF (Y > Ymax) THEN  --Better if generating polygons exceeds bound for one step. You always can crop the result. But if not you may get not quite correct data for outbound polygons (if you calculate frequency per a sector  e.g.)
        EXIT;
    END IF;

    X := Xmin;
    <<xloop>>
    LOOP
      IF (X > Xmax) THEN
          EXIT;
      END IF;

      i := i + 1;
      sectors[i] := ST_GeomFromText('POLYGON(('||X||' '||Y||', '||(X+$2)||' '||Y||', '||(X+$2)||' '||(Y+$2)||', '||X||' '||(Y+$2)||', '||X||' '||Y||'))', $3);

      X := X + $2;
    END LOOP xloop;
    Y := Y + $2;
  END LOOP yloop;

  RETURN ST_Transform(ST_Collect(sectors), ST_SRID($1));
END;
$body$
LANGUAGE 'plpgsql';

INSERT INTO siig_geo_grid_2(gid,geometria)
SELECT row_number() OVER (ORDER BY q_grid.cell) AS gid,q_grid.cell AS geometria
FROM
(SELECT (st_dump(makegrid_2d(st_geomfromtext('Polygon((300000 4870000,770000 4870000,770000 5220000,300000 5220000,300000 4870000))'::text, 32632), 2000, 32632))).geom AS cell) q_grid

-- griglia a 2km tagliata sui confini comunali
CREATE TABLE siig_geo_grid_2_clip(
        gid NUMERIC(9,0) NOT NULL,
        geometria geometry(MULTIPOLYGON,32632),
        fk_partner varchar(5),
        PRIMARY KEY (gid)
);

CREATE INDEX
    siig_geo_grid_2_clip_gidx
ON siig_geo_grid_2_clip using GIST(geometria);

insert into siig_geo_grid_2_clip(gid,geometria,fk_partner)
SELECT row_number() OVER () AS gid,ST_Multi(ST_Intersection(siig_geo_grid_2.geometria,siig_geo_pl_comuni.geometria))  AS geometria,
(case when cod_provincia in ('001','002','003','004','005','006','096','103') then '1' when cod_provincia in ('012','013','014','015','016','017','018','019','020','097','098','108') then '2' when cod_provincia in ('007') then '3' when cod_provincia in ('021') then '4' else '5' end)
FROM
siig_geo_grid_2 inner join siig_geo_pl_comuni
on ST_Intersects(siig_geo_grid_2.geometria , siig_geo_pl_comuni.geometria);

alter table siig_geo_pl_arco_3 alter column geometria TYPE geometry(MULTIPOLYGON, 32632) USING ST_Multi(geometria);

DROP VIEW v_geo_grafo_ln;

CREATE VIEW
    "v_geo_grafo_ln_1"
    (
        "id_geo_arco",
        "partner_it",
        "tipo_densita_veicolare_leggeri_pesanti_it",
        "densita_veicolare",
        "tipo_velocita_media_leggeri_pesanti_it",
        "velocita_media",
        "fl_nr_corsie",
        "nr_corsie",
        "flg_nr_incidenti",
        "nr_incidenti",
        "nr_incidenti_elab",
        "lunghezza",
        "elenco_dissesti",
        "geometria",
        "cod_provincia",
        "cod_comune"
    ) AS
SELECT
    siig_geo_ln_arco_1.id_geo_arco,
    siig_d_partner.partner_it,
    (z_cat(
        CASE
            WHEN ((siig_r_tipovei_geoarco1.flg_densita_veicolare)::text = 'S'::text)
            THEN 'STIMATA'::text
            WHEN ((siig_r_tipovei_geoarco1.flg_densita_veicolare)::text = 'C'::text)
            THEN 'CALCOLATA'::text
            WHEN ((siig_r_tipovei_geoarco1.flg_densita_veicolare)::text = 'M'::text)
            THEN 'MODELLIZZATA'::text
            ELSE NULL::text
        END))::CHARACTER VARYING(50)                   AS tipo_densita_veicolare_leggeri_pesanti_it,
    (z_cat(siig_r_tipovei_geoarco1.densita_veicolare))::CHARACTER VARYING(50) AS densita_veicolare,
    (z_cat(
        CASE
            WHEN ((siig_r_tipovei_geoarco1.velocita_media)::text = 'S'::text)
            THEN 'STIMATA'::text
            WHEN ((siig_r_tipovei_geoarco1.velocita_media)::text = 'C'::text)
            THEN 'CALCOLATA'::text
            WHEN ((siig_r_tipovei_geoarco1.velocita_media)::text = 'M'::text)
            THEN 'MODELLIZZATA'::text
            ELSE NULL::text
        END))::CHARACTER VARYING(50)                      AS tipo_velocita_media_leggeri_pesanti_it,
    (z_cat(siig_r_tipovei_geoarco1.velocita_media))::CHARACTER VARYING(50) AS velocita_media,
    CASE
        WHEN ((siig_geo_ln_arco_1.flg_nr_corsie)::text = 'S'::text)
        THEN 'STIMATO'::text
        WHEN ((siig_geo_ln_arco_1.flg_nr_corsie)::text = 'C'::text)
        THEN 'CALCOLATO'::text
        WHEN ((siig_geo_ln_arco_1.flg_nr_corsie)::text = 'M'::text)
        THEN 'MODELLIZZATO'::text
        ELSE NULL::text
    END AS fl_nr_corsie,
    siig_geo_ln_arco_1.nr_corsie,
    CASE
        WHEN ((siig_geo_ln_arco_1.flg_nr_incidenti)::text = 'S'::text)
        THEN 'STIMATO'::text
        WHEN ((siig_geo_ln_arco_1.flg_nr_incidenti)::text = 'C'::text)
        THEN 'CALCOLATO'::text
        WHEN ((siig_geo_ln_arco_1.flg_nr_incidenti)::text = 'M'::text)
        THEN 'MODELLIZZATO'::text
        ELSE NULL::text
    END AS flg_nr_incidenti,
    siig_geo_ln_arco_1.nr_incidenti,
    siig_geo_ln_arco_1.nr_incidenti_elab,
    siig_geo_ln_arco_1.lunghezza,
    z_cat(siig_d_dissesto.descrizione_it) AS elenco_dissesti,
    siig_geo_ln_arco_1.geometria,
    siig_geo_ln_arco_1.cod_provincia,
    siig_geo_ln_arco_1.cod_comune
FROM
    (((siig_d_partner
LEFT JOIN
    siig_geo_ln_arco_1
ON
    (((
                siig_d_partner.id_partner)::text = (siig_geo_ln_arco_1.fk_partner)::text)))
LEFT JOIN
    (siig_d_dissesto
LEFT JOIN
    siig_r_arco_1_dissesto
ON
    (((
                siig_d_dissesto.id_dissesto)::text = (siig_r_arco_1_dissesto.id_dissesto)::text)))
ON
    ((
            siig_geo_ln_arco_1.id_geo_arco = siig_r_arco_1_dissesto.id_geo_arco)))
LEFT JOIN
    siig_r_tipovei_geoarco1
ON
    ((
            siig_geo_ln_arco_1.id_geo_arco = siig_r_tipovei_geoarco1.id_geo_arco)))
GROUP BY
    siig_geo_ln_arco_1.id_geo_arco,
    siig_geo_ln_arco_1.geometria,
    siig_geo_ln_arco_1.lunghezza,
    siig_d_partner.partner_it,
    siig_geo_ln_arco_1.nr_corsie,
    siig_geo_ln_arco_1.flg_nr_corsie,
    siig_geo_ln_arco_1.flg_nr_incidenti,
    siig_geo_ln_arco_1.nr_incidenti,
    siig_geo_ln_arco_1.nr_incidenti_elab
ORDER BY
    siig_geo_ln_arco_1.id_geo_arco;

DROP VIEW v_geo_grafo_ln_2;
CREATE VIEW  "v_geo_grafo_ln_2"
    (
        "id_geo_arco",
        "partner_it",
        "tipo_densita_veicolare_leggeri_pesanti_it",
        "densita_veicolare",
        "tipo_velocita_media_leggeri_pesanti_it",
        "velocita_media",
        "fl_nr_corsie",
        "nr_corsie",
        "flg_nr_incidenti",
        "nr_incidenti",
        "nr_incidenti_elab",
        "lunghezza",
        "elenco_dissesti",
        "geometria",
        "cod_provincia",
        "cod_comune"
    ) AS
SELECT
    siig_geo_ln_arco_2.id_geo_arco,
    siig_d_partner.partner_it,
    (z_cat(
        CASE
            WHEN ((siig_r_tipovei_geoarco2.flg_densita_veicolare)::text = 'S'::text)
            THEN 'STIMATA'::text
            WHEN ((siig_r_tipovei_geoarco2.flg_densita_veicolare)::text = 'C'::text)
            THEN 'CALCOLATA'::text
            WHEN ((siig_r_tipovei_geoarco2.flg_densita_veicolare)::text = 'M'::text)
            THEN 'MODELLIZZATA'::text
            ELSE NULL::text
        END))::CHARACTER VARYING(50)                   AS tipo_densita_veicolare_leggeri_pesanti_it,
    (z_cat(siig_r_tipovei_geoarco2.densita_veicolare))::CHARACTER VARYING(50) AS densita_veicolare,
    (z_cat(
        CASE
            WHEN ((siig_r_tipovei_geoarco2.velocita_media)::text = 'S'::text)
            THEN 'STIMATA'::text
            WHEN ((siig_r_tipovei_geoarco2.velocita_media)::text = 'C'::text)
            THEN 'CALCOLATA'::text
            WHEN ((siig_r_tipovei_geoarco2.velocita_media)::text = 'M'::text)
            THEN 'MODELLIZZATA'::text
            ELSE NULL::text
        END))::CHARACTER VARYING(50)                      AS tipo_velocita_media_leggeri_pesanti_it,
    (z_cat(siig_r_tipovei_geoarco2.velocita_media))::CHARACTER VARYING(50) AS velocita_media,
    CASE
        WHEN ((siig_geo_ln_arco_2.flg_nr_corsie)::text = 'S'::text)
        THEN 'STIMATO'::text
        WHEN ((siig_geo_ln_arco_2.flg_nr_corsie)::text = 'C'::text)
        THEN 'CALCOLATO'::text
        WHEN ((siig_geo_ln_arco_2.flg_nr_corsie)::text = 'M'::text)
        THEN 'MODELLIZZATO'::text
        ELSE NULL::text
    END AS fl_nr_corsie,
    siig_geo_ln_arco_2.nr_corsie,
    CASE
        WHEN ((siig_geo_ln_arco_2.flg_nr_incidenti)::text = 'S'::text)
        THEN 'STIMATO'::text
        WHEN ((siig_geo_ln_arco_2.flg_nr_incidenti)::text = 'C'::text)
        THEN 'CALCOLATO'::text
        WHEN ((siig_geo_ln_arco_2.flg_nr_incidenti)::text = 'M'::text)
        THEN 'MODELLIZZATO'::text
        ELSE NULL::text
    END AS flg_nr_incidenti,
    siig_geo_ln_arco_2.nr_incidenti,
    siig_geo_ln_arco_2.nr_incidenti_elab,
    siig_geo_ln_arco_2.lunghezza,
    z_cat(siig_d_dissesto.descrizione_it) AS elenco_dissesti,
    siig_geo_ln_arco_2.geometria,
    siig_geo_ln_arco_2.cod_provincia,
    siig_geo_ln_arco_2.cod_comune
FROM
    (((siig_d_partner
LEFT JOIN
    siig_geo_ln_arco_2
ON
    (((
                siig_d_partner.id_partner)::text = (siig_geo_ln_arco_2.fk_partner)::text)))
LEFT JOIN
    (siig_d_dissesto
LEFT JOIN
    siig_r_arco_2_dissesto
ON
    (((
                siig_d_dissesto.id_dissesto)::text = (siig_r_arco_2_dissesto.id_dissesto)::text)))
ON
    ((
            siig_geo_ln_arco_2.id_geo_arco = siig_r_arco_2_dissesto.id_geo_arco)))
LEFT JOIN
    siig_r_tipovei_geoarco2
ON
    ((
            siig_geo_ln_arco_2.id_geo_arco = siig_r_tipovei_geoarco2.id_geo_arco)))
GROUP BY
    siig_geo_ln_arco_2.id_geo_arco,
    siig_geo_ln_arco_2.geometria,
    siig_geo_ln_arco_2.lunghezza,
    siig_d_partner.partner_it,
    siig_geo_ln_arco_2.nr_corsie,
    siig_geo_ln_arco_2.flg_nr_corsie,
    siig_geo_ln_arco_2.flg_nr_incidenti,
    siig_geo_ln_arco_2.nr_incidenti,
    siig_geo_ln_arco_2.nr_incidenti_elab
ORDER BY
    siig_geo_ln_arco_2.id_geo_arco;
    
alter table siig_p.siig_geo_pl_comuni add column fk_partner character varying(5);
 
alter table siig_p.siig_geo_pl_province add column fk_partner character varying(5);

update siig_geo_pl_province set fk_partner ='1'
where cod_provincia in ('001','002','003','004','005','006','096','103');

update siig_geo_pl_province set fk_partner ='2'
where cod_provincia in ('012','013','014','015','016','017','018','019','020','097','098','108');

update siig_geo_pl_province set fk_partner ='3'
where cod_provincia in ('007');

update siig_geo_pl_province set fk_partner ='4'
where cod_provincia in ('021');

update siig_geo_pl_province set fk_partner ='5'
where cod_provincia in ('CH07');

update siig_p.siig_geo_pl_comuni set fk_partner = ( 
select p.fk_partner from  siig_p.siig_geo_pl_province p 
where siig_p.siig_geo_pl_comuni.cod_provincia = p.cod_provincia);

--- formulas help
ALTER TABLE siig_mtd_t_formula ADD COLUMN help_it character varying(8000);
ALTER TABLE siig_mtd_t_formula ADD COLUMN help_en character varying(8000);
ALTER TABLE siig_mtd_t_formula ADD COLUMN help_de character varying(8000);
ALTER TABLE siig_mtd_t_formula ADD COLUMN help_fr character varying(8000);
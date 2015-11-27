CREATE VIEW
    "import_metadata"
    (
        "partner",
        "bersaglio",
        "nome_file",
        "data",
        "nr_rec_shape",
        "nr_rec_storage",
        "nr_rec_scartati",
        "nr_rec_scartati_siig",
        "data_imp_storage",
        "data_elab",
        "data_imp_siig",
        "flg_tipo_imp",
        "fk_processo",
        "data_creazione",
        "data_chiusura_a",
        "data_chiusura_b",
        "data_chiusura_c",
        "errors"
    ) AS
SELECT
    siig_d_partner.partner_en       AS partner,
    siig_t_bersaglio.descrizione_it AS bersaglio,
    siig_t_tracciamento.nome_file,
    siig_t_tracciamento.data,
    siig_t_tracciamento.nr_rec_shape,
    siig_t_tracciamento.nr_rec_storage,
    siig_t_tracciamento.nr_rec_scartati,
    siig_t_tracciamento.nr_rec_scartati_siig,
    siig_t_tracciamento.data_imp_storage,
    siig_t_tracciamento.data_elab,
    siig_t_tracciamento.data_imp_siig,
    siig_t_tracciamento.flg_tipo_imp,
    siig_t_tracciamento.fk_processo,
    siig_t_processo.data_creazione,
    siig_t_processo.data_chiusura_a,
    siig_t_processo.data_chiusura_b,
    siig_t_processo.data_chiusura_c,
    (
        SELECT
            COUNT(*) AS COUNT
        FROM
            siig_t_log
        WHERE
            (
                siig_t_log.id_tracciamento = siig_t_tracciamento.id_tracciamento)) AS errors
FROM
    (((siig_t_tracciamento
JOIN
    siig_d_partner
ON
    (((
                siig_t_tracciamento.fk_partner)::text = (siig_d_partner.id_partner)::text)))
LEFT JOIN
    siig_t_bersaglio
ON
    ((
            siig_t_tracciamento.fk_bersaglio = siig_t_bersaglio.id_bersaglio)))
JOIN
    siig_t_processo
ON
    ((
            siig_t_tracciamento.fk_processo = siig_t_processo.id_processo)))
WHERE
    (
        siig_t_tracciamento.id_tracciamento IN
        (
            SELECT
                MAX(siig_t_tracciamento.id_tracciamento) AS id
            FROM
                siig_t_tracciamento
            GROUP BY
                siig_t_tracciamento.nome_file));
                
                
CREATE VIEW
    "import_metadata_errors"
    (
        "nome_file",
        "id_tracciamento",
        "progressivo",
        "codice_log",
        "descr_errore",
        "id_tematico_shape_orig"
    ) AS
SELECT
    siig_t_tracciamento.nome_file,
    siig_t_log.id_tracciamento,
    siig_t_log.progressivo,
    siig_t_log.codice_log,
    siig_t_log.descr_errore,
    siig_t_log.id_tematico_shape_orig
FROM
    (siig_t_log
JOIN
    siig_t_tracciamento
ON
    ((
            siig_t_log.id_tracciamento = siig_t_tracciamento.id_tracciamento)));
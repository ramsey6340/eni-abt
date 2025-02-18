-- L'exploitation la plus grande en terme de superficie avec la liste de ses employés
WITH superficie_total_table AS (
    SELECT 
        ex.nom_expl AS nom_exploitation, 
        e.num_ss_em AS numero_employe,
		e.nom_em AS nom_employe,
		e.prenom_em AS prenom_employe,
		e.num_tel_em AS numero_telephone,
        SUM(parc.superficie_parc) AS superficie_total
    FROM 
        parcelle parc
    JOIN 
        exploitation ex ON parc.num_expl = ex.num_expl
    JOIN 
        temps_de_travail tt ON tt.num_expl = ex.num_expl
    JOIN 
        employe e ON e.num_ss_em = tt.num_ss_em
    GROUP BY 
        ex.nom_expl, e.num_ss_em
)
SELECT *
FROM superficie_total_table
WHERE superficie_total = (
    SELECT MAX(superficie_total)
    FROM superficie_total_table
)
ORDER BY superficie_total DESC;


-- L'exploitation qui a le plus d'employé
SELECT ex.nom_expl, COUNT(tt.num_ss_em) AS nbre_emp
FROM exploitation ex
JOIN temps_de_travail tt ON tt.num_expl=ex.num_expl
GROUP BY ex.nom_expl
ORDER BY nbre_emp DESC
LIMIT 1;
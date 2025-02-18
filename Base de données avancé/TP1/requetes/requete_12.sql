-- Le temps moyen de travail des employés, pour chaque exploitation
-- dont le  moyen de travail est supérieur à 320 heures
SELECT 
	ex.num_expl AS numero_expl,
	ex.nom_expl AS nom_exploitation,
	AVG(tt.nbre_heure ) AS temps_moyen
FROM exploitation ex
JOIN temps_de_travail tt ON tt.num_expl=ex.num_expl
WHERE (
	SELECT 
		AVG(tt2.nbre_heure )
	FROM exploitation ex2
	JOIN temps_de_travail tt2 ON tt2.num_expl=ex2.num_expl
	WHERE ex2.num_expl=ex.num_expl
	) > 320
GROUP BY numero_expl, ex.nom_expl


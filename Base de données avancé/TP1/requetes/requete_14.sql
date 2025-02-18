-- Il y'a combien de proprietaire ayant une parcelle dans toutes les exploitations de Bamako
SELECT 
	pro.num_ss_pro AS numero_proprietaire,
	pro.nom_prop AS nom_proprietaire,
	pro.prenom_prop AS prenom_proprietaire,
	COUNT(*) AS nbre_proprietaire
FROM proprietaire pro
JOIN appartenance app ON app.num_ss_pro=pro.num_ss_pro
JOIN parcelle p ON p.num_parc=app.num_parc
JOIN exploitation ex1 ON (ex1.num_expl=p.num_expl AND ex1.num_expl IN (SELECT ex.num_expl 
																	FROM exploitation ex
																	JOIN region r ON r.num_region=ex.num_region 
																	AND r.nom_region='Bamako')
						)
GROUP BY pro.num_ss_pro



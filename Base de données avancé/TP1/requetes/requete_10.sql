-- Les proprietaire ayant une parcelle dans la même region que M.DIAWARA
SELECT DISTINCT
	pro.num_ss_pro AS numero_proprietaite,
	pro.nom_prop AS nom_proprietaire,
	pro.prenom_prop AS prenom_proprietaire
FROM proprietaire pro
JOIN appartenance app ON app.num_ss_pro=pro.num_ss_pro
JOIN parcelle p ON p.num_parc=app.num_parc
JOIN exploitation ex ON ex.num_expl=p.num_expl
JOIN region r ON (r.num_region=ex.num_region AND r.nom_region = (SELECT DISTINCT r.nom_region FROM region r
		JOIN exploitation ex ON ex.num_region=r.num_region
		JOIN parcelle p ON p.num_expl=ex.num_expl
		JOIN appartenance app ON app.num_parc=p.num_parc
		JOIN proprietaire pro ON (pro.num_ss_pro= app.num_ss_pro AND pro.nom_prop='Diawara')
	))
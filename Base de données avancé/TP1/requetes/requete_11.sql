-- Les exploitation ayant un nombre de visite plus élevé que toutes les exploitations de Bamako
SELECT 
	ex.num_expl AS numero_exploitation,
	ex.nom_expl AS nom_exploitation,
	ex.nbre_visite 
FROM exploitation ex
WHERE ex.nbre_visite > (SELECT MAX(ex.nbre_visite)
						FROM exploitation ex
						JOIN region r ON (r.num_region=ex.num_region AND r.nom_region='Bamako'))
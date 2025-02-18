-- Liste des employés à kayes, groupé par exploitation dans l'orde décroissant
SELECT 
	ex.num_expl AS numero_exploitation,
	ex.nom_expl AS nom_exploitation,
	e.num_ss_em AS numero_employe,
	e.nom_em AS nom_employe,
	e.prenom_em AS prenom_employe
FROM employe e
JOIN temps_de_travail tt ON tt.num_ss_em=e.num_ss_em
JOIN exploitation ex ON ex.num_expl=tt.num_expl
JOIN region r ON r.num_region=ex.num_region AND r.nom_region='Kayes'
GROUP BY numero_exploitation, numero_employe
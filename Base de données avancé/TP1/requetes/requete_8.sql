-- Les employés résident à Bamako, avec un nombre d'heure de travaille
-- supérieur à 275 heures depuis 2 mois
SELECT 
	e.num_ss_em AS numero,
	e.nom_em AS nom_employe,
	e.prenom_em AS prenom_employe,
	SUM(tt.nbre_heure) AS nbre_heure
FROM employe e
JOIN temps_de_travail tt ON tt.num_ss_em=e.num_ss_em
JOIN region r ON r.nom_region='Bamako'
WHERE nbre_heure>275 AND tt.date_embauche>=(CURRENT_DATE - INTERVAL'2 months')
GROUP BY e.num_ss_em
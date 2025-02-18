-- Les proprietaire n'ayant visité aucune exploitation
SELECT 
	prop.num_ss_pro AS numero_proprietaire,
	prop.nom_prop AS nom_proprietaire,
	prop.prenom_prop AS prenom_proprietaire
FROM proprietaire prop
LEFT JOIN visite v ON prop.num_ss_pro=v.num_ss_pro
WHERE v.num_ss_pro IS NULL
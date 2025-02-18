-- Triez les employés travaillant dans l'exploitation Togouna depuis 1/4/98
SELECT 
	e.num_ss_em AS numero,
	e.nom_em AS nom,
	e.prenom_em AS prenom,
	e.num_tel_em AS numero_telephone,
	e.adr_em AS adresse
FROM employe e
JOIN temps_de_travail tt ON e.num_ss_em=tt.num_ss_em
JOIN exploitation ex ON ex.num_expl=tt.num_expl
WHERE tt.date_embauche<='1998-04-01' AND ex.nom_expl='Togouna'
ORDER BY nom ASC
;
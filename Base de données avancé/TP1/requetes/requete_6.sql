-- Liste des propriétaire triés sur le cumul décroissant des superficies total posseder
SELECT 
    prop.num_ss_pro AS numero,
    prop.nom_prop AS nom_proprietaire,
    prop.prenom_prop AS prenom_proprietaire, 
    SUM(p.superficie_parc) AS superficie_total
FROM proprietaire prop
JOIN appartenance app ON app.num_ss_pro=prop.num_ss_pro
JOIN parcelle p ON p.num_parc=app.num_parc
GROUP BY numero, nom_proprietaire
ORDER BY superficie_total DESC
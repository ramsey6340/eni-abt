-- Liste de tous les employés groupé par le nom de l'exploitation qui les emploie
SELECT 
    ex.nom_expl AS nom_exploitation, 
    e.num_ss_em AS numero_employe,
    e.nom_em AS nom_employe, 
    e.prenom_em AS prenom_employe
FROM temps_de_travail tt
JOIN employe e ON e.num_ss_em=tt.num_ss_em
JOIN exploitation ex ON ex.num_expl=tt.num_expl
GROUP BY nom_exploitation, numero_employe
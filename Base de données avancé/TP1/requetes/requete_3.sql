-- Liste des employés avec le cas échéant le nombre d'heures travaillées depuis 2mois
SELECT e.num_ss_em AS Numero, e.nom_em AS Nom,
    SUM(2*(tt.nbre_heure/((EXTRACT(YEAR FROM age(CURRENT_DATE, tt.date_embauche))*12) + EXTRACT(MONTH FROM age(CURRENT_DATE, tt.date_embauche))))) AS Nbre_heure_travaillee
FROM employe e
JOIN temps_de_travail tt ON tt.num_ss_em=e.num_ss_em
GROUP BY Numero, Nom;

SELECT
    p1.num_parc AS "Numéro_Parcelle_1",
    p1.superficie_parc AS "Superficie_Parcelle_1",
    p2.num_parc AS "Numéro_Parcelle_2",
    p2.superficie_parc AS "Superficie_Parcelle_2"
FROM 
    Parcelle p1
JOIN 
    Parcelle p2 ON p1.superficie_parc = p2.superficie_parc 
WHERE 
    p1.num_parc != p2.num_parc
ORDER BY 
    p1.superficie_parc, p1.num_parc, p2.num_parc;
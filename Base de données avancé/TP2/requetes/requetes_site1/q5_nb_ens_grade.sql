-- Nombre d'enseignants par grade dans les deux grandes écoles
SELECT 
    NomGE,
    Grade,
    COUNT(*) AS Nombre_Enseignants
FROM (
    -- Données de la base distante
    SELECT 
        e.NomGE,
        e.Grade
    FROM dblink(
            'dbname=db_eniabt host=192.168.109.1 port=5432 user=Serveur password=S20232024',
            'SELECT Enum, Nom, Prenom, Grade, NomGE, Pcode FROM Enseignant'
        ) 
        AS e(Enum INT, Nom VARCHAR, Prenom VARCHAR, Grade VARCHAR, NomGE VARCHAR, Pcode INT)
    
    UNION ALL

    -- Données locales
    SELECT 
        NomGE,
        Grade
    FROM Enseignant
) AS combined
WHERE NomGE IN ('ENI-ABT', 'ENETP')
GROUP BY NomGE, Grade
ORDER BY NomGE, Grade;

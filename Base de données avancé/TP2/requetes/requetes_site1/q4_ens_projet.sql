-- Création de la vue materialisé Ens_projet
CREATE MATERIALIZED VIEW Ens_projet AS
SELECT 
    p.Titre,
    p.Descripteur,
    e.Nom,
    e.Prenom
FROM 
    dblink(
        'dbname=db_eniabt host=192.168.109.1 port=5432 user=Serveur password=S20232024',
        'SELECT Pcode, Titre, Descripteur, NomGE, Annee FROM Projet'
    ) 
    AS p(Pcode INT, Titre VARCHAR, Descripteur TEXT, NomGE VARCHAR, Annee INT)
JOIN 
    dblink(
        'dbname=db_eniabt host=192.168.109.1 port=5432 user=Serveur password=S20232024',
        'SELECT Enum, Nom, Prenom, Grade, NomGE, Pcode FROM Enseignant'
    ) 
    AS e(Enum INT, Nom VARCHAR, Prenom VARCHAR, Grade VARCHAR, NomGE VARCHAR, Pcode INT)
ON 
    p.Pcode = e.Pcode;

--REFRESH MATERIALIZED VIEW Ens_projet;

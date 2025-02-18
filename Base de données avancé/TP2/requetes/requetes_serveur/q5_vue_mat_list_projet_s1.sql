--Création d'une vue matrialisé des projets du Site1
CREATE MATERIALIZED VIEW Repl AS
SELECT *
FROM dblink('dbname=db_enetp host=192.168.109.128 port=5432 user=Client password=C20232024',
            'SELECT Pcode, Titre, Descripteur, NomGE, Annee FROM Projet')
AS t(Pcode INT, Titre VARCHAR, Descripteur TEXT, NomGE VARCHAR, Annee INT);

-- Pour automatiser la mise à jour hebdomadaire de cette vue matérialisée,
            -- vous pouvez utiliser le planificateur de tâches de votre système d'exploitation pour exécuter périodiquement
            -- la commande suivante : REFRESH MATERIALIZED VIEW Repl;
--Afficher le nombre de projets du site Client
SELECT COUNT(*) FROM dblink('dbname=db_enetp host=192.168.109.128 port=5432 user=Client password=C20232024',
                            'SELECT * FROM Projet')
            AS t(Pcode INT, Titre VARCHAR, Descripteur TEXT, NomGE VARCHAR, Annee INT);
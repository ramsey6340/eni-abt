-- A) CONFIGURATION ENTRE UN SERVEUR ET UN CLIENT
    -- 3) Windows + R ==> ncpa.cpl ==> Clique droit sur le type de réseau (WIFI ou Ethernet) ==>
        -- Propriétés ==> double clique sur "Protocole Internet version 4 (TCP/Ipv4)" ==> coché "Utilisé l'adresse IP suivant :" et renseigné les valeurs
    -- 5 et 6) Il faut modifier les fichiers suivant:
                -- postgresql.conf : listen_addresses = '*'
                -- pg_hba.conf : host    all             all             192.168.1.0/24          md5
    -- Etape supplementaire : 
        -- 1) Activer Telnet (Pas important): Windows + R ==> Programmes ==> Programmes et fonctionnalités ==> Activer ou desactiver des fonctionnalités windows ==> Cocher "Client Telnet"
        -- 2) Ouvrir le port 5432 : Rechercher "Pare-feu Windows Defender avec fonctionnalités avancées de sécurité" ==> Règle de trafic entrant ==> Nouvelle règle ==> ...

-- B) CREATION DE DATA LINK ENTRE LE SERVEUR ET LE CLIENT
    -- 1) Création du compte Client sur le site 1
            CREATE USER "Client" WITH PASSWORD 'C20232024';
            GRANT ALL PRIVILEGES ON DATABASE db_client TO "Client";
    -- 2) Création du compte Serveur sur serveur
            CREATE USER "Serveur" WITH PASSWORD 'S20232024';
            GRANT ALL PRIVILEGES ON DATABASE db_serveur TO "Serveur";
    -- 3) Création d'un data link entre le serveur et le client
            CREATE EXTENSION IF NOT EXISTS dblink; -- ajout de l'extension dblink
            SELECT dblink_connect('dbname=db_client host=192.168.1.100 port=5432 user=Client password=C20232024');
    -- 4) Création d'un data link entre le client et le serveur
            CREATE EXTENSION IF NOT EXISTS dblink; -- ajout de l'extension dblink
            SELECT dblink_connect('dbname=db_serveur host=192.168.1.8 port=5432 user=Serveur password=S20232024');

-- C) CREATION DE BASE DE DONNNEES REPARTIE
    -- 1) Création de la table Projet et Insertion de données
        -- Création de la table Projet
        CREATE TABLE Projet (
                Pcode SERIAL PRIMARY KEY,
                Titre VARCHAR(255),
                Descripteur TEXT,
                NomGE VARCHAR(100),
                Annee INT
        );

        CREATE TABLE Enseignant (
                Enum SERIAL PRIMARY KEY,
                Nom VARCHAR(50),
                Prenom VARCHAR(50),
                Grade VARCHAR(100),
                NomGE VARCHAR(10),
                Pcode INT REFERENCES Projet(Pcode)
        );

        -- Insertion de 7 projets
        INSERT INTO Projet (Titre, Descripteur, NomGE, Annee)
        VALUES 
        ('Projet A', 'Description du projet A', 'ENI-ABT', 2023),
        ('Projet B', 'Description du projet B', 'ENI-ABT', 2023),
        ('Projet C', 'Description du projet C', 'ENI-ABT', 2023),
        ('Projet D', 'Description du projet D', 'ENI-ABT', 2023),
        ('Projet E', 'Description du projet E', 'ENI-ABT', 2023),
        ('Projet F', 'Description du projet F', 'ENI-ABT', 2024),
        ('Projet G', 'Description du projet G', 'ENI-ABT', 2024);

        -- Insertion de 7 enseignants
        INSERT INTO Enseignant (Nom, Prenom, Grade, NomGE, Pcode)
        VALUES
        ('Traoré', 'Drissa Sidiki', 'Professeur', 'ENI-ABT', 1),
        ('Coulibaly', 'Aïssatou', 'Maître de conférences', 'ENI-ABT', 2),
        ('Diarra', 'Seydou', 'Assistant', 'ENETP', 3),
        ('Dembélé', 'Kadiatou', 'Chargée de cours', 'ENETP', 4),
        ('Diallo', 'Modibo', 'Professeur', 'ENI-ABT', 5),
        ('Koné', 'Awa', 'Maître de conférences', 'ENETP', 6),
        ('Keïta', 'Mariam', 'Assistante', 'ENI-ABT', 7);

    -- 2) Afficher le nombre de projets du site Client
            SELECT COUNT(*) FROM dblink('dbname=db_client host=192.168.1.100 port=5432 user=Client password=C20232024',
                                'SELECT * FROM Projet')
                                AS t(Pcode INT, Titre VARCHAR, Descripteur TEXT, NomGE VARCHAR, Annee INT);
    -- 3) Création d'une vue matrialisé des projets du Site1
            CREATE MATERIALIZED VIEW Repl AS
            SELECT *
            FROM dblink('dbname=db_client host=192.168.1.100 port=5432 user=Client password=C20232024',
                        'SELECT Pcode, Titre, Descripteur, NomGE, Annee FROM Projet')
            AS t(Pcode INT, Titre VARCHAR, Descripteur TEXT, NomGE VARCHAR, Annee INT);
            -- Pour automatiser la mise à jour hebdomadaire de cette vue matérialisée,
            -- vous pouvez utiliser le planificateur de tâches de votre système d'exploitation pour exécuter périodiquement
            -- la commande suivante :
            REFRESH MATERIALIZED VIEW Repl;

    -- 4) Création de la vue matérialisée "Ens_projet"
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

                REFRESH MATERIALIZED VIEW Ens_projet;

            -- Pour automatiser la mise à jour de cette vue matérialisée tous les trois jours,
            -- vous pouvez utiliser le planificateur de tâches de votre système d'exploitation pour exécuter périodiquement la commande
            -- suivante :
            REFRESH MATERIALIZED VIEW Ens_projet;
    -- 5) Les nombres d'enseignant par grade dans les deux GE
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











    CREATE EXTENSION IF NOT EXISTS dblink;

    GRANT SELECT ON Projet TO "Client";

    SELECT dblink_connect('dbname=db_client host=192.168.1.100 port=5432 user=Client password=C20232024');

    SELECT * FROM dblink('dbname=db_client host=192.168.1.100 port=5432 user=Client password=C20232024',
                        'SELECT * FROM Projet')
                        AS t(Pcode INT, Titre VARCHAR, Descripteur TEXT, NomGE VARCHAR, Annee INT);

    -- Deconnexion
    SELECT dblink_disconnect();

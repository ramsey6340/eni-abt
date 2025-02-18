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
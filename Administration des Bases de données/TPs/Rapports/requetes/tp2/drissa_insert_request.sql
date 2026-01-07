-- -----------------------------------------------------
-- Data for table EQUIPES
-- -----------------------------------------------------
INSERT INTO `EQUIPES` 
(`idNumEquipe`, `nomEquipe`) 
VALUES
('e1', 'Base de données'),
('e2', 'Réseaux'),
('e3', 'Système d’informations');


-- -----------------------------------------------------
-- Data for table CHERCHEURS
-- -----------------------------------------------------
INSERT INTO `CHERCHEURS` 
(`idNumChercheur`, `nomChercheur`, `specialite`, `universite`, `idNumEquipe`) 
VALUES 
('c1', 'Goita',     'bd', 2, 'e1'),
('c2', 'Sacko',     'si', 2, 'e3'),
('c3', 'Maiga',     'oo', 3, 'e1'),
('c4', 'Coulibaly', 'rx', 2, 'e2'),
('c5', 'Haidara',   'rx', 3, 'e2'),
('c6', 'Doumbia',   'oo', 1, 'e3'),
('c7', 'Traore',    'oo', 2, 'e1'),
('c8', 'Kamaté',    'si', 3, 'e3');


-- -----------------------------------------------------
-- Data for table PROJETS
-- -----------------------------------------------------
INSERT INTO `PROJETS` 
(`idNumProjet`, `nomProjet`, `idNumEquipe`, `idNumCherResp`) 
VALUES 
('p1', 'objet-relationnel', 'e1', 'c7'),
('p2', 'intranet',          'e1', 'c3'),
('p3', 'sans fil',          'e2', 'c4'),
('p4', 'groupware',         'e3', 'c2'),
('p5', 'uml',               'e3', 'c8'),
('p6', 'datamining',        'e1', NULL);

-- -----------------------------------------------------
-- Data for table TRAVAILLER
-- -----------------------------------------------------
INSERT INTO `TRAVAILLER` 
(`idNumProjet`, `idNumChercheur`, `nbJourSem`) 
VALUES
('p1', 'c1', 1),
('p2', 'c1', 2),
('p3', 'c4', 2),
('p3', 'c5', 1),
('p4', 'c2', 3),
('p4', 'c8', 1),
('p5', 'c8', 3),
('p5', 'c2', 1),
('p1', 'c3', 3),
('p1', 'c7', 3),
('p2', 'c7', 2);

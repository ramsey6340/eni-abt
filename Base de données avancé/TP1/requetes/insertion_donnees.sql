INSERT INTO proprietaire(nom_prop, prenom_prop, num_tel_prop, adr_prop) VALUES 
('Maiga', 'Allassane', 66587952, 'Bamako'),
('Traore', 'Drissa Sidiki', 78541269, 'Yirimadjo'),
('Traore', 'Founè', 75412025, 'Medina koura'),
('Coulibaly', 'fatoumata', 65789415, 'segou'),
('Coulibaly', 'Awa', 78459645, 'Missabougou'),
('Toure', 'Oumou', 79459445, 'Daoudabougou'),
('Diawara', 'ibrahim', 78684501, 'sikasso'),
('Diarra', 'Moussa', 66779955, 'Mopti'),
('Marigo', 'Djara', 77554488, 'kidal'),
('sy', 'Alou', 66002215, 'koulikoro')
;
INSERT INTO region(nom_region, superficie_region, population) VALUES 
('Kayes', 4561.18, 5487),
('Koulikoro', 48724.78, 54789),
('Sikasso', 45885.45,78485),
('Mopti', 879445.47,15887),
('GAO', 178545.78,47558),
('Segou', 174599.21,8529),
('Tombouctou', 17548.48,369745),
('Kidal', 17854.74, 78512),
('Taoudeni', 6978.78,257864),
('Bamako', 14785.14, 175469);
INSERT INTO exploitation(nom_expl, code_postal, nbre_visite, adr_expl, bd, num_region) VALUES 
('Arachide', 001, 4, 'Segou', 'bd1', 1),
('Togouna', 002, 7, 'Mopti', 'bd2', 2),
('Maïs', 003, 2, 'Kaye', 'bd3', 3),
('Riz', 004, 3, 'Sikasso', 'bd4', 4),
('Mill', 005, 7, 'Sikasso', 'bd5', 5),
('Orange', 006, 5, 'BAMAKO', 'bd6', 10),
('Blé', 007, 20, 'Tombouctou', 'bd7',7),
('Fonio', 008, 4, 'Taoudeni', 'bd8', 8),
('Banane', 009, 6, 'Koulikoro', 'bd9', 9),
('Haricot', 010, 8, 'Bamako', 'bd10', 10);
INSERT INTO parcelle(nom_parc, superficie_parc, t_nitrate, t_potassium, t_phosphate, t_calcium, t_magnesium, t_sulfure, num_expl) VALUES 
('A001', 54.3, 2.0, 7.0, 14.0, 8.0, 0.0, 0.0, 4),
('A002', 350, 5.0, 8.0, 8.0, 6.2, 2.0, 8.0, 2),
('A003', 12.0, 6.2, 7.0, 7.0, 4.0, 0.0, 0.0, 6),
('A004', 14.8, 7.0, 9.2, 4.0, 21.0, 6.0, 14.6, 5),
('A005', 13.2, 9.2, 14.0, 9.7, 10.0, 8.4, 0.0, 6),
('A006', 54.3, 10.0, 5.0, 8.0, 8.9, 0.0, 21.0, 2),
('A007', 12.0, 12.3, 4.0, 2.0, 14.0, 10.0, 0.0, 3),
('A008', 14.0, 4.0, 5.0, 10.0, 13.0, 0.0, 9.0, 1),
('A009', 120.0, 9.0, 8.0, 9.0, 0.0, 2.2, 0.0, 6),
('A0010', 120.0, 10.2, 10.0, 0.0, 8.0, 0.0, 4.0, 7);
INSERT INTO employe(nom_em, prenom_em, num_tel_em, adr_em, num_region) VALUES 
('Diarra', 'Moussa', 75489614, 'lafiabougou', 3),
('Foune', 'Haïdara', 76219420, 'ATTbougou', 5),
('Drissa', 'Touré', 78549617, 'Darsalame', 10),
('Samba', 'Sow', 64598720, 'Djelibougou', 9),
('Fatou', 'DAOU', 67954210, 'Daoudabougou', 7),
('Aminata', 'Dicko', 98145260, 'lareine', 10),
('Raby', 'Cissé', 94351260, 'Farakoro', 4),
('Issa', 'Diawara', 91879640, 'Titibougou', 2),
('Aba', 'Gaba', 83459670, 'Banankabougou', 1),
('Salimata', 'Dia', 81369470, 'Niamakoro', 10);
INSERT INTO appartenance(date_app, num_parc, num_ss_pro) VALUES 
('1998-10-24', 5, 1),
('1999-08-10', 3, 1),
('2000-05-15', 2, 3),
('1999-11-19', 6, 4),
('1998-05-11', 4, 5),
('1997-01-05', 9, 1),
('1999-07-08', 4, 7),
('1999-05-10', 1, 8),
('2001-11-06', 10, 9),
('2002-08-10', 7, 10);
INSERT INTO temps_de_travail(date_embauche, nbre_heure, num_ss_em,num_expl) VALUES 
('2024-09-26', 64800, 5, 10),
('1998-08-05', 100, 6, 2),
('1997-05-15', 64700, 8, 6),
('1998-10-20', 62400, 5, 3),
('1998-05-10', 62000, 1, 1),
('1998-07-10', 10, 3, 2),
('1998-05-02', 250, 2, 2),
('1997-10-09', 64800, 4, 7),
('1998-12-25', 62500, 7, 8),
('2024-10-12', 67200, 10, 9);
INSERT INTO visite(date_visite, num_expl, num_ss_pro) VALUES 
('2001-02-10', 2,3),
('2000-07-20', 6, 1),
('2000-08-02', 3, 4),
('2001-10-25', 10, 6),
('2000-05-15', 5, 7),
('2002-01-02', 9, 5),
('2001-03-30', 6, 2),
('2000-03-10', 2, 5),
('2002-04-15', 6, 9),
('2000-01-18', 5, 5);
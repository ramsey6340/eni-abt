CREATE TABLE proprietaire(
	num_ss_pro SERIAL PRIMARY KEY,
	nom_prop VARCHAR(50),
	prenom_prop VARCHAR(50),
	num_tel_prop INT,
	adr_prop VARCHAR(50)
);

CREATE TABLE region(
	num_region SERIAL PRIMARY KEY,
	nom_region VARCHAR(50),
	superficie_region NUMERIC,
	population BIGINT
);

CREATE TABLE exploitation(
	num_expl SERIAL PRIMARY KEY,
	nom_expl VARCHAR(50),
	code_postal INT,
	nbre_visite INT,
	adr_expl VARCHAR(50),
	bd VARCHAR(50),
	num_region INT,
	FOREIGN KEY(num_region) REFERENCES region(num_region)
);

CREATE TABLE parcelle(
	num_parc SERIAL PRIMARY KEY,
	nom_parc VARCHAR(50),
	superficie_parc NUMERIC,
	t_nitrate NUMERIC,
	t_potassium NUMERIC,
	t_phosphate NUMERIC,
	t_calcium NUMERIC,
	t_magnesium NUMERIC,
	t_sulfure NUMERIC,
	num_expl INT,
	FOREIGN KEY(num_expl) REFERENCES exploitation(num_expl)
);

CREATE TABLE employe(
	num_ss_em SERIAL PRIMARY KEY,
	nom_em VARCHAR(50),
	prenom_em VARCHAR(50),
	num_tel_em INT,
	adr_em VARCHAR(50),
	num_region INT,
	FOREIGN KEY(num_region) REFERENCES region(num_region)
);
CREATE TABLE appartenance(
	num_parc INT,
	num_ss_pro INT,
	date_app DATE,
	PRIMARY KEY(num_parc, num_ss_pro),
	FOREIGN KEY(num_parc) REFERENCES parcelle(num_parc),
	FOREIGN KEY(num_ss_pro) REFERENCES proprietaire(num_ss_pro)
);
CREATE TABLE temps_de_travail(
	num_ss_em INT,
	num_expl INT,
	date_embauche DATE,
	nbre_heure INT,
	PRIMARY KEY(num_ss_em, num_expl),
	FOREIGN KEY(num_ss_em) REFERENCES employe(num_ss_em),
	FOREIGN KEY(num_expl) REFERENCES exploitation(num_expl)
);

CREATE TABLE visite(
	num_expl INT,
	num_ss_pro INT,
	date_visite DATE,
	PRIMARY KEY(num_expl, num_ss_pro),
	FOREIGN KEY(num_expl) REFERENCES exploitation(num_expl),
	FOREIGN KEY(num_ss_pro) REFERENCES proprietaire(num_ss_pro)
);

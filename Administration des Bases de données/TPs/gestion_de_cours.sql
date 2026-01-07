-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Ven 11 Novembre 2022 à 20:34
-- Version du serveur :  5.7.14
-- Version de PHP :  5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gestion_de_cours`
--

-- --------------------------------------------------------

--
-- Structure de la table `animateur`
--

CREATE TABLE `animateur` (
  `Matricule` char(4) NOT NULL,
  `Nom` char(30) NOT NULL,
  `Prenom` char(30) NOT NULL,
  PRIMARY KEY (`Matricule`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `animateur`
--

INSERT INTO `animateur` (`Matricule`, `Nom`, `Prenom`) VALUES
('m001', 'Goita', 'Yacouba'),
('m002', 'Dabo', 'Alpha'),
('m003', 'Camara', 'Lancine'),
('m004', 'Haidara', 'Balla'),
('m005', 'Kamissoko', 'Drissa');

-- --------------------------------------------------------

--
-- Structure de la table `animer`
--

CREATE TABLE `animer` (
  `Code_cours` char(4) NOT NULL,
  `matricule_animateur` char(4) NOT NULL,
  `nbre_heures` int NOT NULL,
  PRIMARY KEY (`Code_cours`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `animer`
--

INSERT INTO `animer` (`Code_cours`, `matricule_animateur`, `nbre_heures`) VALUES
('C001', 'm002', 20),
('C002', 'M002', 30),
('C003', 'm001', 30),
('C004', 'm003', 20),
('C005', 'm004', 20),
('C006', 'm001', 30),
('C007', 'm005', 30);

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `Code_categorie` char(4) NOT NULL,
  `Libelle` char(50) NOT NULL,
  PRIMARY KEY (`Code_categorie`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `categorie`
--

INSERT INTO `categorie` (`Code_categorie`, `Libelle`) VALUES
('cat1', 'Informatique de gestion'),
('cat2', 'Comptabilite'),
('cat3', 'Organisation et gestion des entreprises');

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

CREATE TABLE `cours` (
  `Code_cours` char(4) NOT NULL,
  `Niveau` char(30) NOT NULL,
  `Date_cours` date NOT NULL,
  `Tarif_hr` int NOT NULL,
  `Prime_resp` int NOT NULL,
  `Droit_inscrip` int NOT NULL,
  `Code_theme` char(4) NOT NULL,
  `Matricule_anim` char(4) NOT NULL,
  PRIMARY KEY (`Code_cours`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `cours`
--

INSERT INTO `cours` (`Code_cours`, `Niveau`, `Date_cours`, `Tarif_hr`, `Prime_resp`, `Droit_inscrip`, `Code_theme`, `Matricule_anim`) VALUES
('C001', 'd', '2022-04-10', 7500, 1000, 500, 't001', 'm002'),
('C002', 'd', '2022-04-15', 7500, 1000, 500, 't002', 'm002'),
('C003', 'i', '2022-04-16', 7500, 1500, 1000, 't003', 'm001'),
('C004', 'i', '2022-04-22', 7500, 1500, 1000, 't004', 'm003'),
('C005', 'i', '2022-04-25', 7500, 1500, 1000, 't005', 'm004'),
('C006', 'a', '2022-04-27', 10000, 1500, 1000, 't006', 'm001'),
('C007', 'a', '2022-05-02', 10000, 1500, 1000, 't007', 'm005');

-- --------------------------------------------------------

--
-- Structure de la table `entreprise`
--

CREATE TABLE `entreprise` (
  `Code_entreprise` char(5) NOT NULL,
  `Nom` char(30) NOT NULL,
  `Adresse` char(50) NOT NULL,
  PRIMARY KEY (`Code_entreprise`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `entreprise`
--

INSERT INTO `entreprise` (`Code_entreprise`, `Nom`, `Adresse`) VALUES
('40000', 'M3', 'Segou coura'),
('40001', 'CSCOM', 'Centre ville'),
('03336', 'Bramali', 'Senou'),
('10005', 'Usine CMDT', 'Kita sortie'),
('50010', 'Academie', 'MillionKin');

-- --------------------------------------------------------

--
-- Structure de la table `participants`
--

CREATE TABLE `participants` (
  `Matricule_P` char(4) NOT NULL,
  `Nom` char(30) NOT NULL,
  `Prenom` char(30) NOT NULL,
  `Localite` char(40) NOT NULL,
  `Code_entreprise` int NOT NULL,
  PRIMARY KEY (`Matricule_P`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `participants`
--

INSERT INTO `participants` (`Matricule_P`, `Nom`, `Prenom`, `Localite`, `Code_entreprise`) VALUES
('p001', 'Diallo', 'Sekou', 'Segou', 40000),
('p002', 'Diassana', 'Togobe', 'Tomian', 40001),
('p003', 'Ba', 'Therno', 'Segou', 40000),
('p004', 'Diarra', 'Djeneba', 'Bamako', 3336),
('p005', 'Konate', 'Solo', 'Kita', 10005),
('p006', 'Dembele', 'Moriba', 'Kita', 10005),
('p007', 'Tomota', 'Sira', 'Mopti', 50010);

-- --------------------------------------------------------

--
-- Structure de la table `participer`
--

CREATE TABLE `participer` (
  `Code-cours` CHAR(4) NOT NULL,
  `Matricule_P` CHAR(4) NOT NULL,
  PRIMARY KEY (`Code-cours`, `Matricule_P`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


--
-- Contenu de la table `participer`
--

INSERT INTO `participer` (`Code-cours`, `Matricule_P`) VALUES
('C001', 'p005'),
('C001', 'p006'),
('C003', 'p001'),
('C004', 'p007'),
('C006', 'p005'),
('C006', 'p006'),
('C007', 'p001'),
('C007', 'p002'),
('C007', 'p003');

-- --------------------------------------------------------

--
-- Structure de la table `theme`
--

CREATE TABLE `theme` (
  `Code_theme` char(4) NOT NULL,
  `Designation` char(50) NOT NULL,
  `Code_entreprise` char(4) NOT NULL,
  PRIMARY KEY (`Code_theme`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `theme`
--

INSERT INTO `theme` (`Code_theme`, `Designation`, `Code_entreprise`) VALUES
('t001', 'Prise en main du logiciel', 'cat1'),
('t002', 'Travail pratique', 'cat1'),
('t003', 'Concept avancé', 'cat1'),
('t004', 'Travail pratique', 'cat1'),
('t005', 'Travail pratique', 'cat1'),
('t006', 'Conception', 'cat1'),
('t007', 'Realisation', 'cat1');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

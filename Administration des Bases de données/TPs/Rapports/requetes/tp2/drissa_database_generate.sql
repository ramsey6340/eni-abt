-- MySQL Script corrected version
-- TP2 - Administration de base de données relationnelles

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema universite_recherche_eni_abt_m2s3_dr_goita_abd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universite_recherche_eni_abt_m2s3_dr_goita_abd` DEFAULT CHARACTER SET utf8;
USE `universite_recherche_eni_abt_m2s3_dr_goita_abd`;

-- -----------------------------------------------------
-- Table EQUIPES
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EQUIPES` (
  `idNumEquipe` VARCHAR(8) NOT NULL,
  `nomEquipe` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idNumEquipe`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table CHERCHEURS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CHERCHEURS` (
  `idNumChercheur` VARCHAR(11) NOT NULL,
  `nomChercheur` VARCHAR(10) NOT NULL,
  `specialite` VARCHAR(10) NULL,
  `universite` INT NULL,
  `idNumEquipe` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`idNumChercheur`),
  INDEX `fk_CHERCHEURS_EQUIPE_idx` (`idNumEquipe` ASC),
  CONSTRAINT `fk_CHERCHEURS_EQUIPE`
    FOREIGN KEY (`idNumEquipe`)
    REFERENCES `EQUIPES` (`idNumEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PROJETS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJETS` (
  `idNumProjet` VARCHAR(8) NOT NULL,
  `nomProjet` VARCHAR(20) NULL,
  `idNumEquipe` VARCHAR(8) NOT NULL,
  `idNumCherResp` VARCHAR(11) NULL,
  PRIMARY KEY (`idNumProjet`),
  INDEX `fk_PROJETS_EQUIPE_idx` (`idNumEquipe` ASC),
  INDEX `fk_PROJETS_RESP_idx` (`idNumCherResp` ASC),
  CONSTRAINT `fk_PROJETS_EQUIPE`
    FOREIGN KEY (`idNumEquipe`)
    REFERENCES `EQUIPES` (`idNumEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJETS_RESP`
    FOREIGN KEY (`idNumCherResp`)
    REFERENCES `CHERCHEURS` (`idNumChercheur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table TRAVAILLER
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TRAVAILLER` (
  `idNumProjet` VARCHAR(8) NOT NULL,
  `idNumChercheur` VARCHAR(11) NOT NULL,
  `nbJourSem` INT NULL,
  PRIMARY KEY (`idNumProjet`, `idNumChercheur`),
  CONSTRAINT `fk_TRAVAILLER_PROJET`
    FOREIGN KEY (`idNumProjet`)
    REFERENCES `PROJETS` (`idNumProjet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRAVAILLER_CHERCHEUR`
    FOREIGN KEY (`idNumChercheur`)chercheurs
    REFERENCES `CHERCHEURS` (`idNumChercheur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
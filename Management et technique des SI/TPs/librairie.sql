-- =============================================
-- BASE DE DONNÉES : Librairie / Gestion de stock livres
-- =============================================

DROP DATABASE IF EXISTS librairie;
CREATE DATABASE librairie CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE librairie;

-- =============================================
-- 1. Table distributeurs
-- =============================================
CREATE TABLE distributeurs (
    id_distributeur   INT AUTO_INCREMENT PRIMARY KEY,
    code_distributeur VARCHAR(20) NOT NULL UNIQUE,
    raison_sociale    VARCHAR(100) NOT NULL,
    adresse           VARCHAR(255) NULL,
    telephone         VARCHAR(20)  NULL
) ENGINE=InnoDB;

-- =============================================
-- 2. Table livres
-- =============================================
CREATE TABLE livres (
    id_livre            INT AUTO_INCREMENT PRIMARY KEY,
    code_livre          VARCHAR(30) NOT NULL UNIQUE,           -- ISBN ou code interne
    titre               VARCHAR(255) NOT NULL,
    auteurs             VARCHAR(255) NOT NULL,                 -- séparés par ; ou ,
    editeur             VARCHAR(100) NOT NULL,
    prix_vente_ht       DECIMAL(10,2) NOT NULL CHECK (prix_vente_ht > 0),
    stock_securite      INT NOT NULL DEFAULT 5,
    quantite_en_stock   INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- =============================================
-- 3. Table commandes (vers les distributeurs)
-- =============================================
CREATE TABLE commandes (
    id_commande       INT AUTO_INCREMENT PRIMARY KEY,
    id_distributeur   INT NOT NULL,
    date_commande     DATE NOT NULL DEFAULT (CURRENT_DATE),
    statut            ENUM('EN_COURS', 'PARTIELLEMENT_LIVREE', 'TERMINEE') NOT NULL DEFAULT 'EN_COURS',
    
    FOREIGN KEY (id_distributeur) REFERENCES distributeurs(id_distributeur)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =============================================
-- 4. Table lignes_commande
-- =============================================
CREATE TABLE lignes_commande (
    id_ligne_commande INT AUTO_INCREMENT PRIMARY KEY,
    id_commande       INT NOT NULL,
    id_livre          INT NOT NULL,
    quantite_commandee INT NOT NULL CHECK (quantite_commandee > 0),
    quantite_livree   INT NOT NULL DEFAULT 0,                -- cumul des livraisons reçues
    
    FOREIGN KEY (id_commande) REFERENCES commandes(id_commande)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_livre) REFERENCES livres(id_livre)
        ON DELETE RESTRICT ON UPDATE CASCADE,
        
    UNIQUE KEY uniq_cmd_livre (id_commande, id_livre)         -- évite doublons dans même commande
) ENGINE=InnoDB;

-- =============================================
-- 5. Table livraisons (réceptions)
-- =============================================
CREATE TABLE livraisons (
    id_livraison              INT AUTO_INCREMENT PRIMARY KEY,
    id_commande               INT NOT NULL,
    date_livraison            DATE NOT NULL,
    num_bon_livraison_dist    VARCHAR(50) NOT NULL UNIQUE,
    
    FOREIGN KEY (id_commande) REFERENCES commandes(id_commande)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =============================================
-- 6. Table lignes_livraison
-- =============================================
CREATE TABLE lignes_livraison (
    id_ligne_livraison       INT AUTO_INCREMENT PRIMARY KEY,
    id_livraison             INT NOT NULL,
    id_livre                 INT NOT NULL,
    quantite_livree          INT NOT NULL CHECK (quantite_livree > 0),
    prix_achat_unitaire_ht   DECIMAL(10,2) NOT NULL CHECK (prix_achat_unitaire_ht > 0),
    
    FOREIGN KEY (id_livraison) REFERENCES livraisons(id_livraison)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_livre) REFERENCES livres(id_livre)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =============================================
-- 7. Table achats (pour la comptabilité - 1 ligne = 1 ligne de livraison validée)
-- =============================================
CREATE TABLE achats (
    id_achat            INT AUTO_INCREMENT PRIMARY KEY,
    id_ligne_livraison  INT NOT NULL,
    date_achat          DATE NOT NULL,                     -- date de signature du bon
    
    FOREIGN KEY (id_ligne_livraison) REFERENCES lignes_livraison(id_ligne_livraison)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    UNIQUE KEY uniq_ligne_livraison (id_ligne_livraison)      -- une seule entrée comptable par ligne livraison
) ENGINE=InnoDB;

-- =============================================
-- 8. Table ventes (tickets de caisse)
-- =============================================
CREATE TABLE ventes (
    id_vente     INT AUTO_INCREMENT PRIMARY KEY,
    date_vente   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_ht     DECIMAL(10,2) NOT NULL,
    total_ttc    DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- =============================================
-- 9. Table lignes_vente
-- =============================================
CREATE TABLE lignes_vente (
    id_ligne_vente          INT AUTO_INCREMENT PRIMARY KEY,
    id_vente                INT NOT NULL,
    id_livre                INT NOT NULL,
    quantite_vendue         INT NOT NULL CHECK (quantite_vendue > 0),
    prix_vente_unitaire_ht  DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (id_vente) REFERENCES ventes(id_vente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_livre) REFERENCES livres(id_livre)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =============================================
-- Index utiles (performances)
-- =============================================
CREATE INDEX idx_livres_titre    ON livres(titre);
CREATE INDEX idx_livres_code     ON livres(code_livre);
CREATE INDEX idx_commandes_date  ON commandes(date_commande);
CREATE INDEX idx_ventes_date     ON ventes(date_vente);
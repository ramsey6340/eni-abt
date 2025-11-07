-- Script d'initialisation de la base de données Gesem
-- Base de données : gesem_db

-- Création de la base de données (à exécuter manuellement si nécessaire)
-- CREATE DATABASE gesem_db;

-- Les tables seront créées automatiquement par JPA avec l'action "update"
-- Ce script permet d'insérer un utilisateur par défaut

-- Insertion d'un utilisateur administrateur par défaut
-- Login: admin
-- Password: admin123
-- Note: En production, le mot de passe doit être hashé

INSERT INTO utilisateur (id, login, password, role) 
VALUES (gen_random_uuid(), 'admin', 'admin123', 'admin')
ON CONFLICT (login) DO NOTHING;


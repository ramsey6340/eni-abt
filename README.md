# Gesem - Gestion des Employés

Application web de gestion des employés développée en Java EE (Jakarta EE) avec architecture MVC.

## Fonctionnalités

### Authentification
- Page de connexion (login / mot de passe)
- Vérification des identifiants dans la table utilisateur
- Gestion de session
- Déconnexion
- Protection des pages par filtre de sécurité

### Gestion des Employés
- Liste de tous les employés
- Ajout d'un nouvel employé
- Modification d'un employé existant
- Supprimer un employé

## Architecture

L'application suit une architecture MVC (Modèle-Vue-Contrôleur) :

- **Modèles** : `User`, `Employe` (package `model`)
- **DAOs** : `UserDAO`, `EmployeDAO` (package `dao`)
- **Contrôleurs** : `LoginServlet`, `LogoutServlet`, `EmployeServlet` (package `controller`)
- **Vues** : JSP dans `WEB-INF/views/`
- **Filtres** : `AuthFilter` pour la sécurité

## Prérequis

- Java 11 ou supérieur
- Maven 3.6+
- PostgreSQL 12+
- Serveur d'application compatible Jakarta EE 9.1 (Tomcat 10+, GlassFish, etc.)

## Configuration

### Base de données

1. Créer la base de données PostgreSQL :
```sql
CREATE DATABASE gesem_db;
```

2. Configurer les paramètres de connexion dans `src/main/resources/META-INF/persistence.xml` :
   - URL : `jdbc:postgresql://localhost:5432/gesem_db`
   - Utilisateur : `postgres` (modifier si nécessaire)
   - Mot de passe : `postgres` (modifier si nécessaire)

### Utilisateur par défaut

Un utilisateur administrateur est créé automatiquement :
- **Login** : `admin`
- **Mot de passe** : `admin123`

⚠️ **Important** : Changez le mot de passe en production !

## Installation et Déploiement

1. Cloner le projet ou extraire les fichiers

2. Compiler le projet :
```bash
mvn clean compile
```

3. Créer le package WAR :
```bash
mvn package
```

4. Déployer le fichier `target/gesem-1.0-SNAPSHOT.war` sur votre serveur d'application

5. Accéder à l'application :
   - URL : `http://localhost:8080/gesem/`
   - Redirection automatique vers `/login`

## Structure du Projet

```
gesem/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/kelenpe/eni/m2/gesem/
│   │   │       ├── model/          # Modèles (User, Employe)
│   │   │       ├── dao/            # Data Access Objects
│   │   │       ├── controller/     # Servlets (contrôleurs)
│   │   │       ├── filter/         # Filtres de sécurité
│   │   │       └── util/           # Utilitaires (JPAUtil)
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml  # Configuration JPA
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── views/          # Vues JSP
│   │       │   └── web.xml         # Configuration web
│   │       ├── css/                # Feuilles de style
│   │       └── index.jsp           # Page d'accueil
│   └── test/
└── pom.xml                         # Configuration Maven
```

## Modèles de Données

### User (utilisateur)
- `id` : UUID (identifiant unique)
- `login` : String (unique)
- `password` : String
- `role` : String

### Employe
- `id` : UUID (identifiant unique)
- `nom` : String
- `prenom` : String
- `poste` : String
- `email` : String (unique)
- `dateEmbauche` : LocalDate

## Technologies Utilisées

- **Java EE (Jakarta EE) 9.1**
- **JPA (EclipseLink)**
- **PostgreSQL**
- **JSP** pour les vues
- **Maven** pour la gestion des dépendances

## Notes

- Les tables sont créées automatiquement au démarrage grâce à `schema-generation.database.action=update`
- Les sessions expirent après 30 minutes d'inactivité
- Les DAOs sont visibles et utilisent EntityManager avec gestion de transactions

## Auteur

Développé dans le cadre du Master 2 - Ingénierie des SI à base de composants


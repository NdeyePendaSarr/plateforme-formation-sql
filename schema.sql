-- ============================================================
-- PARTIE 1 — CRÉATION DE LA BASE ET DES TABLES
-- ============================================================

DROP DATABASE IF EXISTS nps_plateforme_formation;
CREATE DATABASE nps_plateforme_formation;
USE nps_plateforme_formation;


-- ── Table CLASSES ────────────────────────────────────────────
-- Entité principale : une classe regroupe plusieurs apprenants
CREATE TABLE classes (
    id  INT          AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50)  NOT NULL UNIQUE
);


-- ── Table MODULES ────────────────────────────────────────────
-- Entité principale : un module est indépendant d'une classe
-- DECIMAL(5,1) pour gérer les demi-heures (ex: 1.5h)
CREATE TABLE modules (
    id           INT           AUTO_INCREMENT PRIMARY KEY,
    nom          VARCHAR(100)  NOT NULL,
    categorie    VARCHAR(100)  NOT NULL,
    duree_heures DECIMAL(5,1)  NOT NULL
);


-- ── Table CLASSE_MODULE ──────────────────────────────────────
-- Association N-N : programme collectif d'une classe
-- etat = état d'avancement collectif (toute la classe avance ensemble)
CREATE TABLE classe_module (
    classe_id  INT  NOT NULL,
    module_id  INT  NOT NULL,
    etat       ENUM('Non commencé', 'En cours', 'Terminé')
               NOT NULL DEFAULT 'Non commencé',
    PRIMARY KEY (classe_id, module_id),
    FOREIGN KEY (classe_id) REFERENCES classes(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (module_id) REFERENCES modules(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


-- ── Table APPRENANTS ─────────────────────────────────────────
-- Entité principale : chaque apprenant appartient à une classe
-- actif = soft delete (FALSE si apprenant a quitté)
CREATE TABLE apprenants (
    id        INT           AUTO_INCREMENT PRIMARY KEY,
    nom       VARCHAR(100)  NOT NULL,
    prenom    VARCHAR(100)  NOT NULL,
    email     VARCHAR(150)  NOT NULL UNIQUE,
    sexe      ENUM('M','F') NOT NULL,
    adresse   VARCHAR(255),
    classe_id INT           NOT NULL,
    actif     BOOLEAN       NOT NULL DEFAULT TRUE,
    FOREIGN KEY (classe_id) REFERENCES classes(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


-- ── Table INSCRIPTIONS ───────────────────────────────────────
-- Association N-N : acte individuel d'inscription
-- ENUM pour groupe : valeurs contrôlées
-- UNIQUE KEY : un apprenant ne peut s'inscrire qu'une fois par module
CREATE TABLE inscriptions (
    id               INT  AUTO_INCREMENT PRIMARY KEY,
    apprenant_id     INT  NOT NULL,
    module_id        INT  NOT NULL,
    date_inscription DATE NOT NULL,
    groupe           ENUM('G1','G2','G3','G4') NOT NULL,
    UNIQUE KEY uq_inscription (apprenant_id, module_id),
    FOREIGN KEY (apprenant_id) REFERENCES apprenants(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (module_id) REFERENCES modules(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


-- ── Table NOTES ──────────────────────────────────────────────
-- Entité dépendante : indépendante d'INSCRIPTIONS (détection anomalies)
-- CHECK : valeur entre 0 et 20
-- date_evaluation : pour les analyses temporelles
CREATE TABLE notes (
    id               INT           AUTO_INCREMENT PRIMARY KEY,
    valeur           DECIMAL(5,2)  NOT NULL,
    type_note        ENUM('Devoir','Projet','Examen') NOT NULL,
    apprenant_id     INT           NOT NULL,
    module_id        INT           NOT NULL,
    date_evaluation  DATE          NOT NULL,
    CONSTRAINT chk_valeur CHECK (valeur >= 0 AND valeur <= 20),
    FOREIGN KEY (apprenant_id) REFERENCES apprenants(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (module_id) REFERENCES modules(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

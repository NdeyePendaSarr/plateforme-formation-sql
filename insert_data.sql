-- ============================================================
-- PARTIE 2 — INSERTION DES DONNÉES
-- ============================================================


-- ── Insertion CLASSES ────────────────────────────────────────
INSERT INTO classes (nom) VALUES
    ('DEV-DATA'),  
    ('DEV-WEB'),  
    ('DEV-IA');     


-- ── Insertion MODULES ────────────────────────────────────────
INSERT INTO modules (nom, categorie, duree_heures) VALUES
    ('SQL',              'Base de données',  40.0),   
    ('Python',           'Programmation',    60.0),   
    ('Power BI',         'Visualisation',    30.0),   
    ('Web',              'Développement',    50.0),  
    ('Machine Learning', 'Data Science',     45.0),   
    ('Cybersécurité',    'Sécurité',         35.0);   


-- ── Insertion CLASSE_MODULE ──────────────────────────────────
-- DEV-DATA (1) : SQL terminé, Python en cours, Power BI non commencé
-- DEV-WEB  (2) : Web terminé, SQL en cours
-- DEV-IA   (3) : Python terminé, Machine Learning en cours
-- NB : DEV-IA fait Python mais PAS SQL → pour Q16
INSERT INTO classe_module (classe_id, module_id, etat) VALUES
    (1, 1, 'Terminé'),     
    (1, 2, 'En cours'),     
    (1, 3, 'Non commencé'),  
    (2, 4, 'Terminé'),       
    (2, 1, 'En cours'),      
    (3, 2, 'Terminé'),       
    (3, 5, 'En cours');       


-- ── Insertion APPRENANTS ─────────────────────────────────────
-- DEV-DATA : 5 apprenants (id 1 à 5) + Seydina (id 11 → anomalie Q18)
-- DEV-WEB  : 3 apprenants (id 6 à 8)
-- DEV-IA   : 2 apprenants (id 9 à 10) dont Pape (id 10 → exactement 1 module Q12)
-- NB : Seydina est dans DEV-DATA mais aura une note SANS inscription → anomalie
INSERT INTO apprenants (nom, prenom, email, sexe, adresse, classe_id, actif) VALUES
    ('SARR',   'Ndeye Penda', 'ndeye.sarr@odc.sn',      'F', 'Mbour',               1, TRUE),
    ('DIALLO', 'Ousmane',     'ousmane.diallo@odc.sn',   'M', 'Parcelles Assainies', 1, TRUE),
    ('DIABY',  'Moussa',      'moussa.diaby@odc.sn',     'M', 'Guédiawaye',          1, TRUE),
    ('DJIGO',  'Abdou',       'abdou.djigo@odc.sn',      'M', 'Médina',              1, TRUE),
    ('DIALLO', 'Mariama',     'mariama.diallo@odc.sn',   'F', 'Yoff',                1, TRUE),
    ('SOW',    'Ibrahima',    'ibrahima.sow@odc.sn',     'M', 'Grand Yoff',          2, TRUE),
    ('NDIAYE', 'Aminata',     'aminata.ndiaye@odc.sn',   'F', 'Ouakam',              2, TRUE),
    ('FALL',   'Omar',        'omar.fall@odc.sn',        'M', 'Pikine',              2, TRUE),
    ('MBAYE',  'Rokhaya',     'rokhaya.mbaye@odc.sn',    'F', 'Liberté 6',           3, TRUE),
    ('GUEYE',  'Pape',        'pape.gueye@odc.sn',       'M', 'HLM',                 3, TRUE),
    ('WADE',   'Seydina',     'seydina.wade@odc.sn',     'M', 'Dakar',               1, TRUE);



-- ── Insertion INSCRIPTIONS ───────────────────────────────────
-- Ndeye Penda (1) : G1 en SQL, G2 en Python → Q23 (deux groupes différents)
-- Pape (10)       : 1 seul module (Python) → Q12 (exactement un module)
-- Seydina (11)    : AUCUNE inscription → Q13 + Q18
-- DEV-IA          : Python uniquement, pas SQL → Q16
INSERT INTO inscriptions (apprenant_id, module_id, date_inscription, groupe) VALUES
    (1, 1, '2026-01-15', 'G1'),   
    (2, 1, '2026-01-15', 'G2'),
    (3, 1, '2026-01-15', 'G1'),
    (4, 1, '2026-01-15', 'G2'),
    (5, 1, '2026-01-15', 'G1'),
    (1, 2, '2026-02-15', 'G2'),   
    (2, 2, '2026-02-15', 'G1'),
    (3, 2, '2026-02-15', 'G2'),
    (4, 2, '2026-02-15', 'G1'),
    (5, 2, '2026-02-15', 'G2'),
    (1, 3, '2026-03-15', 'G1'),
    (2, 3, '2026-03-15', 'G2'),
    (3, 3, '2026-03-15', 'G1'),
    (4, 3, '2026-03-15', 'G2'),
    (5, 3, '2026-03-15', 'G1'),
    (6, 4, '2026-01-20', 'G1'),
    (7, 4, '2026-01-20', 'G2'),
    (8, 4, '2026-01-20', 'G1'),
    (6, 1, '2026-02-20', 'G2'),
    (7, 1, '2026-02-20', 'G1'),
    (8, 1, '2026-02-20', 'G2'),
    (9,  2, '2026-01-10', 'G1'),
    (10, 2, '2026-01-10', 'G2'),  
    (9,  5, '2026-02-10', 'G1');



-- ── Insertion NOTES ──────────────────────────────────────────
-- Terminé → Devoir + Examen | En cours → Projet
-- Seydina (11) a une note SANS être inscrit → anomalie Q18
INSERT INTO notes (valeur, type_note, apprenant_id, module_id, date_evaluation) VALUES
    (14.00, 'Devoir',  1, 1, '2026-03-01'),  
    (15.00, 'Examen',  1, 1, '2026-03-15'),
    (12.00, 'Devoir',  2, 1, '2026-03-01'),  
    (09.00, 'Examen',  2, 1, '2026-03-15'),
    (16.00, 'Devoir',  3, 1, '2026-03-01'),
    (15.00, 'Examen',  3, 1, '2026-03-15'),
    (13.00, 'Devoir',  4, 1, '2026-03-01'),  
    (11.00, 'Examen',  4, 1, '2026-03-15'),
    (17.00, 'Devoir',  5, 1, '2026-03-01'),  
    (16.00, 'Examen',  5, 1, '2026-03-15'),
    (13.00, 'Projet',  1, 2, '2026-04-10'),  
    (11.00, 'Projet',  2, 2, '2026-04-10'),  
    (14.00, 'Projet',  3, 2, '2026-04-10'), 
    (08.00, 'Projet',  4, 2, '2026-04-10'),  
    (15.00, 'Projet',  5, 2, '2026-04-10'), 
    (13.00, 'Devoir',  6, 4, '2026-03-05'),  
    (14.00, 'Examen',  6, 4, '2026-03-20'),
    (07.00, 'Devoir',  7, 4, '2026-03-05'), 
    (09.00, 'Examen',  7, 4, '2026-03-20'),
    (11.00, 'Devoir',  8, 4, '2026-03-05'), 
    (10.00, 'Examen',  8, 4, '2026-03-20'),
    (12.00, 'Devoir',  6, 1, '2026-04-15'),  
    (10.00, 'Devoir',  7, 1, '2026-04-15'),  
    (08.00, 'Devoir',  8, 1, '2026-04-15'),  
    (16.00, 'Devoir',  9, 2, '2026-03-10'),  
    (17.00, 'Examen',  9, 2, '2026-03-25'),
    (14.00, 'Devoir', 10, 2, '2026-03-10'),
    (15.00, 'Examen', 10, 2, '2026-03-25'),
    (12.00, 'Projet',  9, 5, '2026-04-20'),  
    (12.00, 'Examen', 11, 1, '2026-03-15');  



-- ============================================================
-- FIN DU SCRIPT
-- ============================================================
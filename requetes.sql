Questions et reponses: 


1. Afficher tous les apprenants  
SELECT * FROM apprenants;

2. Afficher les apprenants d’une classe donnée  
SELECT a.id as id , a.prenom as prenom, a.nom as nom, a.sexe as sexe, a.email as email FROM apprenants a
JOIN classes c ON a.classe_id = c.id
WHERE c.nom = 'DEV-DATA';

3. Afficher uniquement les noms des apprenants 
SELECT DISTINCT nom FROM apprenants;

4. Afficher les modules disponibles  
SELECT * FROM modules;

5. Afficher les notes supérieures à une valeur donnée 
SELECT * FROM notes WHERE valeur > 12;

6. Afficher les apprenants avec les modules auxquels ils sont inscrits  
SELECT a.id as id , a.prenom as prenom, a.nom as nom, modules.nom , modules.categorie FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules ON modules.id = i.module_id;

7. Afficher les apprenants avec leurs notes  
SELECT a.id as id , a.prenom as prenom, a.nom as nom , valeur , type_note, m.nom FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
JOIN modules m ON m.id = n.module_id;

8. Afficher les apprenants inscrits dans un module donné  
SELECT a.id as id , a.prenom as prenom, a.nom as nom FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
WHERE m.nom = 'Python';

9. Afficher les modules suivis par un apprenant donné  
SELECT m.id , m.nom, m.categorie FROM modules m 
JOIN inscriptions i ON m.id = i.module_id
JOIN apprenants a ON a.id = i.apprenant_id
WHERE a.prenom = 'Ndeye Penda';

10. Afficher les apprenants ayant une note supérieure à une valeur dans un module donné 
SELECT a.id as id , a.prenom as prenom, a.nom as nom , valeur , type_note, m.nom FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
JOIN modules m ON m.id = n.module_id
WHERE m.nom = 'SQL' and valeur >= 15;

11. Afficher les apprenants inscrits dans au moins deux modules 
SELECT a.id, a.prenom, a.nom, COUNT(DISTINCT m.id) AS nbre_modules
FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
GROUP BY a.id, a.prenom, a.nom
HAVING COUNT(DISTINCT m.id) >= 2;

12. Afficher les apprenants inscrits dans exactement un module  
SELECT a.id, a.prenom, a.nom, COUNT(DISTINCT m.id) AS nbre_modules
FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
GROUP BY a.id, a.prenom, a.nom
HAVING COUNT(DISTINCT m.id) = 1;

13. Afficher les apprenants qui ne sont inscrits dans aucun module  
SELECT a.id, a.prenom, a.nom
FROM apprenants a
LEFT JOIN inscriptions i ON a.id = i.apprenant_id
WHERE i.id IS NULL;

14. Afficher les modules qui n’ont aucun apprenant  
SELECT m.id, m.nom, m.categorie
FROM modules m
LEFT JOIN inscriptions i ON m.id = i.module_id
WHERE i.id IS NULL;

15. Afficher les apprenants ayant au moins une note 
SELECT DISTINCT a.id,a.prenom, a.nom
FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id;

16. Afficher les apprenants inscrits en Python mais pas en SQL  
SELECT a.id as id , a.prenom as prenom, a.nom as nom  FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
WHERE m.nom = 'Python' 
AND a.id NOT IN
(
    SELECT  a1.id FROM apprenants a1
    JOIN inscriptions i1 ON a1.id = i1.apprenant_id
    JOIN modules m1 ON m1.id = i1.module_id
    WHERE m1.nom = 'SQL'
);

17. Afficher les apprenants inscrits mais n’ayant aucune note  
SELECT DISTINCT a.id, a.prenom, a.nom
FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
WHERE a.id NOT IN (SELECT DISTINCT apprenant_id FROM notes);

18. Afficher les apprenants ayant une note mais non inscrits (anomalie)  
SELECT a.id,a.prenom, a.nom
FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
LEFT JOIN inscriptions i ON a.id = i.apprenant_id AND n.module_id = i.module_id
WHERE i.id IS NULL;

19. Afficher les modules sans note associée  
SELECT m.id as id , m.nom as nom, m.categorie as categorie FROM modules m
LEFT JOIN notes n ON m.id = n.module_id
WHERE n.id is NULL;

20. Afficher les apprenants qui n’ont pas validé un module donné 
SELECT a.id,a.prenom,a.nom, AVG(n.valeur) AS moyenne_module, m.nom AS module FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
JOIN modules m ON m.id = n.module_id
WHERE m.nom = 'Python'
GROUP BY a.id, a.prenom, a.nom, m.nom
HAVING AVG(n.valeur) < 10;

21. Afficher les apprenants inscrits à la fois en Python et en SQL  
SELECT a.id as id , a.prenom as prenom, a.nom as nom  FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
WHERE m.nom = 'Python' 
AND a.id  IN
(
    SELECT  a1.id FROM apprenants a1
    JOIN inscriptions i1 ON a1.id = i1.apprenant_id
    JOIN modules m1 ON m1.id = i1.module_id
    WHERE m1.nom = 'SQL'
);

22. Afficher les apprenants ayant une note dans deux modules donnés  
SELECT a.id as id , a.prenom as prenom, a.nom as nom  FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
JOIN modules m ON m.id = n.module_id
WHERE m.nom = 'Python' 
AND a.id  IN
(
    SELECT  a1.id FROM apprenants a1
    JOIN notes n1 ON a1.id = n1.apprenant_id
    JOIN modules m1 ON m1.id = n1.module_id
    WHERE m1.nom = 'SQL'
);

23. Afficher les apprenants présents dans deux groupes différents 
SELECT a.id as id , a.prenom as prenom, a.nom as nom , COUNT(DISTINCT i.groupe) as nbre_groupes_distincts FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
GROUP BY a.id, a.prenom, a.nom
HAVING nbre_groupes_distincts >= 2;

24. Afficher la liste des apprenants inscrits en Python ou en Web  
SELECT DISTINCT a.id,a.prenom,a.nom FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
WHERE m.nom IN ('Python','Web');

25. Afficher tous les apprenants ayant une note ou une inscription 
SELECT DISTINCT a.id, a.prenom, a.nom
FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
UNION
SELECT DISTINCT a.id, a.prenom, a.nom
FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id;

26. Afficher les apprenants inscrits à tous les modules  
SELECT a.id as id , a.prenom as prenom, a.nom as nom , count(DISTINCT m.id) as nbre_modules  FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
GROUP BY a.id , a.prenom, a.nom
HAVING nbre_modules = (SELECT COUNT(DISTINCT m.id) FROM modules m);

27. Afficher les apprenants ayant une note dans tous les modules  
SELECT a.id as id , a.prenom as prenom, a.nom as nom , count(DISTINCT n.module_id) as nbre_notes FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
JOIN modules m ON m.id = n.module_id
GROUP BY a.id , a.prenom, a.nom
HAVING nbre_notes= (SELECT COUNT(*) FROM modules);

28. Afficher les apprenants ayant validé tous les modules (note ≥ 10)  
SELECT a.id,a.prenom,a.nom FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
GROUP BY a.id, a.prenom, a.nom
HAVING COUNT(DISTINCT n.module_id) =
(
    SELECT COUNT(*)
    FROM modules
)
AND MIN(n.valeur) >= 10;


29. Afficher les apprenants inscrits dans tous les modules d’une catégorie donnée 
SELECT a.id as id , a.prenom as prenom, a.nom as nom  FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
WHERE m.categorie = 'Visualisation'
GROUP BY a.id , a.prenom, a.nom
HAVING count(DISTINCT m.id) = (SELECT COUNT(*) FROM modules m WHERE categorie = 'Visualisation');

30. Calculer la moyenne des notes par apprenant 
SELECT a.id as id , a.prenom as prenom, a.nom as nom , AVG(valeur) as moyenne FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
JOIN modules m ON m.id = n.module_id
GROUP BY a.id, a.prenom, a.nom;

31. Afficher les apprenants ayant une moyenne supérieure à une valeur donnée  
SELECT a.id as id , a.prenom as prenom, a.nom as nom , AVG(valeur) as moyenne  FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
JOIN modules m ON m.id = n.module_id
GROUP BY a.id, a.prenom, a.nom
HAVING moyenne > 15;

32. Afficher le nombre d’apprenants par module  
SELECT m.nom, count(a.id) as nbre_apprenants FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
GROUP BY m.nom;

33. Afficher le module avec le plus d’apprenants  
SELECT m.nom, count(a.id) as nbre_apprenants FROM apprenants a
JOIN inscriptions i ON a.id = i.apprenant_id
JOIN modules m ON m.id = i.module_id
GROUP BY m.nom
ORDER BY nbre_apprenants DESC LIMIT 1;

34. Afficher l’apprenant ayant la meilleure moyenne 
SELECT a.id as id , a.prenom as prenom, a.nom as nom , AVG(valeur) as moyenne FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
JOIN modules m ON m.id = n.module_id
GROUP BY a.id, a.prenom, a.nom
ORDER BY AVG(valeur) DESC LIMIT 1;

35. Afficher les apprenants dont toutes les notes sont supérieures à 10 
SELECT a.id as id , a.prenom as prenom, a.nom as nom FROM apprenants a
JOIN notes n ON a.id = n.apprenant_id
JOIN modules m ON m.id = n.module_id
GROUP BY a.id, a.prenom, a.nom
HAVING  min(valeur) >= 10;
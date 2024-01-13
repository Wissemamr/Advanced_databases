

-- EXERCICE 01 :
-- ---------------------------LES REQUETES DE CREATION DES TYPES------------------------------------------





-- ---------------------------LES REQUETES DE CREATION DES TABLES------------------------------------------







-- ---------------------------LES REQUETES D'INSERTION DANS LES TABLES------------------------------------------

-- dans ecoles
INSER INTO ecoles VALUES('ESTIN')
INSER INTO ecoles VALUES('ESI ALG')
INSER INTO ecoles VALUES('ESI SBA')

-- dans specalites

INSERT INTO specialites VALUES ( 'IA et DS' , (SELECT REF(e ) FROM Ecoles e WHERE e.nom_ecole='ESTIN'));
INSERT INTO specialites VALUES ( 'Systeme information et web' , (SELECT REF(e ) FROM Ecoles e WHERE e.nom_ecole='ESI SBA'));
INSERT INTO specialites VALUES ( 'Systeme intelligent et donnees' , (SELECT REF(e ) FROM Ecoles e WHERE e.nom_ecole='ESI ALG'));
INSERT INTO specialites VALUES ( 'Systeme informatique et logiciels' , (SELECT REF(e ) FROM Ecoles e WHERE e.nom_ecole='ESI ALG'));
INSERT INTO specialites VALUES ( 'Cyber securite' , (SELECT REF(e ) FROM Ecoles e WHERE e.nom_ecole='ESTIN'));


-- dans etudiants
INSERT INTO etudiants VALUES(0111, 'Ahmed', 'Benarab',( SELECT REF(s) FROM specialites s WHERE s.nom_specialite='Cyber securite'))
INSERT INTO etudiants VALUES(0112, 'Fatima', 'Khelif',( SELECT REF(s) FROM specialites s WHERE s.nom_specialite='System intelligent et donnees'))
INSERT INTO etudiants VALUES(0113, 'Youcef', 'Bekhadj',( SELECT REF(s) FROM specialites s WHERE s.nom_specialite='IA et DS'))
INSERT INTO etudiants VALUES(0114, 'Amina', 'Kaddour',( SELECT REF(s) FROM specialites s WHERE s.nom_specialite='IA et DS'))
-- avant d'inserer cet etudiant , on enleve la contrainte de non null pour ref_specilite comme cela
--  ALTER TABLE etudiants DROP CONSTRAINT nn_ref_spec 
INSERT INTO etudiants VALUES(0115, 'Karim', 'Bouzidi', NULL)
INSERT INTO etudiants VALUES(0116, 'Nassima', 'Hamza', (SELECT REF(s) FROM specialites s WHERE s.nom_specialite = 'Systeme intelligent et donnees'))
INSERT INTO etudiants VALUES(0117, 'Mohamed', 'Djellou', (SELECT REF(s) FROM specialites s WHERE s.nom_specialite = 'Cyber securite'))

-- ---------------------------LES REQUETES D'INTERROGATION------------------------------------------


-- Afficher les références de toutes les écoles
-- Afficher les OID de toutes les écoles et comparer le résultat avec la question 1
-- Pour afficher sans repetition a partir de la table ecoles, 3 ecoles
SELECT REF(e) from ecoles e
-- Celle ci affiche 
SELECT object_id FROM ecoles 
-- Afficher l’école référencée par la spécialité Cyber sécurité
SELECT s.ref_ecole, nom_ecole FROM specialites s  WHERE s.nom_specialite = 'Cyber securite' -- Afficher toutes les spécialités de ESI ALG
-- Afficher le nombre d’étudiants de chaque école.
-- Modifier la ref_spécialité de l’étudiant 0115 à OID (Systèmes information et web)




-------------------------------------------------------------------------------------------------------------------------------
-- EXERCIE 02 :

-- 1- Créez un type film qui a comme attribut nom de film.
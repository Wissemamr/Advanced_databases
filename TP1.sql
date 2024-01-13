                                                --- Serie TD/TP : Creation de types et tables ---
                                                --------------------------------------------------


-- 15/10/2023

-- 1. Créer un type adresse_type possédant les attributs numéroRue, nomRue, codePostal et ville (dont la valeur doit être renseignée). Attention à la directive NOT FINAL. 
CREATE TYPE adresse_type AS OBJECT ( 
    numeroRue NUMBER(3),
    numeroRue VARCHAR2(50) , --varchar2 pour indiquer la taille
    codePostal CHAR(4),
    ville VARCHAR(20),
) NOT FINAL ;
--CREATION DE TYPE -> check si final or not , by default it is FINAL !!!!!

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Créer un sous-type adresseWithEmail_type à partir du type adresse_type. Ce sous-type possède un attribut additionnel adresseEmail. 
CREATE TYPE  adresseWithEmail_type UNDER adresse_type (
    adresseEmail VARCHAR2(50),
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Créer un type personne_type possédant un numéro, un nom, un prénom, une adresse (de type adresse_type) et un âge (entre 17 et 60 ans). Attention à la directive NOT FINAL. 
-- NOTE : les contraintes c'est dans la creation des tables pas la declaration des types
CREATE TYPE personne_type AS OBJECT (
    numero VARCHAR(10),
    prenom VARCHAR2(30),
    adresse adresse_type VARCHAR2(30),
    age NUMBER(3),
) NOT FINAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4. . Créer un type etudiant_type qui hérite du type personne_type et possédant deux attributs supplémentaires numCarteEtudiant et annéeInscription. 
CREATE TYPE etudiant_type UNDER personne_type(
    numCarteEtudiant VARCHAR2(5),
    annéeInscription NUMBER(4),
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5 . Créer un type enseignant_type qui hérite du type personne_type et ayant un attribut supplémentaire grade. 
CREATE TYPE enseignant_type UNDER personne_type(
    grade VARCHAR(30),
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 6.  Créer une table « Personnes » à base du type personne_type en prévoyant la contrainte de clé primaires définie sur l’attribut numéro et les contraintes d’intégrité nécessaires. 
CREATE TABLE Personnes OF personne_type
( CONSTRAINT pk_personnes PRIMARY KEY(personne_type.numero),
  CONSTRAINT ck_age CHECK(personne_type.age BETWEEEN 17 AND 60),
  CONSTRAINT nn_ville CHECK(adress.ville IS NOT NULL))
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--22/10/2023
--==============================================INSERTION========================================

--Insérer les données suivantes dans la table Personnes :
--a. La personne <100, KADI, Yasmine> âgée de 30 ans et dont l’adresse est « 5 rue BENBOUALI Hassiba Béjaia 06000 ».
INSERT INTO Personnes VALUES (100, 'KADI', 'Yasmine', 
                            adresse_type(5, 'BENBOUALI Hassiba', '06000', 'Bejaia'), 30)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- L’enseignant <ENS-2010, ZAID, Samir> âgé de 42 ans habitant « 12 rue DIDOUCHE Mourad
--Sétif 19000 ». Il a le grade de Professeur des universités et possède l’adresse e-mail kzaidi@estin.dz
INSERT INTO Personnes VALUES (enseignant_type('ENS-2010', 'ZAID', 'Samir', 
                            adressewithEmail_type(12, 'rue DIDOUCHE Mourad', '19000', 'Setif','kzaidi@estin.dz'), 
                            42, 'Professeur des universités'))

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- L’étudiant <MI-2017-100, SALMY, Islam> âgée de 19 ans et dont l’adresse est « 10 boulevard
--KRIM Belkacem Alger 16000 ». Il est inscrit depuis 2018 et ayant MI-100 comme numéro de carte
--d’étudiant et nselmi@estin.dz comme adresse e-mail.

INSERT INTO Personnes VALUES (etudiant_type('MI-2017-100', 'SALMY', 'Islam', 
                                adresseWithEmail_type(10, 'boulevard KRIM Belkacem', '16000', 'Alger', 'nselmi@estin.dz'),
                                19, 'MI-100', 2018))


--==============================================INTERROGATION========================================

--Afficher l’état de la table Personnes (tout le contenu de la table).

SELECT * FROM Personnes

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Afficher le contenu de la table Personnes sous forme d’objets.
-- Analyser le résultat de cette requête par rapport au résultat d’affichage de la requête 8.
SELECT VALUE(p) FROM Personnes p

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Afficher le numéro, nom, prénom et l’adresse e-mail de toutes les personnes.
-- NOTE : pour extraire un objet qui appartient a un sous type
--TREAT( < nom de l'objet> AS <type de l'objet > ) 
-- Ici il donne toutes les lignes meme celles qui n'ont pas d'adresse mail pcq il n y a pas IS OF 
-- ICI TREAT POUR LA SUBSTITUTION DES  TYPES OBJETS COLONNE
SELECT p.numero, p.nom, p.prenom, TREAT( p.adresse AS adresseWithEmail_type ).adresseEmail AS adresse
FROM Personnes p

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Afficher le numéro, nom, prénom et grade de tous les enseignants.
-- ICI TREAT POUR SUBSTITUER LES OBJETS LIGNE
SELECT p.numero, p.nom, p.grade, TREAT( VALUE(p) AS enseignant_type ).grade AS Enseignantgrade
FROM Personnes p
WHERE VALUE(p) IS OF (Enseignant_type)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Afficher le numéro, nom, numéro de la carte d’étudiant et l’année d’inscription de tous les étudiants.

SELECT  p.numero , p.nom , p.numCarteEtudiantm , p.annéeInscription , TREAT( VALUE(p) AS etudiant_type)
FROM personnes p
WHERE VALUE(p) IS OF etudiant_type






----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Afficher les informations des personnes qui ne sont ni des étudiants ni des enseignants.

SELECT * 
FROM Personnes p
WHERE VALUE(p) IS NOT OF (etudiant_type, enseignant_type)




----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

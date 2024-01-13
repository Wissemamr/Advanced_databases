-- ======== Creer les types et les tables ========== 

-- le type employe
CREATE TYPE employe_type AS OBJECT(
    id_emp NUMBER(4),
    nom VARCHAR(30),
    position VARCHAR(30),
    salaire NUMBER(7),
)

-- 2- Creer le type projet
CREATE TYPE projet_type AS OBJECT (
    code_projet INT,
    nom_projet VARCHAR(20),
    date_debut DATE,
    date_fin DATE
)

-- 3- Creer le type employe_elm aui sont des references vers des employes
CREATE TYPE employe_elm_type AS OBJECT (
    employe_ref REF employe_type
)

-- 4- Creer le type de la table imbriquee des elements de employes
CREATE TYPE employe_nt_type AS TABLE OF employe_elm_type


-- 5- Creer le type affectation_type

CREATE TYPE affectation_type AS OBJECT (
    oid_projet REF projet_type,
    oid_employes employe_nt_type
)


-- ===================== CREATION DES TABLES ===================

CREATE TABLE employes OF employe_type(
    CONSTRAINT pk_id_emp PRIMARY KEY (Id_emp)
)


CREATE TABLE Projets OF Projet_type(
    CONSTRAINT pk_code_proj PRIMARY KEY(code_projet)
)


CREATE TABLE affectations of affectation_type(
    CONSTRAINT ref_oid_proj oid_projet REFERENCES projets
)
NESTED TABLE oid_employes STORE AS employes_collection ;


-- ============ LES INSERTIONS ===========

-- Dans la table employes
INSERT INTO employes VALUES (1, 'Belkhiri Ahmed', 'Ingénieur logiciel', 60000 )
INSERT INTO employes VALUES (2, 'Fatima Zidane', 'Analyste financier', 55000 )
INSERT INTO employes VALUES (3, 'Karim Amrani', 'Développeur web', 50000)
INSERT INTO employes VALUES (4, 'Ali Kaddour', 'Analyste financier', 70000)


-- Dans la table Porjets
INSERT INTO projets VALUES (1, 'Projet Alpha', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO projets VALUES (2, 'Projet Beta', TO_DATE('2023-03-15', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));
INSERT INTO projets VALUES (3, 'Projet Gamma', TO_DATE('2023-05-20', 'YYYY-MM-DD'), TO_DATE('2023-09-10', 'YYYY-MM-DD'));


-- Dans la table affectations 
INSERT INTO affectations VALUES(SELECT REF(p) FROM projets p WHERE p.nom = 'projet Alpha', employe_nt_type(employe_elm_type(SELECT REF(e) FROM employes e WHERE Id_emp=1)))
INSERT INTO affectations VALUES(SELECT REF(p) FROM projets p WHERE p.nom = 'projet Alpha', employe_nt_type(employe_elm_type(SELECT REF(e) FROM employes e WHERE Id_emp=3)))
INSERT INTO affectations VALUES( )
INSERT INTO affectations VALUES( )


-- =========== INTERROGATION DE LA BDD ============

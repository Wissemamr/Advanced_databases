-- creation des types



-- CREER UN TABLEAU DE COULEURS

CREATE TYPE couleur_type AS VARRAY(10) of VARCHAR(10)

CREATE TYPE trophee_elt_type AS OBJECT(
    nom varchar(20),
    nombre_troph number(3)
)

CREATE TYPE t_trophee AS TABLE of trophee_elt_type

CREATE TYPE club_type AS OBJECT (
    nom varchar(30),
    pays varchar(20),
    date_f Date,
    couleurs couleur_type,
    trophees t_trophee
)

(
CREATE TABLE clubs OF club_type(
    CONSTRAINT pk_Nom PRIMARY KEY(nom))
    NESTED TABLE trophees STORE AS trophee_store ;
    


-- LES INSERTIONS
-- 1 "Real Madrid" avec ses trois trophées (35 championnats, 20 coupes, et 14 Ligues
-- des champions). Fondé le 06/03/1902 en Espagne, les couleurs Blanc, Noir et le
-- Rose pour sa tenue.

-- FAIS ATTENTIN LA DATE DOIR RESPECTER LE FORMAT : 'DD-MON-YYYY'
INSERT INTO clubs VALUES (
    'Real Madrid',
    'Espagne',
    '1902-03-06',
   couleur_type ('Blanc', 'Noir', 'Rose'),
    T_trophee(
    trophee_elt_type('Championnat', 35), 
    trophee_elt_type('Coupe', 20), 
    trophee_elt_type('Ligue des champions', 14))
);

-- CORRECTED VERSION
INSERT INTO clubs VALUES (
    'Real Madrid',
    'Espagne',
    TO_DATE('1902-03-06', 'YYYY-MM-DD'),
    couleur_type ('Blanc', 'Noir', 'Rose'),
    t_trophee(
        trophee_elt_type('Championnat', 35), 
        trophee_elt_type('Coupe', 20), 
        trophee_elt_type('Ligue des champions', 14)
    )
);



-- "Manchester City" fondé le 16/04/1894 en Angleterre, les couleurs bleu, blanc
-- pour la tenue et sans aucune trophée (9 championnats, 7 coupes).


INSERT INTO clubs VALUES (
    'Manchester City',
    'Angleterre',
    TO_DATE('1894-04-16', 'YYYY-MM-DD'),
    couleur_type('Bleu', 'Blanc', NULL),
    T_trophee(
        trophee_elt_type('Championnat', 9),
        trophee_elt_type('Coupe', 7))
    
);


-- "FC Barcelone" trophées de (27 championnats, 31 coupes, et 5 Ligue des
-- champions), fondé le 29/11/1899 en Espagne, les couleurs bleu et grenat pour sa
-- tenue.

INSERT INTO clubs VALUES (
    'FC Barcelone',
    'Espagne',
    TO_DATE('1899-11-29', 'YYYY-MM-DD'),
    couleur_type('Bleu', 'Grenat', NULL),
    T_trophee(
        trophee_elt_type('Championnat', 27),
        trophee_elt_type('Coupe', 31), 
        trophee_elt_type('Ligue des champions', 5))
    
);


-- "PSG" fondé le 12/08/1970 sans aucun trophée (constructeur NULL), la couleur
-- de la tenue est bleue et rouge.
INSERT INTO clubs VALUES (
    'PSG',
    NULL,
    TO_DATE('1970-08-12', 'YYYY-MM-DD'),
    couleur_type('Bleu', 'Rouge', NULL),
    NULL
);

-- "Manchester United" fondé le 05/03/1878 en Angleterre, trophées remportées (27
-- championnats, 31 coupes, et 5 Ligues des champions), rouge, bleu, noir pour la
-- tenue.
INSERT INTO clubs VALUES (
    'Manchester United',
    'Angleterre',
    TO_DATE('1978-03-05', 'YYYY-MM-DD'),
    couleur_type('Rouge', 'Bleu', 'Noir'),
    T_trophee(
        trophee_elt_type('Championnat', 27), 
        trophee_elt_type('Coupe', 31), 
        trophee_elt_type('Ligue des champions', 5))
);



-- LES INTERROGATIONS DE LA BDD
-- Afficher les clubs avec le plus grand nombre de trophées de la Ligue des champions.
SELECT c.nom_club FROM clubs c, TABLE (c.trophees) t 
WHERE t.nombre_troph= (SELECT max(nombT) FROM clubs c, TABLE(c.trophees)t, WHERE t.nom='Ligue des champions') AND t.nom='Ligue des champions') ;


-- Afficher les noms et les couleurs de tous les clubs.
SELECT nom, couleurs FROM clubs

--  Afficher la somme totale de trophées de chaque club.
-- SELECT SUM(t.nombre_troph), c.nom FROM clubs c, TABLE(c.trophees) t

-- Corrected version : 

SELECT c.nom, SUM(t.nombre_troph) AS somme_des_trophees FROM clubs c, TABLE(c.trophees) t GROUP BY (c.nom)

--  Afficher les clubs qui ont la couleur de tenue rouge.
SELECT clubs.nom FROM clubs WHERE 'Rouge' IN (SELECT * FROM TABLE(couleurs))




-- MISE A JOUR DE LA BDD

-- a. Le club Manchester City a gagné sa 1er Ligue des champions.


-- b. PSG à (11 championnats, 14 coupes, 0 Ligue des champions)
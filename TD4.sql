-- Requetes d'insertion  :

-- Peupler la table equipes

INSERT INTO equipes VALUES (1, (SELECT REF(p) FROM pays WHERE P.cdep = 'USA'), '100 metres'), tab_athlete(T_athlete(1, ('Green', 'Maurice', Tab_controle(T_controle(1, 'Sanguin', '3/11/2005', N)))))

INSERT INTO equipes VALUES (1, (SELECT REF(p) FROM pays WHERE P.cdep = 'USA'), '100 metres'), tab_athlete(T_athlete(2, ('Lewis', 'Carl', Tab_controle(T_controle(2, 'Sanguin', '3/11/2005', N)))))

-- Interrogation de la BDD
-- Lister les equipes qvec les athletes
SELECT e.codepays, e.sport , a.nom a.prenom FROM eauipe e , TABLE(e.athletes) a  
-- tq athletes est le nom de la collection


--  Liste des controles effectues par athlete n4 de l'equipe 4
SELECT * FROM TABLE(SELECT a.controles FROM TABLE(SELECT e.athletes FROM equipe e WHERE e.numeq = 3)a WHERE a.numD = 4)
-- OU BIEN
SELECT c.numctrol, c.type , c.datectrl , c.resultat FROM equipe e, TABLE(e.athletes ) a , TABLE(a.controles) c
WHERE a.numdoss = 4 AND e.numeeq = 3

-- Le nombre de controles positifs par athlete


SELECT COUNT(c.resultat)  , a.nom , a.prenom
FROM equipe e  , TABLE(e.athletes) a , TABLE(a.controles) c
WHERE equipe c.resultat = 'P' GROUP BY a.nom , a.prenom



-- Afficher la date du dernier controle pour chaque athlete 
SELECT MAX(c.datectrl) , a.nom , a.prenom
FROM equipe e , TABLE(e.athlete)a , TABLE(a.controles) a 
GROUP BY a.nom , a.prenom




-- NOTE THIIIIIIIIS
-- Lister les equipes les plus controlees
SELECT e.* FROM equipe e , TABLE(e.athlete) a , TABLE(a.controles)c 
GROUP BY e.numeaq
HAVING COUNT(*) = (SELECT MAX(COUNT(*) FROM equipes e1 , TABLE(e1.athletes)a1, TABLE(a1.controles) c1 GROUP BY e1.numeq , e1.codepays , e1.sport ) )



-- PREPARER LA PARTIE D
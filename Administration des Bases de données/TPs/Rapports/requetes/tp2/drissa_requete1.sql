SELECT c.nomChercheur
FROM CHERCHEURS c
JOIN TRAVAILLER t ON t.idNumChercheur = c.idNumChercheur
WHERE t.idNumProjet = 'p2';
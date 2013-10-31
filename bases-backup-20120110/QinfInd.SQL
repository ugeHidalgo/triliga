/* ALIAS: c:\triliga\bases */
SELECT Fecha, TipoPrueba, NombrePrueba, PosG, PosGE, PartG, PartGE, Puntos, PP, PRG, PRGE
FROM "c:\triliga\bases\registros.DB" Registros
WHERE  Atleta = :Atleta 

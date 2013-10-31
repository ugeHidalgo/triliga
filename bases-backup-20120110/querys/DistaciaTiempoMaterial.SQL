/* ALIAS: DBTrainMate */
SELECT Regmaterial.CodigoMaterial, Registros.Distancia, Registros.Tiempo
FROM "RegMaterial.DB" Regmaterial
   INNER JOIN "Registros.DB" Registros
   ON  (Regmaterial.CodigoSesion = Registros.Codigo)  
WHERE  Regmaterial.CodigoMaterial = 2 

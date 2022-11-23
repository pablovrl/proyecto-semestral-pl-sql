-- 1. (20 ptos.) Genere un programa en PL/SQL que sea capaz de mostrar la cantidad de
-- estudiantes graduado que ha tenido cada programa durante el tiempo.

SELECT COUNT(*) 
FROM programa P, matricula M, estudiante E, tiene_estado TE, estado ES
WHERE P.pos_codigo = M.pos_codigo
AND M.est_rut = E.est_rut
AND E.est_rut = TE.est_rut
AND TE.esta_id = ES.esta_id
AND ES.esta_descripcion = 'Graduado'
GROUP BY P.pos_codigo;

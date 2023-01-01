-- 1. (30 ptos.) Genere un procedimiento almacenado que permita calcular 
-- la tasa de reprobacion y la tasa de graduacion de un año y programa determinado,
-- ambos datos debe ser recibido como parametro. Para calcular la tasa de 
-- reprobacíon se considera la cantidad es estudiantes que se encuentra con estado 
-- retirado o eliminado versus el total de estudiantes que ingresaron el ano consultado. 
-- Para la tasa de graduaci ́on se consideran los estudiantes con estado graduado versus 
-- el total de estudiantes que ingresaron el an ̃o consultado.

CREATE OR REPLACE 
PROCEDURE tasa_reprobracion_graduacion(ANIO number, PROGRAMA varchar2) 
IS
  total_ingresado integer;
  total_retirado_eliminado integer;
  total_graduado integer;
BEGIN
  -- TOTAL ALUMNOS INGRESADOS EN EL AÑO Y PROGRAMA INGRESADO
  SELECT count(*) into total_ingresado
  FROM ESTUDIANTE E, TIENE_ESTADO TE, PROGRAMA P, MATRICULA M
  WHERE E.est_rut = TE.est_rut AND M.est_rut = E.est_rut AND M.pos_codigo = P.pos_codigo
  AND EXTRACT(YEAR FROM TE.fecha_inicio) = ANIO AND P.pos_nombre = PROGRAMA;
  dbms_output.put_line('Total de estudiantes que ingresaron al programa ' || 
  PROGRAMA || ' en el anio ' || ANIO || ' : ' || total_ingresado); 

  -- TOTAL ALUMNOS RETIRADOS O ELIMINADOS EN EL AÑO Y PROGRAMA INGRESADO
  SELECT count(*) into total_retirado_eliminado
  FROM ESTUDIANTE E, TIENE_ESTADO TE, PROGRAMA P, MATRICULA M
  WHERE E.est_rut = TE.est_rut AND M.est_rut = E.est_rut AND M.pos_codigo = P.pos_codigo
  AND EXTRACT(YEAR FROM TE.fecha_inicio) = ANIO AND P.pos_nombre = PROGRAMA
  AND TE.esta_id IN (SELECT esta_id FROM ESTADO WHERE esta_descripcion IN ('Retirado', 'Eliminado'));
  dbms_output.put_line('Total de estudiantes retirados o eliminados del programa ' || 
  PROGRAMA || ' en el anio ' || ANIO || ' : ' || total_retirado_eliminado); 

  -- TOTAL ALUMNOS GRADUADOS EN EL AÑO Y PROGRAMA INGRESADO
  SELECT count(*) into total_graduado
  FROM ESTUDIANTE E, TIENE_ESTADO TE, PROGRAMA P, MATRICULA M
  WHERE E.est_rut = TE.est_rut AND M.est_rut = E.est_rut AND M.pos_codigo = P.pos_codigo
  AND EXTRACT(YEAR FROM TE.fecha_inicio) = ANIO AND P.pos_nombre = PROGRAMA
  AND TE.esta_id IN (SELECT esta_id FROM ESTADO WHERE esta_descripcion = 'Graduado');
  dbms_output.put_line('Total de estudiantes graduados del programa ' || 
  PROGRAMA || ' en el anio ' || ANIO || ' : ' || total_retirado_eliminado); 

  IF total_ingresado = 0 THEN
    dbms_output.put_line('No hay estudiantes ingresados al programa ' || PROGRAMA || ' en el anio ' || ANIO);
  ELSE
    dbms_output.put_line('Tasa de reprobacion del programa ' ||
    PROGRAMA || ' en el anio ' || ANIO || ' : ' || (total_retirado_eliminado / total_ingresado) * 100 || '%');
    dbms_output.put_line('Tasa de graduacion del programa ' ||
    PROGRAMA || ' en el anio ' || ANIO || ' : ' || (total_graduado / total_ingresado) * 100 || '%');
  END IF;
END;
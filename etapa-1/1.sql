-- 1. (20 ptos.) Genere un programa en PL/SQL que sea capaz de mostrar la cantidad de
-- estudiantes graduado que ha tenido cada programa durante el tiempo.

DECLARE 
CURSOR C is 
  SELECT P.pos_nombre, COUNT (*) FROM programa P, matricula M, estudiante E, tiene_estado TE, estado ES
  where P.pos_codigo = M.pos_codigo AND M.est_rut= E.est_rut AND E.est_rut = TE.est_rut
  AND TE.esta_id = ES.esta_id AND ES.esta_descripcion = 'Graduado' GROUP BY P.pos_nombre;
  programa programa.pos_nombre%type;
  cantidad integer;
BEGIN 
  OPEN C;
  FETCH C into programa, cantidad
  WHILE C%found loop
    dbms_output.put_line('El programa ' || programa || ' tiene ' || cantidad || ' estudiantes graduados.');
    FETCH C into programa, cantidad;
  end loop;
  CLOSE C;
END;

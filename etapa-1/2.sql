-- 2. (20 ptos.) Genere un programa en PL/SQL que sea capaz de mostrar el nombre de los
-- programas y la cantidad de estudiantes que se encuentran en los distintos estados. Adem´as,
-- de mostrar la cantidad de acad´emicos que son claustro y la cantidad de acad´emicos que
-- son colaboradores durante el semestre actual.

DECLARE 
  CURSOR C IS 
  SELECT ES.esta_descripcion, COUNT(*), P.pos_nombre
  FROM Estado ES, tiene_estado TE, Estudiante E, Matricula M, Programa P
  WHERE ES.esta_id = TE.esta_id AND TE.est_rut = E.est_rut AND E.est_rut = M.est_rut AND M.pos_codigo = P.pos_codigo
  GROUP BY ES.esta_descripcion, P.pos_nombre;
BEGIN
  OPEN C;
  FETCH C INTO estado, cantidad, programa;
  WHILE C%FOUND LOOP
    dbms_output.put_line('El programa ' || programa || ' actualmente tiene ' || cantidad || ' estudiante/s con estado ' || estado);
    FETCH C INTO estado, cantidad, programa;
  END LOOP;
  CLOSE C;
END;
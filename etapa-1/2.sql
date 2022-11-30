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
  estado varchar(100);
  programa varchar(100);
  cantidad integer;

  CURSOR C2 IS
  SELECT ASO.rol, count(*)
  FROM Academico A, ASOCIADO ASO
  WHERE A.aca_rut = ASO.aca_rut
  group by ASO.rol;
  rol varchar(100);
  cant_rol integer;
BEGIN
  OPEN C;
  FETCH C INTO estado, cantidad, programa;
  WHILE C%FOUND LOOP
    dbms_output.put_line('El programa ' || programa || ' actualmente tiene ' || cantidad || ' estudiante/s con estado ' || estado);
    FETCH C INTO estado, cantidad, programa;
  END LOOP;
  CLOSE C;
  
  OPEN C2;
  FETCH C2 INTO rol, cant_rol;
  WHILE C2%FOUND LOOP
    dbms_output.put_line('Existen ' || cant_rol || ' académico/s con el rol: ' || rol);
    FETCH C2 INTO rol, cant_rol;
  END LOOP;
  CLOSE C2;
END;
-- (30 ptos.) Genere el o los procedimientos almacenados que permita mostrar la 
-- producti- vidad de los estudiantes de los distintos programas de postgrado. 
-- Mostrando para cada programa la cantidad de art ́ıculos de revistas por cada 
-- tipo indexaci ́on, la cantidad de art ́ıculos por conferencia. Adem ́as, es 
-- necesario calcular el promedio de publicaciones que ha tenido el programa. 
-- Considerando la suma de las publicaciones versus la cantidad de estudiantes 
-- que se han matricularon en el programa.

CREATE OR REPLACE PROCEDURE total_alumnos(programa varchar2, total out integer) 
IS
BEGIN
    SELECT count(*) into total
    FROM ESTUDIANTE E, PROGRAMA P, MATRICULA M
    WHERE M.est_rut = E.est_rut AND M.pos_codigo = P.pos_codigo
    AND P.pos_nombre = programa;
END;

CREATE OR REPLACE PROCEDURE productividad_estudiantes
IS
    CURSOR c1 
        IS SELECT P.pos_nombre, R.rev_descripcion, count(*)
        FROM ARTICULO A, REVISTA R, PUBLICACION PU, GENERA G, ESTUDIANTE E, MATRICULA M, PROGRAMA P
        WHERE R.rev_codigo = A.rev_codigo AND PU.pub_codigo = A.pub_codigo AND
        G.pub_codigo = PU.pub_codigo AND G.est_rut = E.est_rut AND E.est_rut = M.est_rut AND
        M.pos_codigo = P.pos_codigo
        GROUP BY P.pos_nombre, R.rev_descripcion;
    programa varchar2(100);
    indexacion varchar2(100);
    cantidad_articulos integer := 0;
        
    CURSOR c2
        IS SELECT P.pos_nombre, count(*)
        FROM PROGRAMA P, MATRICULA M, ESTUDIANTE E, GENERA G, PUBLICACION PU
        WHERE P.pos_codigo = M.pos_codigo AND M.est_rut = E.est_rut 
        AND E.est_rut = G.est_rut AND G.pub_codigo = PU.pub_codigo
        GROUP BY P.pos_nombre;
    cantidad_publicaciones integer;
    alumnos integer;
    
    CURSOR c3
        IS SELECT P.pos_nombre, count(*)
        FROM ARTICULOCONF AC, PUBLICACION PU, GENERA G, ESTUDIANTE E, MATRICULA M, PROGRAMA P
        WHERE P.pos_codigo = M.pos_codigo AND M.est_rut = E.est_rut AND E.est_rut = G.est_rut AND
        G.pub_codigo = PU.pub_codigo AND PU.pub_codigo = AC.pub_codigo
        GROUP BY P.pos_nombre;
BEGIN
    open c1;
    fetch c1 into programa, indexacion, cantidad_articulos;
    while c1%found LOOP
        dbms_output.put_line('En el programa ' || programa || ' hay ' || cantidad_articulos || ' articulos con la indexacion ' || indexacion);
        fetch c1 into programa, indexacion, cantidad_articulos;
    END LOOP;
    close c1;
    
    open c3;
    fetch c3 into programa, cantidad_articulos;
    while c3%found LOOP
        dbms_output.put_line('En el programa ' || programa || ' hay ' || cantidad_articulos || ' articulos por conferencia');
        fetch c3 into programa, cantidad_articulos;
    END LOOP;
    close c3;
    
    open c2;
    fetch c2 into programa, cantidad_publicaciones;
    while c2%found LOOP
        total_alumnos(programa, alumnos);
        dbms_output.put_line('El programa ' || programa || ' tiene un promedio de publicaciones de: '
        || (cantidad_publicaciones / alumnos) * 100 || '%');
        fetch c2 into programa, cantidad_publicaciones;
    END LOOP;
    close c2;
END;

execute productividad_estudiantes();
--4. (30 ptos.) Crear un trigger que no permita registrar informaci´on de empleadores mientras
--el estudiante no tenga el estado de graduado.

CREATE OR REPLACE TRIGGER no_graduado BEFORE INSERT ON tiene_emp FOR EACH ROW
DECLARE 
    estado_estudiante VARCHAR2(20);
BEGIN 
    SELECT ES.esta_descripcion INTO estado_estudiante FROM estudiante E, tiene_estado TE, estado ES
    WHERE E.est_rut=TE.est_rut AND TE.esta_id=ES.esta_id and E.est_rut= :new.est_rut; 

    IF estado_estudiante <> 'Graduado' THEN
        RAISE_APPLICATION_ERROR(-20001, 'El estudiante no esta graduado');
    END IF;
END;



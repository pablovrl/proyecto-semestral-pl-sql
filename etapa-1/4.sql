--4. (30 ptos.) Crear un trigger que no permita registrar informaci´on de empleadores mientras
--el estudiante no tenga el estado de graduado.

CREATE OR REPLACE TRIGGER NO_EMPLEADORES BEFORE INSERT ON empleador
FOR EACH ROW
DECLARE 
estado_estudiante estado.esta_descripcion%type;

BEGIN 
  SELECT E.esta_descripcion INTO estado_estudiante FROM estudiante E, tiene_estado TE, estado E, tiene_emp TEM, empleador EM
  WHERE E.est_rut=TE.est_rut AND TE.esta_id=E.esta_id
  AND E.est_rut=TEM.est_rut AND TEM.emp_rut=:new.emp_rut;
   
  IF estado_estudiante <> 'Graduado' THEN 
    RAISE_APPLICATION_ERROR(-20300,'El estudiante no se encuentra graduado.');  
  END IF;
 END;



--3. (30 ptos.) Crear un trigger que debe validar que un estudiante que tenga una nota final
--inferior a 4,0 su estado debe ser reprobado, de lo contrario, debe ser aprobado. En caso
--que esto ocurra, se debe cambiar el estado de acuerdo a la nota registrada.

CREATE OR REPLACE TRIGGER ESTA_APROBADO AFTER INSERT ON inscribe FOR EACH ROW
DECLARE
notaFinal FLOAT;

BEGIN 
  SELECT I.nota into notaFinal from estudiante E, inscribe I
  WHERE E.est_rut=I.est_rut;  
  IF 4.0 < notaFinal THEN
    UPDATE inscribe SET estado = 'Reprobado';
  ELSE 
    UPDATE inscribe SET estado = 'Aprobado';
  END IF;
END;



--3. (30 ptos.) Crear un trigger que debe validar que un estudiante que tenga una nota final
--inferior a 4,0 su estado debe ser reprobado, de lo contrario, debe ser aprobado. En caso
--que esto ocurra, se debe cambiar el estado de acuerdo a la nota registrada.

CREATE OR REPLACE TRIGGER ESTA_APROBADO AFTER INSERT ON inscribe FOR EACH ROW
BEGIN 
  IF :new.nota < 4 THEN
    UPDATE inscribe SET estado = 'Reprobado' WHERE est_rut = :new.est_rut;
  ELSE
    UPDATE inscribe SET estado = 'Aprobado' WHERE est_rut = :new.est_rut;
  END IF;
END;

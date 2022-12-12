--3. (30 ptos.) Crear un trigger que debe validar que un estudiante que tenga una nota final
--inferior a 4,0 su estado debe ser reprobado, de lo contrario, debe ser aprobado. En caso
--que esto ocurra, se debe cambiar el estado de acuerdo a la nota registrada.

CREATE OR REPLACE TRIGGER VALIDAR_NOTA BEFORE INSERT or UPDATE ON inscribe FOR EACH ROW
BEGIN
  IF :NEW.nota_final < 4 THEN
    :NEW.estado := 'Reprobado';
  ELSE
    :NEW.estado := 'Aprobado';
  END IF;
END;
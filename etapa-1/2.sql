--2. (20 ptos.) Genere un programa en PL/SQL que sea capaz de mostrar el nombre de los
--programas y la cantidad de estudiantes que se encuentran en los distintos estados. Adem´as,
--de mostrar la cantidad de acad´emicos que son claustro y la cantidad de acad´emicos que
--son colaboradores durante el semestre actual.

DECLARE 
  CURSOR C IS 
  SELECT *, COUNT(*) from programa P, matricula M, estudiante E, tiene_estado TE, estado E
  WHERE  P.pos_codigo=M.pos_codigo AND M.est_rut=E.est_rut AND E.est_rut=TE.est_rut 
  AND TE.esta_id=E.esta_id GROUP BY 
  CURSOR C2
  
BEGIN
  
  

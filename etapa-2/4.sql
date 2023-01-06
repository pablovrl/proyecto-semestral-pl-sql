-- (20 ptos.) De acuerdo a todo lo planteado en este enunciado (parte I y II), defina dos
-- ındices que permita mejorar el rendimiento de esta Base de Datos. 
-- No se debe considerar los  ́ındices impĺıcitos de las claves primarias.

CREATE BITMAP INDEX IN_ESTADO 
ON ESTADO(ESTA_DESCRIPCION);

CREATE BITMAP INDEX IN_PROGRAMA 
ON PROGRAMA(POS_NOMBRE);
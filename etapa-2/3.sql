-- (20 ptos.) El sistema debe contar con dos usuarios:
-- El administrador debe tener acceso a ingresar, modificar y consultar toda la infor- maci ́on. Adem ́as, debe administrar la Base de datos.
-- El Analista s ́olo puede consultar los datos de las publicaciones e informaci ́on relacio- nado con los acad ́emicos

CREATE USER ADMINISTRADOR IDENTIFIED BY admin;

GRANT CREATE SESSION TO ADMINISTRADOR;
GRANT CREATE ANY TABLE TO ADMINISTRADOR;
GRANT SELECT ANY TABLE TO ADMINISTRADOR;
GRANT INSERT ANY TABLE TO ADMINISTRADOR;
GRANT UPDATE ANY TABLE TO ADMINISTRADOR;

GRANT DBA TO ADMINISTRADOR;

CREATE USER ANALISTA IDENTIFIED BY analista;

GRANT CREATE SESSION TO ANALISTA;
GRANT SELECT ON ACADEMICO TO ANALISTA;
GRANT SELECT ON PUBLICACION TO ANALISTA;
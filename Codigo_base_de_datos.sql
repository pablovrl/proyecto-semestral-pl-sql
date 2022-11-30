
CREATE TABLE ESTUDIANTE (
    est_rut varchar2(12) primary key,
    est_nombre varchar2(50),
    est_apellido varchar2(50),
    est_fecha_nac date,
    est_email varchar2(50),
    est_titulo varchar2(50),
    est_año int,
    est_direccion varchar2(50) 
);

insert into ESTUDIANTE values ('3232312','Elvis','Rodriguez','29/10/2000','lomos@gmail.com','mmm',2019,'Penco');
insert into ESTUDIANTE values ('2342342','Pablo','Villaroel','18/10/2001','suplapollas21@gmail.com','si',2019,'Palomares');
insert into ESTUDIANTE values ('3211231','Ignacio','Gonzalez','19/10/2001','colocologrande@gmail.com','casi',2019,'Concepcion');

select * from ESTUDIANTE;

CREATE TABLE PROGRAMA (
    pos_codigo int primary key,
    pos_nombre varchar2(50),
    pos_año_inicio int
);


insert into PROGRAMA values (1,'Tutores',2021);
insert into PROGRAMA values (2,'Testers',2022);

CREATE TABLE MATRICULA (
    est_rut varchar2(12),
    pos_codigo int,
    primary key (est_rut, pos_codigo),
    foreign key (est_rut) references ESTUDIANTE(est_rut),
    foreign key (pos_codigo) references PROGRAMA(pos_codigo)
);

insert into MATRICULA values ('3232312',2);
insert into MATRICULA values ('2342342',1);
insert into MATRICULA values ('3211231',1);


CREATE TABLE ESTADO (
    esta_id int primary key,
    esta_descripcion varchar2(50)
);

insert into ESTADO values (1,'Tesista');
insert into ESTADO values (2,'Regular');
insert into ESTADO values (3,'Graduado');

CREATE TABLE TIENE_ESTADO (
    est_rut varchar2(12),
    esta_id int,
    fecha_inicio date, 
    fecha_termino date, 
    primary key (est_rut,esta_id),
    foreign key (esta_id) references ESTADO(esta_id),
    foreign key (est_rut) references ESTUDIANTE(est_rut)
);

insert into TIENE_ESTADO values ('3232312',2,'06/07/2022','30/12/2022');
insert into TIENE_ESTADO values ('2342342',1,'06/07/2022','30/12/2022');
insert into TIENE_ESTADO values ('3211231',3,'06/07/2022','30/12/2022');

CREATE TABLE ASIGNATURA (
    asi_codigo int primary key,
    asi_nombre varchar2(50),
    asi_semestre int
);

insert into ASIGNATURA values (1,'apreciacion artistica', 2);

CREATE TABLE INSCRIBE (
    asi_codigo int,
    est_rut varchar(12),
    nota float,
    estado varchar2(50),
    primary key (asi_codigo, est_rut),
    foreign key (asi_codigo) references ASIGNATURA(asi_codigo),
    foreign key (est_rut) references ESTUDIANTE(est_rut)
);

insert into INSCRIBE values (1,'3232312', 5.2, 'sin calificar');
insert into INSCRIBE values (1,'2342342', 6.0, 'sin calificar');


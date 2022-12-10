
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

CREATE TABLE EMPLEADOR(
    emp_rut varchar2(12) primary key,
    emp_nombres varchar2(50),
    emp_apellidos varchar2(100),
    emp_correo_electronico varchar2(150),
    emp_telefono int
);

CREATE TABLE TIENE_EMP(
    est_rut varchar2(12),
    emp_rut varchar2(12),
    fecha_inicio date,
    fecha_termino date,
    primary key (est_rut, emp_rut),
    foreign key (est_rut) references ESTUDIANTE(est_rut),
    foreign key (emp_rut) references EMPLEADOR(emp_rut)
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

CREATE TABLE FACULTAD (
    fac_codigo int primary key,
    fac_nombre varchar2(200)
);

CREATE TABLE DEPARTAMENTO (
    dep_codigo int primary key,
    dep_nombre varchar2(50),
    fac_codigo int,
    foreign key (fac_codigo) references FACULTAD(fac_codigo)
);

CREATE TABLE ACADEMICO (
    aca_rut varchar2(100) PRIMARY KEY,
    aca_nombres varchar(200),
    aca_apellidos varchar(200),
    aca_fecha_nac date,
    aca_email varchar(200),
    aca_anexo varchar(200),
    dep_codigo int,
    foreign key (dep_codigo) references DEPARTAMENTO(dep_codigo)
)

insert into ACADEMICO values ('123', 'Elvis', 'Rodriguez', '29/10/2000', 'elvis@gmail.com', '123');
insert into ACADEMICO values ('1234', 'Pablo', 'Academico', '29/10/2000', 'pablo@gmail.com', '123');
insert into ACADEMICO values ('1235', 'Ignacio', 'Academico', '29/10/2000', 'ignacio@gmail.com', '123');

CREATE TABLE ASOCIADO (
    aca_rut varchar2(100),
    pos_codigo int,
    rol varchar2(100),
    primary key (aca_rut, pos_codigo),
    foreign key (aca_rut) references ACADEMICO(aca_rut),
    foreign key (pos_codigo) references PROGRAMA(pos_codigo)
)

insert into ASOCIADO values ('123', 1, 'Colaborador');
insert into ASOCIADO values ('1234', 2, 'Claustro');
insert into ASOCIADO values ('1235', 1, 'Claustro');

CREATE TABLE Universidad_Externa (
    uex_codigo int primary key,
    uex_nombre varchar2(255),
    uex_ciudad varchar2(255),
    uex_pais varchar2(255)
);

CREATE TABLE Grado (
    gra_codigo int primary key,
    gra_tipo varchar2(255),
    gra_nombre varchar2(255),
    uex_codigo int,
    foreign key (uex_codigo) references Universidad_Externa(uex_codigo)
);

CREATE TABLE TIENE (
    gra_codigo int,
    aca_rut varchar2(100),
    fecha_obtencion date,
    primary key (gra_codigo, aca_rut),
    foreign key (gra_codigo) references Grado(gra_codigo),
    foreign key (aca_rut) references ACADEMICO(aca_rut)
);

CREATE TABLE Tipo_Postgrado (
    tpos_id int primary key,
    tpos_descripcion varchar2(255)
);

CREATE TABLE CLASIFICA (
    tpos_id int,
    pos_codigo int,
    fecha_inicio DATE,
    fecha_termino DATE,
    primary key (tpos_id, pos_codigo),
    foreign key (tpos_id) references Tipo_Postgrado(tpos_id),
    foreign key (pos_codigo) references PROGRAMA(pos_codigo)
);

CREATE TABLE DIRIGE (
    aca_rut varchar2(100),
    pos_codigo int,
    primary key (aca_rut, pos_codigo),
    foreign key (aca_rut) references ACADEMICO(aca_rut),
    foreign key (pos_codigo) references PROGRAMA(pos_codigo)
);

CREATE TABLE ASOCIADO (
    aca_rut varchar2(100),
    pos_codigo int,
    rol varchar2(100),
    primary key (aca_rut, pos_codigo),
    foreign key (aca_rut) references ACADEMICO(aca_rut),
    foreign key (pos_codigo) references PROGRAMA(pos_codigo)
);

CREATE TABLE DICTA (
    asi_codigo int,
    aca_rut varchar2(100),
    primary key (asi_codigo, aca_rut),
    foreign key (asi_codigo) references ASIGNATURA(asi_codigo),
    foreign key (aca_rut) references ACADEMICO(aca_rut)
);

CREATE TABLE co_guia (
    pub_codigo int,
    aca_rut varchar2(100),
    primary key (pub_codigo, aca_rut),
    foreign key (pub_codigo) references PUBLICACION(pub_codigo),
    foreign key (aca_rut) references ACADEMICO(aca_rut)
);
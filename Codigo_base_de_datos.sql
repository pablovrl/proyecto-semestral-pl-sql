CREATE TABLE UNIVERSIDAD_EXTERNA (
    uex_codigo int primary key,
    uex_nombre varchar2(255),
    uex_ciudad varchar2(255),
    uex_pais varchar2(255)
);

CREATE TABLE ASIGNATURA (
    asi_codigo int primary key,
    asi_nombre varchar2(50),
    asi_semestre int
);

insert into ASIGNATURA values (1,'apreciacion artistica', 2);

insert into UNIVERSIDAD_EXTERNA values (1,'Universidad del BioBio','Concepcion','Chile');
insert into UNIVERSIDAD_EXTERNA values (2,'Universidad de Concepcion','Concepcion','Chile');

CREATE TABLE REGION (
    re_id int primary key,
    re_descripcion varchar2(200)
);

insert into REGION values (1,'Octava region de Chile');

CREATE TABLE CIUDAD (
    ciu_id int primary key,
    ciu_descripcion varchar2(200),
    re_id int,
    foreign key (re_id) references REGION(re_id)
);

insert into CIUDAD values (1,'Ciudad linda', 1);

CREATE TABLE ESTUDIANTE (
    est_rut varchar2(12) primary key,
    est_nombre varchar2(50),
    est_apellido varchar2(50),
    est_fecha_nac date,
    est_email varchar2(50),
    est_titulo varchar2(50),
    est_año int,
    est_direccion varchar2(50), 
    uex_codigo int,
    ciu_id int,
    foreign key (uex_codigo) references UNIVERSIDAD_EXTERNA(est_rut),
    foreign key (ciu_id) references CIUDAD(pos_codigo)
);

insert into ESTUDIANTE values ('3232312','Elvis','Rodriguez','29/10/2000','lomos@gmail.com','mmm',2019,'Penco',1,1);
insert into ESTUDIANTE values ('2342342','Pablo','Villaroel','18/10/2001','suplapollas21@gmail.com','si',2019,'Palomares',1,1);
insert into ESTUDIANTE values ('3211231','Ignacio','Gonzalez','19/10/2001','colocologrande@gmail.com','casi',2019,'Concepcion',1,1);

select * from ESTUDIANTE;

CREATE TABLE EMPLEADOR(
    emp_rut varchar2(12) primary key,
    emp_nombres varchar2(50),
    emp_apellidos varchar2(100),
    emp_correo_electronico varchar2(150),
    emp_telefono int
);

insert into EMPLEADOR values ('3231231','Mauricio','Isla','Mauri129@gmail.com',91238412);
insert into EMPLEADOR values ('31231222','Francisco','Perno','Fran432@gmail.com',2132313);

CREATE TABLE EMPRESA (
    empr_codigo int,
    empe_nombre varchar2(50),
    empr_giro int,
    empr_telefono int
);

insert into EMPRESA values (1,'MINSAL', 30000);

CREATE TABLE PERTENECE (
    empr_codigo int,
    emp_rut varchar2(12),
    puesto int,
    primary key (empr_codigo, emp_rut),
    foreign key (empr_codigo) references EMPRESA(empr_codigo),
    foreign key (emp_rut) references EMPLEADOR(emp_rut)
);

insert into PERTENECE values (1,'32222222',1,);

CREATE TABLE TIENE_EMP(
    est_rut varchar2(12),
    emp_rut varchar2(12),
    fecha_inicio date,
    fecha_termino date,
    primary key (est_rut, emp_rut),
    foreign key (est_rut) references ESTUDIANTE(est_rut),
    foreign key (emp_rut) references EMPLEADOR(emp_rut)
);

insert into TIENE_EMP values ('3211231','3231231','1/6/2020','30/12/2020');

CREATE TABLE FACULTAD (
    fac_codigo int primary key,
    fac_nombre varchar2(200)
);

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

CREATE TABLE PROGRAMA (
    pos_codigo int primary key,
    pos_nombre varchar2(50),
    pos_año_inicio int,
    fac_codigo int,
    foreign key (fac_codigo) references FACULTAD(fac_codigo)
);

CREATE TABLE TIPO_POSTGRADO (
    tpos_id int primary key,
    tpos_descripcion varchar2(255)
);

CREATE TABLE CLASIFICA (
    tpos_id int,
    pos_codigo int,
    fecha_inicio DATE,
    fecha_termino DATE,
    primary key (tpos_id, pos_codigo),
    foreign key (tpos_id) references TIPO_POSTGRADO(tpos_id),
    foreign key (pos_codigo) references PROGRAMA(pos_codigo)
);

insert into PROGRAMA values (1,'Tutores',2021);
insert into PROGRAMA values (2,'Testers',2022);

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

CREATE TABLE GRADO (
    gra_codigo int primary key,
    gra_tipo varchar2(255),
    gra_nombre varchar2(255),
    uex_codigo int,
    foreign key (uex_codigo) references UNIVERSIDAD_EXTERNA(uex_codigo)
);

CREATE TABLE TIENE (
    gra_codigo int,
    aca_rut varchar2(100),
    fecha_obtencion date,
    primary key (gra_codigo, aca_rut),
    foreign key (gra_codigo) references GRADO(gra_codigo),
    foreign key (aca_rut) references ACADEMICO(aca_rut)
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
)

insert into ASOCIADO values ('123', 1, 'Colaborador');
insert into ASOCIADO values ('1234', 2, 'Claustro');
insert into ASOCIADO values ('1235', 1, 'Claustro');

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

CREATE TABLE DICTA (
    asi_codigo int,
    aca_rut varchar2(12),
    primary key (asi_codigo, aca_rut),
    foreign key (asi_codigo) references ASIGNATURA(asi_codigo),
    foreign key (aca_rut) references ACADEMICO(aca_rut)
);

CREATE TABLE PUBLICACION (
    pub_codigo int,
    pub_nombre varchar2(100)
);

CREATE TABLE GENERA (
    pub_codigo int,
    est_rut varchar2(12),
    primary key (pub_codigo, est_rut),
    foreign key (pub_codigo) references PUBLICACION (pub_codigo),
    foreign key (est_rut) references ESTUDIANTE (est_rut)
);

CREATE TABLE REVISTA (
    rev_codigo int primary key,
    rev_nombre_revista varchar2(100),
    rev_descripcion varchar2(200)
);

CREATE TABLE ARTICULO (
    pub_codigo int primary key,
    art_volumen int,
    art_num_pagina int,
    rev_codigo int,
    foreign key (pub_codigo) references PUBLICACION (pub_codigo),
    foreign key (rev_codigo) references REVISTA (rev_codigo)
);

CREATE TABLE ARTICULOCONF (
    pub_codigo int primary key,
    artconf_acta int,
    artconf_num_pagina int,
    artconf_ciudad varchar2(50),
    artconf_pais varchar2(50),
    artconf_fecha_inicio date,
    artconf_fecha_fin date,
    foreign key (pub_codigo) references PUBLICACION (pub_codigo)
);

CREATE TABLE TESIS (
    pub_codigo int primary key,
    tes_fecha date,
    aca_rut_guia varchar2(12),
    foreign key (pub_codigo) references PUBLICACION (pub_codigo),
    foreign key (aca_rut_guia) references CO_GUIA (aca_rut)
);

CREATE TABLE CO_GUIA (
    pub_codigo int,
    aca_rut varchar2(100),
    primary key (pub_codigo, aca_rut),
    foreign key (pub_codigo) references PUBLICACION(pub_codigo),
    foreign key (aca_rut) references ACADEMICO(aca_rut)
);




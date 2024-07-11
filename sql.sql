-- DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS DET_FACTURA;
DROP TABLE IF EXISTS MAE_FACTURA;
DROP TABLE IF EXISTS CLIENTES;
DROP TABLE IF EXISTS PRODUCTOS;
DROP TABLE IF EXISTS EMPRESA;

-- CREATE TABLE EMPRESA
CREATE TABLE EMPRESA(
    EMPRESA INT NOT NULL,                -- CODIGO DE EMPRESA
    NOMBRE VARCHAR(150) NOT NULL,        -- NOMBRE DE LA EMPRESA
    ESTADO CHAR(1) NOT NULL,             -- (A)ACTIVO  (I)INACTIVO 
    PRIMARY KEY (EMPRESA)
);

-- CREATE TABLE CLIENTES
CREATE TABLE CLIENTES(
    EMPRESA INT NOT NULL,                -- CODIGO DE EMPRESA
    ID_CLIENTE SERIAL PRIMARY KEY,       -- CONSECUTIVO INTERNO DEL CLIENTE 
    CLIENTE INT NOT NULL,                -- NUMERO DE CEDULA O NIT DEL CLIENTE QUE ES EL QUE DEBE VER EL USUARIO FINAL
    TIPO CHAR(1) NOT NULL,               -- TIPO (C)CEDULA  (N)NIT (E)XTRANJERO 
    NOMBRE VARCHAR(150) NOT NULL,        -- NOMBRE DEL CLIENTE
    TELEFONO VARCHAR(150) NOT NULL,      -- TELEFONO
    CORREO VARCHAR(150) NOT NULL,        -- CORREO
    DIRECCION VARCHAR(250) NOT NULL,     -- DIRECCION
    PAGINAWEB VARCHAR(450) NOT NULL,     -- PAGINA WEB DEL CLIENTE 
    FECHA_CREACION TIMESTAMP NOT NULL,   -- FECHA DE CREACION DEL CLIENTE
    ESTADO CHAR(1) NOT NULL,             -- (A)ACTIVO  (I)INACTIVO 
    UNIQUE (EMPRESA, CLIENTE),
    CONSTRAINT CLIENTESF01 FOREIGN KEY(EMPRESA) REFERENCES EMPRESA,
    CONSTRAINT CLIENTESC01 CHECK (ESTADO IN ('A', 'I')),
    CONSTRAINT CLIENTESC02 CHECK (TIPO IN ('C', 'N', 'E'))
);

-- CREATE TABLE PRODUCTOS
CREATE TABLE PRODUCTOS(
    EMPRESA INT NOT NULL,                -- CODIGO DE EMPRESA
    ID_PRODUCTO SERIAL PRIMARY KEY,      -- CONSECUTIVO INTERNO DEL PRODUCTO 
    PRODUCTO VARCHAR(30) NOT NULL,       -- CODIGO DEL PRODUCTO
    NOMBRE VARCHAR(150) NOT NULL,        -- NOMBRE DEL PRODUCTO
    TIPO CHAR(1) NOT NULL,               -- TIPO PRODUCTO (M)MATERIA PRIMA  (T)TERMINADO (D)EVOLUTIVO (C)ONSUMO    
    FOTOPRODUCTO VARCHAR(250) NOT NULL,  -- FOTO DEL PRODUCTO
    FECHA_CREACION TIMESTAMP NOT NULL,   -- FECHA CREACION DEL PRODUCTO
    ESTADO CHAR(1) NOT NULL,             -- (A)ACTIVO  (I)INACTIVO 
    UNIQUE (EMPRESA, PRODUCTO),
    CONSTRAINT PRODUCTOSF01 FOREIGN KEY(EMPRESA) REFERENCES EMPRESA,
    CONSTRAINT PRODUCTOSC01 CHECK (ESTADO IN ('A', 'I')),
    CONSTRAINT PRODUCTOSC02 CHECK (TIPO IN ('M', 'T', 'D', 'C'))
);

-- CREATE TABLE MAE_FACTURA
CREATE TABLE MAE_FACTURA(
    EMPRESA INT NOT NULL,                -- CODIGO DE EMPRESA
    ID_FACTURA SERIAL PRIMARY KEY,       -- CONSECUTIVO INTERNO PARA IDENTIFICAR LA FACTURA
    NUMERO INT NOT NULL CHECK (NUMERO > 0), -- NUMERO DE LA FACTURA LA PRIMERA FACTURA QUE SE HAGA DEBE INICIAR EN 5000
    FECHA_FACTURA TIMESTAMP NOT NULL,    -- FECHA DE LA FACTURA
    ID_CLIENTE INT NOT NULL,             -- IDENTIFICACION INTERNA DEL CLIENTE
    OBSERVACIONES VARCHAR(300) NOT NULL, -- OBSERVACIONES DE LA FACTURA
    TOTAL DECIMAL(20,2) NOT NULL CHECK (TOTAL > 0), -- TOTAL DE LA FACTURA
    FECHA_AUDITORIA TIMESTAMP NOT NULL,  -- FECHA DE AUDITORIA CUANDO SE REGISTRO LA FACTURA EN EL SISTEMA
    CONSTRAINT MAE_FACTURAF01 FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTES,
    CONSTRAINT MAE_FACTURAF02 FOREIGN KEY(EMPRESA) REFERENCES EMPRESA
);

-- CREATE TABLE DET_FACTURA
CREATE TABLE DET_FACTURA(
    EMPRESA INT NOT NULL, 
    ID_FACTURA INT NOT NULL,
    CONSECUTIVO INT NOT NULL CHECK (CONSECUTIVO > 0),  -- CONSECUTIVO POR CADA FACTURA INICIA EN 1
    ID_PRODUCTO INT NOT NULL, 
    CANTIDAD DECIMAL(20,2) NOT NULL CHECK (CANTIDAD > 0),
    PRECIO DECIMAL(20,2) NOT NULL CHECK (PRECIO > 0),
    SUB_TOTAL DECIMAL(20,2) NOT NULL CHECK (SUB_TOTAL > 0),
    PRIMARY KEY (ID_FACTURA, CONSECUTIVO),
    CONSTRAINT DET_FACTURAF01 FOREIGN KEY(EMPRESA) REFERENCES EMPRESA,
    CONSTRAINT DET_FACTURAF02 FOREIGN KEY(ID_FACTURA) REFERENCES MAE_FACTURA,
    CONSTRAINT DET_FACTURAF03 FOREIGN KEY(ID_PRODUCTO) REFERENCES PRODUCTOS
);

INSERT INTO EMPRESA VALUES (1, 'EMPRESA DEMOSTRACION FINANCIERA','A');
INSERT INTO EMPRESA VALUES (2, 'EMPRESA DEMOSTRACION TERPEL','I');
INSERT INTO EMPRESA VALUES (3, 'EMPRESA DEMOSTRACION DE ASEO','A');

INSERT INTO clientes_clientes (empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '830003564','N','ENTIDAD PROMOTORA DE SALUD FAMISANAR S.A.S.','.','.',' CL 78 13 A 07','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '901131909','N','TERNIUM DEL ATLANTICO SAS','.','KLARIOS@TERNIUM.COM.CO',' CR 42 26 18','','Sep  7 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '900174468','N','TERNIUM SIDERURGICA DE CALDAS S.A.S.','.','KLARIOS@TERNIUM.COM.CO',' CR 42 26 18','','Sep 13 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '800189687','N','ACEROS CORTADOS S.A.S','.','MYEINVOICE@GRUPOCNET.NET',' CR TRONCAL DEL OCCIDENTE SAN C FUNZA','','Sep 13 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '817000865','N','METALSUR S.A','.','FSARMIENTO@FANALCA.COM',' PARQUE COMERCIAL DE CAUCA ETAPA 3  LOTE 4','','Sep 13 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '890301886','N','FANALCA S.A','.','FSARMIENTO@FANALCA.COM',' CL 72 5 83 OFICINA  302','','Sep 13 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '901281934','N','CEMENTOS DEL ORIENTE S.A.S ZOMAC','3174302620','MIRYANNARANJO@ORIENTTE.CO',' CL 15 21 05','','Sep 13 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '800219247','N','ACERRIOS MONTE VERDE','.','.',' CL 29 46 A','','Sep 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '800138188','N','ADMINISTRADORA DE FONDOS DE PENSIONES Y CESANTIA PROTECCION S.A.',' 315 7133166','SEGURINFO@PROTECCION.COM.CO',' CL 49 63 100','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '800149496','N','COLFONDOS S.A. PENSIONES Y CESANTIAS','3007485245','PROCESOSJUDICIALES@COLFONDOS.COM.CO',' AC 30 85 16','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '800170043','N','FONDO DE CESANTIAS PORVENIR','3112742152',' ABC@PORVENIR.COM.CO',' CR 13 26 A 56','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '899999284','N','FONDO NACIONAL DEL AHORRO - CARLOS LLERAS RESTREPO','3103072512','GERENCIA@FONDONACIONALDELAHORRO.CO',' CR 65 11 83','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '860003020','N','BANCO BILVAO VISCAYA ARGENTARIA COLOMBIA',' 630 40 00','ADMINISTRACIONGERENCIAL@BBVA.COM',' CR 9 72 21','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '860007738','N','BANCO POPULAR S.A.','.','.',' CL 17 7 43','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '860034594','N','BANCO SCOTIABANK COLPATRIA S.A.','.','.',' AC 26 69 63','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '800148514','N','SKANDIA ADMINISTRADORA DE FONDOS DE PENSIONES Y CESANTIAS S.A.','31245125412','GERENCIQWW@SKANDIA.COM',' AC 19 109 A','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '860002964','N','BANCO DE BOGOT�','.','.',' CL 36 7 47 LC','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '800037800','N','BANCO AGRARIO DE COLOMBIA S.A.','.','.',' CR 8 15 43','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '860007335','N','BANCO CAJA SOCIAL S.A.','.','.',' CR 7 77 65 LC 9','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '860050750','N','BANCO GNB SUDAMERIS S.A.','.','.',' CR 8 15 42','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '43168677','C','NUBIA SOREYY NARANJO BETANCUR','3043779875','SOREY.COMERCIAL@GMAIL.COM',' CR 62 A 74 SUR 164','','Sep 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '1110443926','C','ERWIN ANDRES SILVA LARA','3028680330','ENWINANDRES1000@GMAIL.COM',' CR 26 3 77','','Oct  7 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '1048207415','C','HENRY  ARAUJO','.','.',' CL 2 3 70','','Oct  7 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '1124004378','C','OSCAR JULIO','.','.',' CR 12 5 27','','Oct  7 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '890900841','C','CAJA DE COMPENACION FAMILIAR COMFAMA','0','0',' CL 2 SUR 53 82','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '179247','C','MACEDONIO  MANRIQUE ROMERO','0','manriquemacedonio@gmail.com','VDA SAN ANTONIO','','Jun 23 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '192097','C','FABIO HUMBERTO OSPINA PULIDO','0','kik3ospina@hotmail.com','KR 2 6 32','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '285923','C','JORGE CASTIBLANCO RODRIGUEZ','3164854205','jorgecastiblanco50@outlook.com','KR 1 1 05 AV PANAMERICANA','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '506767','C','ENRIQUE ANTONIO PARAMO CORDOBA','7268823','casadelvidrio506@hotmail.com','KR 11 15 04 BRR CENTRO','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '1013419','C','NESTOR SANCHEZ NESTOR','3138839854','pegarama@hotmail.com','CL 139 140 10','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '1033352','C','VICTOR CENON ARIAS BERMUDES','0','distibuidoradelnorte@gmail.com','DG 28 7 76','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '1079856','C','PABLO ENRIQUE ROJAS CORDOBA','6247054','contabilidad@ferrelectricoscentral.com','KR 12 6 28 BRR PALMARITO','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '1114369','C','LIBARDO JARAMILLO YEPEZ','3114407277','lijaye@hotmail.com','KR 20 A 6 A 28','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '1160454','C','YUBER ORLANDO ACOSTA ROBERTO','3124564326','ventasdobladoraelperdomo@gmail.com','CL 64 SUR 72 A 73 BRR EL PERDOMO','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '2183371','C','LUIS DOMINGO GONZALEZ MONSALVE','3657972','feluya26@hotmail.com','KR 26 A 73 C 132','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '2612992','C','OLIVER BEJARANO HERRERA','3155930202','bufalocc@hotmail.com','CL 15 NORTE 4 NORTE 30','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '2768438','C','JOSE ALFONSO GUERRA GAMEZ','0','josealfonsoguerragamez@gmail.com','KR 14 13 07','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '2919550','C','VICTOR JULIO MENDOZA','3156497189','indumetalicasvimen@hotmail.com','CL 79 61 59','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '2971263','C','ALVARO FIGUEROA CARRE�O','3144738003','figueroacarre�o@gmail.com','KR 12 11 52 BR LA DESPENSA','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('1', '2971684','C','JAIME NARVAEZ BONILLA','7628842','dpositonarvaez@gmail.com','KR 7 ESTE 90 D 46','','Apr  8 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '830136799','N','BIOMAX SA  .','6013798000','SERVICIOALCLIENTE@BIOMAX.CO','CR 14 99 33 P 9','','May  4 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '900235157','N','COMPU IMPRESION SAS  .','318 527 5783','VENTAS@COMPUIMPRESION.COM.CO',' CR A 15 77 05 L 1 60','','Jun  5 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '900346376','N','MULTISERVICIOS SUMIREPUESTOS S.A.S','3143317053','MULTISERVICIOSSAS@GMAIL.COM',' CL 11 28 179','','Feb  3 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '900755245','N','CONSTRUCCIONES Y FABRICACIONES DE INGENIERA SAS','3144115783','JOSEHURTADO.COMERCIAL@GMAIL.COM','DG 59 11A 100','','Jun 27 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '901076058','N','FUNDICION HERMANOS SANCHEZ Y PARRA S.A.S','3176566638','.','KM 1 VIA TUNJA HACIA VILLA DE LEYVA','','Jul 22 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '830109078','N','TRANSMISION MECANICA SAS','8966893','CONTABILIDAD@TRAMECLTDA.COM','AUT MEDELLIN K M 25 ENTRADA PARCELAS','','May 11 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '860514851','N','DISCORREAS MANGUERAS Y EMPAQUES SA','3164681289','CONTABILIDAD@DISCORREAS.COM','cll 13 bn 27-02','','Mar  3 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '79917615','N','JAIRO LUIS QUIJANO SANCHEZ','3115437398','auditoriapso@gmail.com',' CL 12 52 11','','Mar 23 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '438493','N','JUAN GUILLERMO BOTERO DIAZ','.','JGB_RANCH@HOTMAIL.COM','CR 55 79 A 65 BRR GAITAN','','Feb  7 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '2202840','N','EFRAIN ARIZA MATEUS','.','edselsurtidor@yahoo.com','CL 5 5 27','','Feb  7 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '43365615','C','FERRETERIA LA UNICA SOGAMOSO','7704204','.','CALLE 11 NO 16-33','','Jan  6 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '72099041','C','JAIRO ALONSO REALES RODRIGUEZ','3108497477','jreales841@gmail.com',' CL 21 12 52 AP','','Jan 20 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '46455894','C','CLAUDIA JAZMIN ROSAS BAEZ','3123501427','claudiarosas1207@gmail.com',' CR 40 21 48','','Feb  8 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '1053585385','C','LINA JOHANA NOVA NU�EZ','3125935405','ljcln10@gmail.com',' CR 5 7 77','','May 11 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '23583112','C','BRENDA ALEJANDRA PATARROYO COY','3143428643','AUDITORIA@ORIENTTE.CO','CR 4 5 A 55','','Mar 11 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '32769850','C','GRACE  MARTINEZ DOMINGUEZ','3007984400','0','.','','Jun 30 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '37900024','C','YAQUELINE  BUENO HERRERA','3016282384','YACQUEBUENO25@HOTMAIL.COM','CL 35 A 8 G 23','','Jun 30 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '32786098','C','ELIANA CRISTINA GONZALEZ LOBELO','3006282284','CRISTINAGONZALEZ@GMAIL.COM','.','','Jun 30 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '32675316','C','LILIANA MARGARITA CABALLERO CANTILLO','3182216153','margaritacc2507@gmail.com',' CL 6 13 42 AP','','Feb  8 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('3', '46358359','C','MYRIAM  CHAPARRO PEREZ','3114964623','myriamchaparro@orientte.co',' CL 38 10 A 130','','Feb  8 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '91449487','N','RAUL  AMAYA TORRES','8331901','FERRETERIAELINDUSTRIAL@YAHOO.COM','CRA 1 E No 54A-08','','Mar 24 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '91478413','N','LEAL OLEJUA JOSE ALEJANDRO','3166539566','alejotubosytubos@hotmail.com','CR 13 24 44','','Sep 21 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '91498024','N','FUENTES NI�O PEDRO ADOLFO','4140400','ferreterialacasadelalba@hotmail.com','CL 3 9A 24','','Sep 21 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '91506876','N','CARRE�O NI�O HENRY MAURICIO','3118860580','hmcarrenon@gmail.com','CL 12 A 2026 AP 101','','Sep 21 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '92095860','N','NAVARRO OLMOS JORGE LUIS','3126422533','josediazmel@hotmail.com','CR 16 10 48','','Sep 21 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '92256201','N','REYES THERAN IVAN ARTURO','2838022','servimateriales@hotmail.com','C.C. REAL 27 60','','Sep 21 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '92259495','N','CRUZ HERRERA AMAURY ENRIQUE/// FERRETERIA TAKAZUAN','3126160672','amaurycruz.7@gmail.com','CL 19 7 74','','Jan  4 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '92520165','N','CALDERA SERPA ELMIS ALFONSO','2751426','.','CL 25 8 C 488','','Sep 21 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '93126601','N','BRI�EZ AVILA JOSE ERNESTO','2487965','distribuidorajeba@hotmail.com','CR 8A 16 05','','May 23 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '93131413','N','CONDE LUNA MAURICIO/ M&T FERRECONDE','2889133','facturacionferreconde@hotmail.com','CRA 15 No 45-21 Br. Palermo','','Sep 21 2022 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '1038800014','C','YARYS LISBETH ESPITIA ATENCIA','0','YARYSLISBETH3086@HOTMAIL.COM',' CRA 27  26 D 50 BRR LOS ALPES','','Apr 21 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '36518617','C','INES LUCIA HERNANDEZ  GALVIS','0','.',' CR 18 A 36 BIS 1 11','','Apr 18 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '6885019','C','CESAR MANUEL NARVAEZ SILGADO','0','YO_OPINODELFUTURO@HOTMAIL.COM',' CL 3B 23 32','','Apr 20 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '32678580','C','HELDA MARIA SEPULVEDA VALBUENA','0','ELDASEPULVEDA0@GMAIL.COM',' TRANSVERSAL 14A 42-16','','Apr 20 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '22529542','C','LUZ DARY MENDEZ WILLIAMS','0','FERRECONSTRUCTORESDELCESARADMI@GMAIL.COM',' VRD CR 5 5 69 BRR JORGE ELIECER GAITAN','','Apr 20 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '1067731977','C','YESSICA ELENA MOVILLA RUIZ','0','MOVILLAYESSICA10@GMAIL.COM',' CL 3 5 29 BRR TOSCANO','','Jul 29 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '72193088','C','JANDER  ALEMAN RIPOLL','0','JANDERALEMAN@HOTMAIL.COM',' CRA 2E 42 45','','Apr 24 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '15244464','C','CARLOS RAFAEL MARTINEZ WALDERFORD','0','FERREELMAESTROCONSTRUCTOR@HOTMAIL.COM',' SEC SANTA ISABEL','','Apr 24 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '37946484','C','JAQUELINE PE�A ACU�A','0','.',' CRA 16E 3A 26','','Apr 24 2023 12:00AM','A');
INSERT INTO clientes_clientes(empresa_id, CLIENTE,TIPO,NOMBRE,TELEFONO,CORREO,DIRECCION,PAGINAWEB,FECHA_CREACION,ESTADO) VALUES('2', '72166849','C','JORGE RAFAEL MURGAS LOPEZ','0','JRMURGAS10@GMAIL.COM',' Kr 23 B #  17 a esquina','','Apr 24 2023 12:00AM','A');

INSERT INTO productos_productos(empresa_id ,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '1391','ALAMBRE BRILLANTE  1.00MM','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '100101','ALAMBRE BRILLANTE  CAL 3.40 mm','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '100201','ALAMBRE BRILLANTE  CAL 4.5 mm','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '100301','ALAMBRE BRILLANTE  CAL 5.40 mm','D','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '100401','ALAMBRE BRILLANTE CAL 20','D','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '100501','ALAMBRE BRILLANTE DELGADO CAL 13','D','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '100601','ALAMBRE BRILLANTE DELGADO CAL 14','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '100701','ALAMBRE BRILLANTE DELGADO CAL 14.5','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '100801','ALAMBRE BRILLANTE DELGADO CAL 15','M','','Oct 19 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '100901','ALAMBRE BRILLANTE FINO CAL 18','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101801','ALAMBRE BRILLANTE GRUESO CAL 10','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101901','ALAMBRE BRILLANTE GRUESO CAL 10.5','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '102001','ALAMBRE BRILLANTE GRUESO CAL 11','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '102101','ALAMBRE BRILLANTE GRUESO CAL 12','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101001','ALAMBRE BRILLANTE GRUESO CAL 4','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101101','ALAMBRE BRILLANTE GRUESO CAL 5','T','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101201','ALAMBRE BRILLANTE GRUESO CAL 5.4','T','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101301','ALAMBRE BRILLANTE GRUESO CAL 5.58','T','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101401','ALAMBRE BRILLANTE GRUESO CAL 6','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101501','ALAMBRE BRILLANTE GRUESO CAL 7','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101601','ALAMBRE BRILLANTE GRUESO CAL 8','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '101701','ALAMBRE BRILLANTE GRUESO CAL 9','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '102301','ALAMBRE BRILLANTE RETREFILADO CAL 16','T','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '102401','ALAMBRE BRILLANTE RETREFILADO CAL 17','T','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '102201','ALAMBRE BRILLANTE SEMIACERADO CAL 10','T','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '200101','ALAMBRE DE PUAS 12.5 X 200 M','T','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '200201','ALAMBRE DE PUAS 12.5 X 330 M','T','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '200301','ALAMBRE DE PUAS 12.5 X 350 M','T','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '200401','ALAMBRE DE PUAS 12.5 X 400 M','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('1', '200501','ALAMBRE DE PUAS 14 X 200 M','M','','Mar 17 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '00100039','CALIZA ALTA','M','','Jul 10 2023 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '100001','CEMENTO HIDRAH  TIPO USO GENERAL (UG) X 50 KG','T','','Jun 23 2023 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '100002','CEMENTO HIDRAH  TIPO USO GENERAL ((UG) X 42,5 KG','T','','May 29 2023 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '100003','CEMENTO HIDRAH  TIPO USO GENERAL (UG) X 21,25 KG','T','','Nov 23 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '100004','CEMENTO ART TIPO  (ART) 42 5 KG','M','','Nov 23 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '100005','CEMENTO ART GRANEL 34 TON','M','','Nov 23 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '100006','CEMENTO ESTRUCTURAL (EST) 42,5 KG','M','','Jul 11 2023 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '100007','CEMENTO ESTRUCTURAL (EST) 21,25 KG','M','','Nov 23 2022 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '100008','CEMENTO HIDRAULICO TIPO UG TOPEX (UG) TOPEX 50 KG','M','','Jan 23 2023 12:00AM','A');
INSERT INTO productos_productos(empresa_id,PRODUCTO,NOMBRE,TIPO,FOTOPRODUCTO,FECHA_CREACION,ESTADO) VALUES('3', '100010','CEMENTO HIDRAULICO TIPO UG TOPEX (UG) TOPEX 42,5 KG','M','','Jul 11 2023 12:00AM','A');
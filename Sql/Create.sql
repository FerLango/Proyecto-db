create table demograficos(
	id_demograficos int4 constraint pk_demograficos primary key,
	temporal timestamptz,
	licenciatura text,
	edad float8, 
	genero text,
	estado text,
	areas text
);

create table exploratorias (
	id_exploratorias int4 constraint pk_exploratorias primary key,
	id_demograficos int4 references demograficos (id_demograficos) not null,
	seguridad float8,
	privacidad text,
	huella text
);

create table vulnerabilidad(
	id_vulnerabilidad int4 constraint pk_vulnerabilidad primary key, 
	id_demograficos int4 references demograficos (id_demograficos) not null,
	dispositivos float8, 
	ordena_compu text, 
	ordena_tablet text, 
	ordena_celular text, 
	ordena_smart text, 
	ordena_otro bool, 
	configuracion text, 
	antivirus float8, 
	actualizacion float8
);

create table dispositivos_cuales (
	id_dispositivos_cuales int4 constraint pk_dispositivos_cuales primary key,
	id_demograficos int4 references vulnerabilidad (id_vulnerabilidad) not null, 
	dispositivos_cantidad text
);

create table manejo_info (
id_manejo_info int4 primary key,
	datos text,
	empresas text,
	preocupacion_empresas text,
	username text
);

create table prevencion_digital (
id_prevencion_digital int4 primary key,
	banca text,
	compras_online text,
	paypal text,
	term_cond text,
	cookies text,
	cookies_accesibles text,
	publicidad text,
	cargos text,
	con_victima text,
	evitado text
);

create table prevencion_navegacion (
id_prevencion_navegacion int4 primary key,
	navegador text,
	url text,
	phishing text
);

create table proteccion(
	id_proteccion int4 primary key, 
	proteccion text 
);
create table redes_sociales (
	id_redes_sociales int4 primary key, 
	sociales_contar float8, 
	ordena_facebook text, 
	ordena_instagram text, 
	ordena_whatsapp bool, 
	ordena_twitter text, 
	ordena_tiktok bool, 
	ordena_ninguna text, 
	ordena_otra bool
);
create table sociales_cuales(
	id_sociales_cuales int4 primary key, 
	sociales_cuales text
);
create table victima( 
	id_victima int4 primary key, 
	victima text
);


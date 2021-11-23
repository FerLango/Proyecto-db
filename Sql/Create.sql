create table demograficos(
	id int4 primary key,
	temporal timestamptz,
	licenciatura text,
	edad float8, 
	genero text,
	estado text,
	areas text
)

create table dispositivos_cuales (
	id int4 primary key,
	dispositivos_cantidad text
)

create table exploratorias (
	id int4 primary key,
	seguridad float8,
	privacidad text,
	huella text
)

create table manejo_info (
	id int4 primary key,
	datos text,
	empresas text,
	preocupacion_empresas text,
	username text
)

create table prevencion_digital (
	id int4 primary key,
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
)

create table prevencion_navegacion (
	id int4 primary key,
	navegador text,
	url text,
	phishing text
)

create table proteccion(
	id int4 primary key, 
	proteccion text 
)

create table redes_sociales (
	id int4 primary key, 
	sociales_contar float8, 
	ordena_facebook text, 
	ordena_instagram text, 
	ordena_whatsapp bool, 
	ordena_twitter text, 
	ordena_tiktok bool, 
	ordena_ninguna text, 
	ordena_otra bool
)

create table sociales_cuales(
	id int4 primary key, 
	sociales_cuales text
)

create table victima( 
	id int4 primary key, 
	victima text
)

create table vulnerabilidad(
	id int4 primary key, 
	dispositivos float8, 
	ordena_compu text, 
	ordena_tablet text, 
	ordena_celular text, 
	ordena_smart text, 
	ordena_otro bool, 
	configuracion text, 
	antivirus float8, 
	actualizacion float8
)


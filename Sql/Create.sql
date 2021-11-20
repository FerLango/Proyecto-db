create table demograficos(
	id int4 primary key,
	temporal timestamptz,
	licenciatura text,
	edad float8, 
	genero text,
	estado text,
	areas text
)











/*
create table respuestas(
	id numeric (3),
	temporal timestamp,
	licenciatura varchar(2),
	edad numeric(3),
	genero varchar(9),
	estado varchar(20),
	areas varchar(37),
	seguridad numeric(1),
	privacidad varchar(2),
	huella varchar(2),
	dispositivos numeric(2),
	dispositivos_cantidad varchar(47),
	ordena_compu varchar(7),
	ordena_tablet varchar(7),
	ordena_celular varchar(7),
	ordena_smart varchar(7),
	ordena_otro varchar(7),
	configuracion varchar(2),
	antivirus numeric(3),
	actualizacion numeric(3),
	sociales_contar numeric(3),
	sociales_cuales varchar(62),
	ordena_facebook varchar(7),
	ordena_instagram varchar(7),
	ordena_whatsapp varchar(7),
	ordena_twitter varchar(7),
	ordena_tiktok varchar(7),
	ordena_ninguna varchar(7),
	ordena_otra varchar(7),
	banca varchar(2),
	compras_online varchar(2),
	paypal varchar(2),
	term_cond varchar(56),
	cookies varchar(18),
	cookies_accesibles varchar(18),
	publicidad varchar(2),
	cargos varchar(2),
	victima varchar(577),
	con_victima varchar(2),
	evitado varchar(5),
	proteccion varchar(480),
	navegador varchar(2),
	url varchar(2),
	phishing varchar(5),
	datos varchar(5),
	empresas varchar(18),
	preocupacion_empresas varchar(18),
	username varchar(30)
);

copy respuestas from 'C:\Users\Public\data_temp.csv' with (format csv);

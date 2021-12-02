create view poblacion as
select licenciatura, edad, genero, estado, areas 
from demograficos d;

create view percepcion as
select e.seguridad, e.privacidad, e.huella 
from demograficos d 
	join exploratorias e using (id_demograficos)
where d.licenciatura = 'Sí';

create view exposicion as
select v.dispositivos, v.configuracion, v.antivirus, v.actualizacion 
from demograficos d 
	join vulnerabilidad v using (id_demograficos)
where d.licenciatura = 'Sí';

create view dispositivos_utilizados as
select dc.dispositivos_cantidad 
from demograficos d 
	join vulnerabilidad v using (id_demograficos)
	join dispositivos_cuales dc using  (id_vulnerabilidad)
where d.licenciatura = 'Sí';

create view dispositivos_mas_utilizados as
select v.ordena_compu, v.ordena_tablet, v.ordena_celular, v.ordena_smart, v.ordena_otro 
from demograficos d 
	join vulnerabilidad v using (id_demograficos)
where d.licenciatura = 'Sí';

create view sociales_utilizadas as
select sc.sociales_cuales 
from demograficos d 
	join redes_sociales rs using (id_demograficos)
	join sociales_cuales sc using (id_redes_sociales)
where d.licenciatura = 'Sí';

create view sociales_mas_utilizadas as
select rs.sociales_contar, rs.ordena_facebook, rs.ordena_instagram, rs.ordena_whatsapp, rs.ordena_twitter, rs.ordena_tiktok, 
	rs.ordena_ninguna, rs.ordena_otra 
from demograficos d 
	join redes_sociales rs using (id_demograficos)
where d.licenciatura = 'Sí';

create view compras_linea as
select pd.banca, pd.compras_online, pd.paypal, pd.cargos 
from demograficos d 
	join prevencion_digital pd using (id_demograficos)
where d.licenciatura = 'Sí';

create view cookies as
select pd.term_cond, pd.cookies, pd.cookies_accesibles, pd.publicidad 
from demograficos d 
	join prevencion_digital pd using (id_demograficos)
where d.licenciatura = 'Sí';

create view victimas as
select d.id_demograficos, v.victima 
from demograficos d 
	join prevencion_digital pd using (id_demograficos)
	join victima v using (id_prevencion_digital)
where d.licenciatura = 'Sí';

create view victima_conocido as
select pd.con_victima, pd.evitado 
from demograficos d 
	join prevencion_digital pd using (id_demograficos)
where d.licenciatura = 'Sí';

create view seguridad as
select d.id_demograficos, p.proteccion 
from demograficos d 
	join prevencion_digital pd using (id_demograficos)
	join proteccion p using (id_prevencion_digital)
where d.licenciatura = 'Sí';

create view navegacion as
select pn.navegador, pn.url, pn.phishing 
from demograficos d 
	join prevencion_navegacion pn using (id_demograficos)
where d.licenciatura = 'Sí';

create view informacion as
select mi.datos, mi.empresas, mi.preocupacion_empresas, mi.username 
from demograficos d 
	join manejo_info mi using (id_demograficos)
where d.licenciatura = 'Sí';



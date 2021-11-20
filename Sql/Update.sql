
/*
delete from respuestas
where temporal is null;

update respuestas 
set dispositivos_cantidad = ','
where dispositivos_cantidad is null;

select *, unnest(string_to_array(dispositivos_cantidad, ',')) as dispositivos_cantidad_in
into respuestas2 
from respuestas r 
order by id;

update respuestas 
set dispositivos_cantidad = null 
where dispositivos_cantidad = ' ';

*/
--------------------------------------------------------------------
/*

alter table respuestas add column id numeric(4);

update respuestas
set id=(select generate_series(1, count(r.temporal)) 
	    from respuestas r)
where id is null; 
		   
insert into respuestas (id2)
from (select generate_series(1, count(r.temporal)) 
	 from respuestas r)
*/
-------------------------------------------------------------------

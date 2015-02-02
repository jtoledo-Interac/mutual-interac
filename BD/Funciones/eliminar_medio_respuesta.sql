create or replace function public.eliminar_medio_respuesta
(
    in xcod_medio_respuesta varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            medio_respuesta
        where
            cod_medio_respuesta = xcod_medio_respuesta;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_medio_respuesta] error al eliminar medio_respuesta(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
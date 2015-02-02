create or replace function public.eliminar_medio
(
    in xcod_medio varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            medios_respuesta
        where
            cod_medio_respuesta = xcod_medio;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_medio] error al eliminar medio(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
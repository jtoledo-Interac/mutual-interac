create or replace function public.eliminar_prioridad
(
    in xcod_prioridad varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            prioridad
        where
            cod_prioridad = xcod_prioridad;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_prioridad] error al eliminar prioridad(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
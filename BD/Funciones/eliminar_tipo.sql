create or replace function public.eliminar_tipo
(
    in xcod_tipo varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            tipo
        where
            cod_tipo = xcod_tipo;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_tipo] error al eliminar tipo(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
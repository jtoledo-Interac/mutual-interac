create or replace function public.eliminar_estado
(
    in xcod_estado varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            estado
        where
            cod_estado = xcod_estado;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_estado] error al eliminar estado(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
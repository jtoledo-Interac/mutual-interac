create or replace function public.eliminar_tipo
(
    in xid_tipo numeric,
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
            id_tipo = xid_tipo;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_tipo] error al eliminar tipo(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
create or replace function public.eliminar_estado
(
    in xid_estado numeric,
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
            id_estado = xid_estado;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_estado] error al eliminar estado(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
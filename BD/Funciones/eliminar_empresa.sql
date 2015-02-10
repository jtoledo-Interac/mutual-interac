create or replace function public.eliminar_empresa
(
    in xid_empresa numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            empresa
        where
            id_empresa = xid_empresa;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_documento] error al eliminar empresa(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
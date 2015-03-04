create or replace function public.eliminar_tipo_link
(
    in xid_tipo_link numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            tipo_link
        where
            id_tipo_link = xid_tipo_link;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_tipo_link] error al eliminar tipo_link(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
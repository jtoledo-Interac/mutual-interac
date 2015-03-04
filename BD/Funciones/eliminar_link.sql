create or replace function public.eliminar_link
(
    in xid_link numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            link
        where
            id_link = xid_link;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_link] error al eliminar link(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
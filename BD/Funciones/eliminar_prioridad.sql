create or replace function public.eliminar_prioridad
(
    in xid_prioridad numeric,
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
            id_prioridad = xid_prioridad;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_prioridad] error al eliminar prioridad(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
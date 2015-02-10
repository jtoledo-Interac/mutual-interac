create or replace function public.eliminar_perfil
(
    in xid_perfil numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            perfil
        where
            id_perfil = xid_perfil;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_perfil] error al eliminar perfil(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
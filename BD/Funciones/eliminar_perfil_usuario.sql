create or replace function public.eliminar_perfil_usuario
(
    in xidusuario numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            perfil_usuario
        where
            idusuario = xidusuario;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_perfil] error al eliminar perfil(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
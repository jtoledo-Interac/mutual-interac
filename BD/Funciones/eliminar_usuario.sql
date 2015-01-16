create or replace function public.eliminar_usuario
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
            usuario
        where
            idusuario = xidusuario;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_usuario] error al eliminar usuario(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
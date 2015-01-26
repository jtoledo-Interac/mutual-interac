create or replace function public.modificar_contrasena
(
    in xidusuario integer,
    in xcontrasena varchar, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		update 
            usuario
        set 
			contrasena = xcontrasena
        where
            idusuario = xidusuario;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[modificar_usuario] error al modificar usuario(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
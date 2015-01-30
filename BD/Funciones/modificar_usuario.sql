create or replace function public.modificar_usuario
(
    in xidusuario numeric,
    in xrut varchar, 
    in xdv varchar, 
    in xnombres varchar, 
    in xapepaterno varchar, 
    in xapematerno varchar, 
    in xnomusuario varchar, 
    in xcodgenero varchar, 
    in xfecnacimiento date, 
    in xtelefono varchar, 
    in xcelular varchar, 
    in xemail varchar,
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
			rut = xrut,
			dv = xdv,
			nombres = xnombres,
			apepaterno = xapepaterno,
			apematerno = xapematerno,
			nomusuario = xnomusuario,
			codgenero = xcodgenero,
			fecnacimiento = xfecnacimiento,
			telefono = xtelefono,
			celular = xcelular,
			email = xemail
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
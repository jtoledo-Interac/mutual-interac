create or replace function public.agregar_usuario
(
    in xrut varchar, 
    in xdv varchar, 
    in xnombres varchar, 
    in xapepaterno varchar, 
    in xapematerno varchar, 
    in xnomusuario varchar, 
    in xcontrasena varchar, 
    in xcodgenero varchar, 
    in xfecnacimiento date,
    in xtelefono varchar, 
    in xcelular varchar, 
    in xemail varchar,
    out xnidusuario bigint, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xnidusuario$ bigint;

	begin
	
		xnidusuario$ := nextval('seq_usuario');
		numerror := 0;
		msjerror := '';

		insert into usuario
		(
			idusuario,
			rut,
			dv,
			nombres,
			apepaterno,
			apematerno,
			nomusuario,
			contrasena,
			codgenero,
			fecnacimiento,
			telefono,
			celular,
			email,
			feccreacion,
			indvigencia
		)
        values
		(
			xnidusuario$,
			xrut,
			xdv,
			xnombres,
			xapepaterno,
			xapematerno,
			xnomusuario,
			xcontrasena,
			xcodgenero,
			xfecnacimiento,
			xtelefono,
			xcelular,
			xemail,
			now(),
			'h'
		);

        xnidusuario := xnidusuario$;
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_usuario] error al crear usuario(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
create or replace function public.login
(
    in username varchar,
    in in_contrasena varchar,
    out out_nombre varchar, 
    out out_apellido_paterno varchar, 
    out out_apellido_materno varchar, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare _nombre       		varchar(100);
    declare _apellido_paterno	varchar(100);
	declare _apellido_materno	varchar(100);
	
    begin
        numerror := '0';
        msjerror := ' ';

        select
            nombres,
            apepaterno,
            apematerno
        into
            _nombre,
            _apellido_paterno,
            _apellido_materno
        from
            usuario
        where
            upper(nomusuario) = upper(username) and  in_contrasena = contrasena;

if found then
		out_nombre := _nombre;
		out_apellido_paterno := _apellido_paterno;
		out_apellido_materno := _apellido_materno;
    return;
else
        numerror := '1';
        msjerror := 'Datos de inicio de sesión inválidos.';
end if;
end;
$body$
language 'plpgsql'
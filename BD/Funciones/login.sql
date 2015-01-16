create or replace function public.login
(
    in username varchar,
    in contrasena_in varchar, 
    in host varchar, 
    in codaplicacion varchar, 
    in codidioma varchar, 
    out ses_idsesion varchar, 
    out ses_fhologueo varchar, 
    out ses_fhoultimaconsulta varchar, 
    out ses_scodaplicacion varchar, 
    out ses_snumusuario varchar, 
    out ses_srutusuario varchar, 
    out ses_snomusuario varchar, 
    out ses_scodidioma varchar, 
    out ses_data01 varchar, 
    out ses_data02 varchar, 
    out ses_data03 varchar, 
    out ses_data04 varchar, 
    out ses_data05 varchar, 
    out expiracontrasena varchar, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xses_idsesion       varchar(100);
    declare xnumusuario			numeric(10);
    declare xrutusuario			varchar(10);
    declare xdvusuario 			varchar(10);
    declare xusername			varchar(20);
    declare xcontrasena			varchar(40);
    declare xapepaterno 		varchar(40);
    declare xapematerno 		varchar(40);
    declare xnombre 			varchar(100);
    declare xtelefono			varchar(20);
    declare xemail 				varchar(100);
    declare xindvigencia		varchar(1);  
    declare xfhocontrasena		date;
    declare xcantintentos		numeric(4,0);
    declare xfechaactual			varchar(20);
    declare xnombre_completo	varchar(255);
    declare xrut_completo       varchar(255);

    begin
        numerror := '0';
        msjerror := ' ';

        select
            u.idusuario,
            u.rut,
            u.dv,
            u.contrasena, 
            u.apepaterno,
            u.apematerno,
            u.nombres,
            u.telefono,
            u.email,
            u.indvigencia,
            u.feccontrasena,
            u.cantintentos
        into
            xnumusuario,
            xrutusuario,
            xdvusuario,
            xcontrasena, 
            xapepaterno,
            xapematerno,
            xnombre,
            xtelefono,
            xemail,
            xindvigencia,
            xfhocontrasena,
            xcantintentos
        from
            usuario u
        where
            upper(nomusuario) = upper(username) and  contrasena_in = contrasena;

if found then



        ses_idsesion            := xses_idsesion;
        ses_fhologueo           := xfechaactual;
        ses_fhoultimaconsulta   := xfechaactual;
        ses_scodaplicacion      := codaplicacion;
        ses_snumusuario         := trim(to_char(xnumusuario, '99999999'));
        ses_srutusuario         := xrutusuario;
        ses_snomusuario         := xnombre_completo;
        ses_scodidioma          := xtelefono;
        ses_data01              := xemail;
        ses_data02              := ' ';
        ses_data03              := ' ';
        ses_data04              := ' ';
        ses_data05              := codidioma;



    return;
else
        numerror := '1';
        msjerror := 'Datos de inicio de sesión inválidos.';


end if;




    end;

$body$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION login(character varying, character varying, character varying, character varying, character varying)
  OWNER TO postgres;
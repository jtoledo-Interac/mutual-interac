create or replace function public.login
(
    in username varchar,
    in contrasena varchar, 
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
            upper(nomusuario) = upper(username);

if found then
    return;
else
RAISE EXCEPTION 'No existe el usuario %',$1;

--msjerror := 'prueba de error'||'asd'|| USING ERRCODE;
   --raise notice '%', sqlca.sqlcode;

end if;

/*
exception when others then 

    raise notice 'The transaction is in an uncommittable state. '
                 'Transaction was rolled back';

    raise notice '% %', SQLERRM, SQLSTATE;*/

        /*exception
            when no_data_found then
                numerror := '1';
                msjerror := '[login] no existe usuario '||sqlerrm;
                return;

            when others then
                numerror := '2';
                msjerror := '[login] no puede obtener usuario (sql) '||sqlerrm;
                return;
*/
/*

        if trim(xindvigencia) = 'b' then
            numerror := 3;
            msjerror := '[login] contraseña bloqueada. utilice funciÎ³n de desbloqueo en linea.';
            return;
        end if;

        if trim(xindvigencia) = 'd' then
            numerror := '4';
            msjerror := '[login] usuario deshabilitado. solicite al administrador su habilitaciÎ³n.';
            return;	
        end if;

        if trim(xindvigencia) <> 'h' then
            numerror := '5';
            msjerror := '[login] usuario no habilitado. solicite al administrador su habilitaciÎ³n.';
            return;		
        end if;

        if trim(xcontrasena) is null then
            xcontrasena := 'd41d8cd98f00b204e9800998ecf8427e';
        end if;

        if (contrasena <> xcontrasena) then
            numerror := '0';
            msjerror := ' ';

            xcantintentos := xcantintentos + 1;

            if xcantintentos >= 3 then
                xindvigencia := 'b';
            end if;

            numerror := '6';
            msjerror := '[login] la contraseña ingresada no es correcta';
            return;
        else
            numerror := '0';
            msjerror := ' ';
        end if;

        expiracontrasena := 'n';

        if xfhocontrasena <= now() then
            expiracontrasena := 's';
        end if;

        numerror := '0';
        msjerror := ' ';
        xfechaactual := to_char(now(), 'yyyymmddhh24miss') || '00';

        select 
            *
        into
            xses_idsesion,
            numerror,
            msjerror
        from
            genera_sesion (host,upper(username),xfechaactual);

        if (numerror <> '0') then 
            return;
        end if;

        numerror := '0';
        msjerror := ' ';

        begin
            delete from 
                sesion
            where
                ses_scodaplicacion = codaplicacion and
                ses_snumusuario = to_char(xnumusuario, 'fm999');

            exception
                when others then
                    numerror := '7';
                    msjerror := '[login] no puede eliminar sesion actual del usuario (sql) ||' sqlerrm;
                    return;
        end;

        numerror := '0';
        msjerror := ' ';

        xnombre_completo := trim(trim(xnombre) || ' ' || trim(xapepaterno) || ' ' || trim(xapematerno));
        xrut_completo:= trim(xrutusuario) || '-' || trim(xvusuario);

        begin

            insert into sesion 
            (
                ses_sidsesion,
                ses_dfeclogueo,
                ses_dfecultimaconsulta,
                ses_snomhost,
                ses_scodaplicacion,
                ses_snumusuario,
                ses_srutusuario,
                ses_snomusuario,
                ses_scodidioma,
                ses_sdata01,
                ses_sdata02,
                ses_sdata03,
                ses_sdata04,
                ses_sdata05
            ) 
            values 
            (
                xses_idsesion,
                now(),
                now(),
                host,
                codaplicacion,                         
                trim(to_char(xnumusuario, '99999999')),              
                xrut_completo,
                xnombre_completo,				
                xtelefono,
                xemail,
                ' ',
                ' ',
                ' ',
                codidioma
            );

            exception
                when unique_violation then
                    numerror := '8';
                    msjerror := '[login] sesion usuario ya existe';
                    return;
                when others then
                    numerror := sqlstate;
                    msjerror := '[login] no puede insertar sesion usuario (sql) '|| sqlerrm;
                    return;
        end;
*/

        ses_idsesion			:= xses_idsesion;
        ses_fhologueo 			:= xfechaactual;
        ses_fhoultimaconsulta	:= xfechaactual;
        ses_scodaplicacion		:= codaplicacion;
        ses_snumusuario         := trim(to_char(xnumusuario, '99999999'));
        ses_srutusuario         := xrutusuario;
        ses_snomusuario         := xnombre_completo;
        ses_scodidioma			:= xtelefono;
        ses_data01				:= xemail;
        ses_data02				:= ' ';
        ses_data03				:= ' ';
        ses_data04				:= ' ';
        ses_data05				:= codidioma;

    end;

$body$
language 'plpgsql'
create or replace function public.cargar_usuario
(
    in xnidusuario numeric, 
    out usuarios refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open usuarios for

            select
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
                direccion,
                idcomuna,
                idprovincia, 
                idregion,
                codpais,
                telefono,
                celular,
                email,
                cantintentos,
                feccreacion,
                feccontrasena,
                indvigencia
            from 
                usuario
            where
                idusuario = xnidusuario;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_usuarios] error al cargar usuario(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
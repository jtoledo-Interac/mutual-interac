create or replace function public.buscar_usuarios
(
    in rut$ varchar, 
    in dv$ varchar, 
    in nombres$ varchar, 
    in apepaterno$ varchar, 
    in apematerno$ varchar, 
    in nomusuario$ varchar,
    out usuarios refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xrut varchar; 
    declare xdv varchar;
    declare xnombres varchar;
    declare xapepaterno varchar;
    declare xapematerno varchar;
    declare xnomusuario varchar;

    begin
        numerror := 0;
        msjerror := ' ';

        /*filtros*/
        xrut := '%' || coalesce(upper(trim(rut$)),'') || '%';
        xnombres    := '%' ||coalesce(upper(trim(nombres$)),'') || '%';
        xapepaterno := '%' || coalesce(upper(trim(apepaterno$)),'') || '%';
        xapematerno := '%' || coalesce(upper(trim(apematerno$)),'') || '%';
        xnomusuario := '%' || coalesce(upper(trim(nomusuario$)),'') || '%';

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
            rut like xrut and
            upper(nombres) like '%' || xnombres ||'%' and
            upper(apepaterno) like xapepaterno and
            upper(apematerno) like xapematerno and
            upper(nomusuario) like xnomusuario
        order by
            idusuario; 
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_usuarios] error al buscar usuarios(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
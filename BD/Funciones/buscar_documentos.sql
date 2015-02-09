create or replace function public.buscar_documentos
(
    in xnombre$ varchar,
    in xnum_folio$ varchar,
    in xnum_adherente$ varchar,
    in xid_cartera$ numeric,
    in xid_producto$ numeric,
    in xcod_area$ varchar,
    out documentos refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xnombre varchar;
    declare xnum_folio varchar;
    declare xnum_adherente varchar;
    declare xid_cartera numeric;
    declare xid_producto numeric;
    declare xcod_area varchar;

    begin
        numerror := '0';
        msjerror := ' ';


        /*filtros*/
        xnombre := coalesce(upper(trim(xnombre$)),'') || '%';
        xnum_folio := '%' || coalesce(upper(trim(xnum_folio$)),'') || '%';
        xnum_adherente := '%' || coalesce(upper(trim(xnum_adherente$)),'') || '%';

       

        if trim(xcod_area$) = '' then
            xcod_area := ' ';
        else
            xcod_area := upper(trim(xcod_area$));
        end if;

        open documentos for

        select
            id_documento,
            nombre,
            num_folio,
            num_adherente,
            descripcion,
            d.id_cartera as id_cartera,
            c.des_cartera as des_cartera,
            d.id_producto as id_producto,
            p.des_producto as des_producto,
            d.cod_area as cod_area,
            a.des_area as des_area,
            fec_creacion
        from 
            documento d 
        inner join area as a 
            on d.cod_area = a.cod_area
        inner join cartera as c 
            on d.id_cartera = c.id_cartera
        inner join producto as p 
            on d.id_producto = p.id_producto
        where
            upper(d.nombre) like '%' || xnombre ||'%' and
            upper(d.num_folio) like xnum_folio and
            upper(d.num_adherente) like xnum_adherente and
            (xid_cartera = 0  or d.id_cartera = xid_cartera) and
            (xid_producto = 0 or d.id_producto = xid_producto) and
            (xcod_area =  ' ' or upper(d.cod_area) = xcod_area)
        order by
            id_documento;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_documentos] error al buscar documentos(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
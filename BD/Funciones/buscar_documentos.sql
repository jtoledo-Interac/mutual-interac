create or replace function public.buscar_documentos
(
    in xnombre$ varchar,
    in xnum_folio$ varchar,
    in xnum_adherente$ varchar,
    in xcod_cartera$ varchar,
    in xcod_producto$ varchar,
    in xcod_area$ varchar,
    out documentos refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xnombre varchar;
    declare xnum_folio varchar;
    declare xnum_adherente varchar;
    declare xcod_cartera varchar;
    declare xcod_producto varchar;
    declare xcod_area varchar;

    begin
        numerror := '0';
        msjerror := ' ';


        /*filtros*/
        xnombre := coalesce(upper(trim(xnombre$)),'') || '%';
        xnum_folio := '%' || coalesce(upper(trim(xnum_folio$)),'') || '%';
        xnum_adherente := '%' || coalesce(upper(trim(xnum_adherente$)),'') || '%';

        if trim(xcod_cartera$) = '' then
            xcod_cartera := ' ';
        else
            xcod_cartera := upper(trim(xcod_cartera$));
        end if;

        if trim(xcod_producto$) = '' then
            xcod_producto := ' ';
        else
            xcod_producto := upper(trim(xcod_producto$));
        end if;

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
            d.cod_cartera as cod_cartera,
            c.des_cartera as des_cartera,
            d.cod_producto as cod_producto,
            p.des_producto as des_producto,
            d.cod_area as cod_area,
            a.des_area as des_area,
            fec_creacion
        from 
            documento d 
        inner join area as a 
            on d.cod_area = a.cod_area
        inner join cartera as c 
            on d.cod_cartera = c.cod_cartera
        inner join producto as p 
            on d.cod_producto = p.cod_producto
        where
            upper(d.nombre) like '%' || xnombre ||'%' and
            upper(d.num_folio) like xnum_folio and
            upper(d.num_adherente) like xnum_adherente and
            (xcod_cartera =  ' ' or upper(d.cod_cartera) = xcod_cartera) and
            (xcod_producto =  ' ' or upper(d.cod_producto) = xcod_producto) and
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
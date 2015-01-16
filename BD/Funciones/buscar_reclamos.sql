create or replace function public.buscar_reclamos
(
    /*in xnombre$ varchar,
    in xnum_folio$ varchar,
    in xnum_adherente$ varchar,
    in xcod_cartera$ varchar,
    in xcod_producto$ varchar,
    in xcod_area$ varchar,*/
    out reclamos refcursor, 
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


        /*filtros
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
        end if;*/

        open reclamos for

        select
            id_reclamo,
            num_adherente,
            nombre_solicitante,
            email_solicitante,
            fono_solicitante,
            region_solicitante,
            cod_tipo,
            cod_motivo,
            cod_prioridad,
            cod_cartera,
            fec_ingreso,
            glosa,
            adjunto,
            observaciones,
            cod_estado,
            responsable_ingreso,
            responsable_actual,
            dias_bandeja,
            dias_sistema,
            cod_medio_respuesta,
            fec_respuesta
        from 
            reclamo r
        /*inner join area as a 
            on d.cod_area = a.cod_area
        inner join cartera as c 
            on d.cod_cartera = c.cod_cartera
        inner join producto as p 
            on d.cod_producto = p.cod_producto
        where
            upper(d.nombre) like xnombre and
            upper(d.num_folio) like xnum_folio and
            upper(d.num_adherente) like xnum_adherente and
            (xcod_cartera =  ' ' or upper(d.cod_cartera) = xcod_cartera) and
            (xcod_producto =  ' ' or upper(d.cod_producto) = xcod_producto) and
            (xcod_area =  ' ' or upper(d.cod_area) = xcod_area)*/
        order by
            id_reclamo;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_reclamos] error al buscar reclamos(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
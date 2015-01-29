create or replace function buscar_reclamos
(
        in "xnombre_solicitante$" character varying, 
        in "xnum_adherente$" character varying, 
        in "xcod_cartera$" character varying, 
        in "xcod_tipo$" character varying, 
        in "xcod_estado$" character varying, 
        in "xcod_prioridad$" character varying, 
        out reclamos refcursor, 
        out numerror character varying, 
        out msjerror character varying)
  returns record as
$body$

    declare xnombre_solicitante varchar;
    declare xnum_adherente varchar;
    declare xcod_cartera varchar;
    declare xcod_tipo varchar;
    declare xcod_estado varchar;
    declare xcod_prioridad varchar;

    begin
        numerror := '0';
        msjerror := ' ';

        
         xnombre_solicitante := coalesce(upper(trim(xnombre_solicitante$)),'') || '%';

        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
        else
            xnum_adherente := upper(trim(xnum_adherente$));
        end if;

        if trim(xcod_cartera$) = '' then
            xcod_cartera := ' ';
        else
            xcod_cartera := upper(trim(xcod_cartera$));
        end if;

         if trim(xcod_tipo$) = '' then
            xcod_tipo := ' ';
        else
            xcod_tipo := upper(trim(xcod_tipo$));
        end if;

        if trim(xcod_estado$) = '' then
            xcod_estado := ' ';
        else
            xcod_estado := upper(trim(xcod_estado$));
        end if;

        if trim(xcod_prioridad$) = '' then
            xcod_prioridad := ' ';
        else
            xcod_prioridad := upper(trim(xcod_prioridad$));           
        end if;

        open reclamos for

        select
            id_reclamo,
            num_adherente,
            nombre_solicitante,
            email_solicitante,
            fono_solicitante,
            region_solicitante,
            r.cod_tipo as cod_tipo,
            t.des_tipo as des_tipo,
            r.cod_motivo as cod_motivo,
            m.des_motivo as des_motivo,
            r.cod_prioridad as cod_prioridad,
            p.des_prioridad as des_prioridad,
            r.cod_cartera as cod_cartera,
            c.des_cartera as des_cartera,
            fec_ingreso,
            glosa,
            adjunto,
            observaciones,
            r.cod_estado as cod_estado,
            e.des_estado as des_estado,
            responsable_ingreso,
            responsable_actual,
            dias_bandeja,
            dias_sistema,
            r.cod_medio_respuesta as cod_medio_respuesta,
            me.des_medio_respuesta as des_medio_respuesta,
            fec_respuesta
        from 
            reclamo r
            inner join tipo as t
                on r.cod_tipo = t.cod_tipo
            inner join motivo as m
                on r.cod_motivo = m.cod_motivo
            inner join prioridad as p
                on r.cod_prioridad = p.cod_prioridad
            inner join cartera as c
                on r.cod_cartera = c.cod_cartera
            inner join estado as e
                on r.cod_estado = e.cod_estado
            inner join medios_respuesta me
                on r.cod_medio_respuesta = me.cod_medio_respuesta 
        where
           upper(nombre_solicitante) like '%' || xnombre_solicitante ||'%' and
            (xnum_adherente =  ' ' or upper(trim(num_adherente)) = xnum_adherente) and
            (xcod_cartera =  ' ' or upper(trim(r.cod_cartera)) = xcod_cartera) and
            (xcod_tipo =  ' ' or upper(trim(r.cod_tipo)) = xcod_tipo) and
            (xcod_estado =  ' ' or upper(trim(r.cod_estado)) = xcod_estado) and
            (xcod_prioridad =  ' ' or upper(trim(r.cod_prioridad)) = xcod_prioridad) 
          order by
            id_reclamo;
    
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_reclamos] error al buscar reclamos(sql) ' ||sqlerrm;
                return; 
    end;

$body$
  language plpgsql volatile
  cost 100;
alter function buscar_reclamos(numeric, character varying, character varying, character varying, character varying, character varying)
  owner to postgres;


CREATE OR REPLACE FUNCTION buscar_reclamos(IN "xid_reclamo$" numeric, IN "xnum_adherente$" character varying, IN "xcod_cartera$" character varying, IN "xcod_tipo$" character varying, IN "xcod_estado$" character varying, IN "xcod_prioridad$" character varying, OUT reclamos refcursor, OUT numerror character varying, OUT msjerror character varying)
  RETURNS record AS
$BODY$

    declare xid_reclamo numeric;
    declare xnum_adherente varchar;
    declare xcod_cartera varchar;
    declare xcod_tipo varchar;
    declare xcod_estado varchar;
    declare xcod_prioridad varchar;

    begin
        numerror := '0';
        msjerror := ' ';

        --TODO: falta agregar filtro para ID Reclamo
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
            d.cod_tipo,
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
        reclamo d
             inner join tipo as a
            on d.cod_tipo = a.cod_tipo
        
        
        where
            
          --  (xid_reclamo =  ' ' or cast (id_reclamo as varchar) = xid_reclamo) and
            (xnum_adherente =  ' ' or upper(d.num_adherente) = xnum_adherente) and
            (xcod_cartera =  ' ' or upper(d.cod_cartera) = xcod_cartera) and
            (xcod_tipo =  ' ' or upper(d.cod_tipo) = xcod_tipo) and
            (xcod_estado =  ' ' or upper(d.cod_estado) = xcod_estado) and
            (xcod_prioridad =  ' ' or upper(d.cod_prioridad) = xcod_prioridad) 

          order by
            id_reclamo;
    
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_reclamos] error al buscar reclamos(sql) ' ||sqlerrm;
                return; 
    end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION buscar_reclamos(numeric, character varying, character varying, character varying, character varying, character varying)
  OWNER TO postgres;

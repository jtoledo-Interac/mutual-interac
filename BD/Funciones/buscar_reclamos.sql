
create or replace function buscar_reclamos
(
    in "xnombre_solicitante$" character varying, 
    in "xnum_adherente$" character varying, 
    in "xid_cartera$" numeric, 
    in "xid_tipo$" numeric, 
    in "xid_estado$" numeric, 
    in "xid_prioridad$" numeric, 
    in "xid_reclamo$" numeric, 
    out reclamos refcursor, 
    out numerror character varying, 
    out msjerror character varying
)
  returns record as
$body$

    declare xid_reclamo numeric;
    declare xnombre_solicitante varchar;
    declare xnum_adherente varchar;
    declare xid_cartera numeric;
    declare xid_tipo numeric;
    declare xid_estado numeric;
    declare xid_prioridad numeric;

    begin
        numerror := 0;
        msjerror := ' ';

        
        xnombre_solicitante := coalesce(upper(trim(xnombre_solicitante$)),'') || '%';
    
       
        xid_reclamo=xid_reclamo$;
    

        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
        else
            xnum_adherente := upper(trim(xnum_adherente$));
        end if;

          
        xid_cartera=xid_cartera$;
        xid_tipo=xid_tipo$;
        xid_estado=xid_estado$;
        xid_prioridad=xid_prioridad$;
       

        open reclamos for

        select
            id_reclamo,
            num_adherente,
            nombre_solicitante,
            email_solicitante,
            fono_solicitante,
            region_solicitante,
            r.id_tipo as id_tipo,
            t.des_tipo as des_tipo,
            r.id_motivo as id_motivo,
            m.des_motivo as des_motivo,
            r.id_prioridad as id_prioridad,
           p.des_prioridad as des_prioridad,
           r.id_cartera as id_cartera,
            c.des_cartera as des_cartera,
            fec_ingreso,
            glosa,
            adjunto,
            observaciones,
            r.id_estado as id_estado,
            e.des_estado as des_estado,
            responsable_ingreso,
            responsable_actual,
            dias_bandeja,
            dias_sistema,
            r.id_medio_respuesta as id_medio_respuesta,
            me.des_medio_respuesta as des_medio_respuesta,
            fec_respuesta
        from 
            reclamo r
           inner join tipo as t
                on r.id_tipo = t.id_tipo
           inner join motivo as m
                on r.id_motivo = m.id_motivo
            inner join prioridad as p
                on r.id_prioridad = p.id_prioridad
            inner join cartera as c
                on r.id_cartera = c.id_cartera
            inner join estado as e
                on r.id_estado = e.id_estado
            inner join medios_respuesta me
                on r.id_medio_respuesta = me.id_medio_respuesta         
      where
          upper(nombre_solicitante) like '%' || xnombre_solicitante ||'%'            and
            (xnum_adherente =  ' ' or upper(trim(num_adherente)) = xnum_adherente)and
            (xid_cartera =   0 or r.id_cartera = xid_cartera) and
            (xid_tipo =      0 or r.id_tipo = xid_tipo) and
            (xid_estado =    0 or r.id_estado = xid_estado) and
            (xid_prioridad = 0 or r.id_prioridad = xid_prioridad) and
            (xid_reclamo =   0 or id_reclamo = xid_reclamo)
        
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
  
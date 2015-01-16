create or replace function public.cargar_reclamo
(
    in xid_reclamo numeric, 
    out reclamos refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
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
                reclamo
            where
                id_reclamo = xid_reclamo;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_reclamo] error al cargar reclamo(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
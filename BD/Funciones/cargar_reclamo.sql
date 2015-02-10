create or replace function public.cargar_reclamo
(
    in xid_reclamo numeric, 
    out reclamos refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';
    begin
        open reclamos for

            select
                id_reclamo,
                num_adherente,
                nombre_solicitante,
                email_solicitante,
                fono_solicitante,
                region_solicitante,
                id_tipo,
                id_motivo,
                id_prioridad,
                id_cartera,
                fec_ingreso,
                glosa,
                adjunto,
                observaciones,
                id_estado,
                responsable_ingreso,
                responsable_actual,
                dias_bandeja,
                dias_sistema,
                id_medio_respuesta,
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
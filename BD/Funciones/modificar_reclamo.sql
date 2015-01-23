create or replace function public.modificar_reclamo
(
	in id_reclamo integer,
	in xnum_adherente varchar,
	in xnombre_solicitante varchar,
	in xemail_solicitante varchar,
	in xfono_solicitante varchar,
	in xregion_solicitante varchar,
	in xcod_tipo varchar,
	in xcod_motivo varchar,
	in xcod_prioridad varchar,
	in xcod_cartera varchar,
	in xfec_ingreso varchar,
	in xglosa varchar,
	in xadjunto varchar,
	in xobservaciones varchar,
	in xcod_estado varchar,
	in xresponsable_ingreso varchar,
	in xresponsable_actual varchar,
	in xdias_bandeja varchar,
	in xdias_sistema varchar,
	in xcod_medio_respuesta varchar,
	in xfec_respuesta varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$


	begin
	
		numerror := 0;
		msjerror := '';

		update 
			reclamo
		set
		
			num_adherente = xnum_adherente,
			nombre_solicitante = xnombre_solicitante,
			email_solicitante = xemail_solicitante,
			fono_solicitante = xfono_solicitante, 
			region_solicitante = xregion_solicitante,
			cod_tipo = xcod_tipo,
			cod_motivo = xcod_motivo,
			cod_prioridad = xcod_prioridad,
			cod_cartera = xcod_cartera,
			fec_ingreso = xfec_ingreso,
			glosa = xglosa,
			adjunto = xadjunto,
			observaciones = xobservaciones,
			cod_estado = xcod_estado,
			responsable_ingreso = xresponsable_ingreso,
			responsable_actual = xresponsable_actual,
			dias_bandeja = xdias_bandeja,
			dias_sistema = xdias_sistema,
			cod_medio_respuesta = xcod_medio_respuesta,
			fec_respuesta = xfec_respuesta
		
		where
        id_reclamo = xid_reclamo;
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_reclamo] error al crear reclamo(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
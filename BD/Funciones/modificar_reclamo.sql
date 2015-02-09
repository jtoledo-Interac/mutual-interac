create or replace function public.modificar_reclamo
(
	in xid_reclamo integer,
	in xnum_adherente varchar,
	in xnombre_solicitante varchar,
	in xemail_solicitante varchar,
	in xfono_solicitante varchar,
	in xregion_solicitante varchar,
	in xid_tipo numeric,
	in xid_motivo numeric,
	in xid_prioridad numeric,
	in xid_cartera numeric,
	in xfec_ingreso varchar,
	in xglosa varchar,
	in xadjunto varchar,
	in xobservaciones varchar,
	in xid_estado numeric,
	in xresponsable_ingreso varchar,
	in xresponsable_actual varchar,
	in xdias_bandeja varchar,
	in xdias_sistema varchar,
	in xid_medio_respuesta numeric,
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
			id_tipo = xid_tipo,
			id_motivo = xid_motivo,
			id_prioridad = xid_prioridad,
			id_cartera = xid_cartera,
			fec_ingreso = xfec_ingreso,
			glosa = xglosa,
			adjunto = xadjunto,
			observaciones = xobservaciones,
			id_estado = xid_estado,
			responsable_ingreso = xresponsable_ingreso,
			responsable_actual = xresponsable_actual,
			dias_bandeja = xdias_bandeja,
			dias_sistema = xdias_sistema,
			id_medio_respuesta = xid_medio_respuesta,
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
create or replace function public.agregar_reclamo
(
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
    out xid_reclamo bigint, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xid_reclamo$ bigint;

	begin
	
		xid_reclamo$ := nextval('seq_reclamo');
		numerror := 0;
		msjerror := '';

		insert into reclamo
		(
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
		)
        values
		(
			xid_reclamo$,
			xnum_adherente,
			xnombre_solicitante,
			xemail_solicitante,
			xfono_solicitante,
			xregion_solicitante,
			xcod_tipo,
			xcod_motivo,
			xcod_prioridad,
			xcod_cartera,
			xfec_ingreso,
			xglosa,
			xadjunto,
			xobservaciones,
			xcod_estado,
			xresponsable_ingreso,
			xresponsable_actual,
			xdias_bandeja,
			xdias_sistema,
			xcod_medio_respuesta,
			xfec_respuesta
		);

        xid_reclamo := xid_reclamo$;
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_reclamo] error al crear reclamo(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
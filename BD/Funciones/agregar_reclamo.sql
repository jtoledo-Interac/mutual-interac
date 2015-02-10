
create or replace function agregar_reclamo
(
	in xnum_adherente character varying, 
	in xnombre_solicitante character varying, 
	in xemail_solicitante character varying, 
	in xfono_solicitante character varying, 
	in xregion_solicitante character varying, 
	in xid_tipo numeric, 
	in xid_motivo numeric, 
	in xid_prioridad numeric, 
	in xid_cartera numeric, 
	in xfec_ingreso timestamp without time zone, 
	in xglosa character varying, 
	in xadjunto character varying, 
	in xobservaciones character varying, 
	in xid_estado numeric, 
	in xresponsable_ingreso character varying, 
	in xresponsable_actual character varying, 
	in xdias_bandeja character varying, 
	in xdias_sistema character varying, 
	in xid_medio_respuesta numeric, 
	in xfec_respuesta timestamp without time zone, 
	out xid_reclamo bigint, 
	out numerror character varying, 
	out msjerror character varying
)
  returns record as
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
		)
        values
		(
			xid_reclamo$,
			xnum_adherente,
			xnombre_solicitante,
			xemail_solicitante,
			xfono_solicitante,
			xregion_solicitante,
			xid_tipo,
			xid_motivo,
			xid_prioridad,
			xid_cartera,
			xfec_ingreso,
			xglosa,
			xadjunto,
			xobservaciones,
			xid_estado,
			xresponsable_ingreso,
			xresponsable_actual,
			xdias_bandeja,
			xdias_sistema,
			xid_medio_respuesta,
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
  language plpgsql volatile
  cost 100;

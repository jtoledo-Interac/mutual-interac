
CREATE OR REPLACE FUNCTION agregar_reclamo(IN xnum_adherente character varying, IN xnombre_solicitante character varying, IN xemail_solicitante character varying, IN xfono_solicitante character varying, IN xregion_solicitante character varying, IN xid_tipo numeric, IN xid_motivo numeric, IN xid_prioridad numeric, IN xid_cartera numeric, IN xfec_ingreso timestamp without time zone, IN xglosa character varying, IN xadjunto character varying, IN xobservaciones character varying, IN xid_estado numeric, IN xresponsable_ingreso character varying, IN xresponsable_actual character varying, IN xdias_bandeja character varying, IN xdias_sistema character varying, IN xid_medio_respuesta numeric, IN xfec_respuesta timestamp without time zone, OUT xid_reclamo bigint, OUT numerror character varying, OUT msjerror character varying)
  RETURNS record AS
$BODY$

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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

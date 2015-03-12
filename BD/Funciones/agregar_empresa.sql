create or replace function public.agregar_empresa
(
	IN xnum_adherente varchar,IN  xnombre varchar,IN  xdireccion varchar,IN  xnom_experto varchar,IN xrazon_social varchar,IN xcod_cartera varchar,IN xrepresentante varchar,
IN xcontacto_representante varchar,IN  xnombre_prevencionista varchar,IN xcontacto_prevencionista varchar,IN xmasa_sum varchar,IN xsegmentacion varchar,
IN xmultiregional varchar,IN xnum_centros varchar,IN xholding varchar,IN xnum_CHPS varchar,IN xnom_presidente varchar,IN xnom_secretario varchar,
IN xsaami varchar,IN xamputaciones varchar,IN xfatales varchar,IN xproyectos_desarrollados varchar,IN xnum_CPHScertificados varchar,
IN xtipo_certificacion varchar,IN xfecha_certificacion varchar,IN xfecha_caducidad varchar,IN xfecha_certificacionPECE varchar,
IN xfecha_caducidadPECE varchar,IN xnivel_logroPECE varchar,IN Xfecha_proxAuditoriaPECE varchar,IN xfecha_certificacionPECC varchar,IN xfecha_caducidadPECC varchar,
IN xnivel_logroPECC varchar,IN xfecha_proxAuditoriaPECC varchar,IN xfecha_certificacionPECEX varchar,IN xfecha_caducidadPECEX varchar,
IN xnivel_logroPECEx varchar,IN xfecha_proxAuditoriaPECEX varchar,IN xtasa_accidentabilidad varchar,IN xsiniestralidad varchar,IN xfatales_acc varchar,
IN xinvalidez varchar,IN xadherenciaPREX varchar,IN xfecha_adherenciaPREX varchar,IN xfecha_vencimientoPREX varchar,IN xindemnizacionesPREX varchar,
IN xnum_casosIndemnizacionesPREX varchar,IN xpensionesPREX varchar,IN xnum_casosPensionesPREX varchar,IN xactas_difusionPrex varchar,IN xnivel_exposicionPREX varchar,
IN xadherenciaPLAN varchar,IN xfecha_adherenciaPLAN varchar,IN xfecha_vencimientoPLAN varchar,IN xindemnizacionesPLAN varchar,IN xnum_casosIndemnizacionPLAN varchar,
IN xpensionesPLAN varchar,IN xnum_casosPensionesPLAN varchar,IN xactas_difusionPLAN varchar,IN xnivel_exposicionPLAN varchar,IN xadherenciaPSICO varchar,
IN xdifusion_protocolo varchar, OUT numerror varchar, OUT msjerror varchar
) returns record as

$body$

    

	begin	
		
		numerror := 0;
		msjerror := '';

		insert into empresa
		(
			num_adherente,
			nombre,
			direccion,
			nom_experto,
			razon_social,
			cod_cartera,
			representante,
			contacto_representante,
			nombre_prevencionista,
			contacto_prevencionista,
			masa_sum,
			segmentacion,
			multiregional,
			num_centros,
			holding,
			num_CHPS,
			nom_presidente,
			nom_secretario,
			saami,
			amputaciones,
			fatales,
			proyectos_desarrollados,
			--certificaciones CPHS
			num_CPHScertificados ,
			tipo_certificacion ,
			fecha_certificacion ,
			fecha_caducidad ,
			--- PEC ESTANDAR
			fecha_certificacionPECE ,
			fecha_caducidadPECE ,
			nivel_logroPECE ,
			fecha_proxAuditoriaPECE ,
			--- PEC COMPETITIVA
			fecha_certificacionPECC ,
			fecha_caducidadPECC ,
			nivel_logroPECC ,
			fecha_proxAuditoriaPECC ,
			--- PEC EXCELENCIA
			fecha_certificacionPECEX ,
			fecha_caducidadPECEX ,
			nivel_logroPECEx ,
			fecha_proxAuditoriaPECEX ,
			--- Accidentabilidad
			tasa_accidentabilidad ,
			siniestralidad ,
			fatales_acc ,
			invalidez ,
			--- protocolos Prexor
			adherenciaPREX ,
			fecha_adherenciaPREX ,
			fecha_vencimientoPREX ,
			indemnizacionesPREX ,
			num_casosIndemnizacionesPREX ,
			pensionesPREX ,
			num_casosPensionesPREX ,
			actas_difusionPrex ,
			nivel_exposicionPREX ,
			---PLANESI
			adherenciaPLAN ,
			fecha_adherenciaPLAN ,
			fecha_vencimientoPLAN ,
			indemnizacionesPLAN ,
			num_casosIndemnizacionPLAN ,
			pensionesPLAN ,
			num_casosPensionesPLAN ,
			actas_difusionPLAN ,
			nivel_exposicionPLAN ,
			---PSICOSOCIAL
			adherenciaPSICO ,
			  ---TMERS
			difusion_protocolo
		)
        values
		(
			xnum_adherente,
			xnombre,
			xdireccion,
			xnom_experto,
			xrazon_social,
			xcod_cartera,
			xrepresentante,
			xcontacto_representante,
			xnombre_prevencionista,
			xcontacto_prevencionista,
			xmasa_sum,
			xsegmentacion,
			xmultiregional,
			xnum_centros,
			xholding,
			xnum_CHPS,
			xnom_presidente,
			xnom_secretario,
			xsaami,
			xamputaciones,
			xfatales,
			xproyectos_desarrollados,
			--certificaciones CPHS
			xnum_CPHScertificados ,
			xtipo_certificacion ,
			xfecha_certificacion ,
			xfecha_caducidad ,
			--- PEC ESTANDAR
			xfecha_certificacionPECE ,
			xfecha_caducidadPECE ,
			xnivel_logroPECE ,
			xfecha_proxAuditoriaPECE ,
			--- PEC COMPETITIVA
			xfecha_certificacionPECC ,
			xfecha_caducidadPECC ,
			xnivel_logroPECC ,
			xfecha_proxAuditoriaPECC ,
			--- PEC EXCELENCIA
			xfecha_certificacionPECEX ,
			xfecha_caducidadPECEX ,
			xnivel_logroPECEx ,
			xfecha_proxAuditoriaPECEX ,
			--- Accidentabilidad
			xtasa_accidentabilidad ,
			xsiniestralidad ,
			xfatales_acc ,
			xinvalidez ,
			--- protocolos Prexor
			xadherenciaPREX ,
			xfecha_adherenciaPREX ,
			xfecha_vencimientoPREX ,
			xindemnizacionesPREX ,
			xnum_casosIndemnizacionesPREX ,
			xpensionesPREX ,
			xnum_casosPensionesPREX ,
			xactas_difusionPrex ,
			xnivel_exposicionPREX ,
			---PLANESI
			xadherenciaPLAN ,
			xfecha_adherenciaPLAN ,
			xfecha_vencimientoPLAN ,
			xindemnizacionesPLAN ,
			xnum_casosIndemnizacionPLAN ,
			xpensionesPLAN ,
			xnum_casosPensionesPLAN ,
			xactas_difusionPLAN ,
			xnivel_exposicionPLAN ,
			---PSICOSOCIAL
			xadherenciaPSICO ,
			  ---TMERS
			xdifusion_protocolo
		);

       
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_empresa] error al crear empresa(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
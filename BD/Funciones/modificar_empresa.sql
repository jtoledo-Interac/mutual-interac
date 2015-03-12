create or replace function public.modificar_empresa
(
    IN xid_empresa numeric,IN xnum_adherente varchar,IN  xnombre varchar,IN  xdireccion varchar,IN  xnom_experto varchar,IN xrazon_social varchar,IN xcod_cartera varchar,IN xrepresentante varchar,
IN xcontacto_representante varchar,IN  xnombre_prevencionista varchar,IN xcontacto_prevencionista varchar,IN xmasa_sum varchar,IN xsegmentacion varchar,
IN xmultiregional varchar,IN xnum_centros varchar,IN xholding varchar,IN xnum_CHPS varchar,IN xnom_presidente varchar,IN xnom_secretario varchar,
IN xsaami varchar,IN xamputaciones varchar,IN xfatales varchar,IN xproyectos_desarrollados varchar,IN xnum_CPHScertificados varchar,
IN xtipo_certificacion varchar,IN xfecha_certificacion varchar,IN xfecha_caducidad varchar,IN xfecha_certificacionPECE varchar,
IN xfecha_caducidadPECE varchar,IN xnivel_logroPECE varchar,IN Xfecha_proxAuditoriaPECE varchar,IN xfecha_certificacionPECC varchar,IN xfecha_caducidadPECC varchar,
IN xnivel_logroPECC varchar,IN xfecha_proxAuditoriaPECC varchar,IN xfecha_certificacionPECEX varchar,IN xfecha_caducidadPECEX varchar,
IN xnivel_logroPECEx varchar,IN xfecha_proxAuditoriaPECEX varchar,IN xtasa_accidentabilidad varchar,IN xsiniestralidad varchar,IN xfatales_acc varchar,
IN xinvalidez varchar,IN xadherenciaPREX varchar,IN xfecha_adherenciaPREX varchar,IN xfecha_vencimientoPREX varchar,IN xindemnizacionesPREX varchar,
IN xnum_casosIndemnizacionesPREX varchar,IN xpensionesPREX varchar,IN xnum_casosPensionesPREX varchar,IN xactas_difusionePrex varchar,IN xnivel_exposicionPREX varchar,
IN xadherenciaPLAN varchar,IN xfecha_adherenciaPLAN varchar,IN xfecha_vencimientoPLAN varchar,IN xindemnizacionesPLAN varchar,IN xnum_casosIndemnizacionPLAN varchar,
IN xpensionesPLAN varchar,IN xnum_casosPensionesPLAN varchar,IN xactas_difusionPLAN varchar,IN xnivel_exposicionPLAN varchar,IN xadherenciaPSICO varchar,
IN xdifusion_protocolo varchar, OUT numerror varchar, OUT msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            empresa
        set 
            nombre = xnombre,
            num_adherente = xnum_adherente,
			id_empresa = xid_empresa,
			direccion = xdireccion,
			nom_experto = xnom_experto,
			razon_social = xrazon_social ,
			cod_cartera = xcod_cartera,
			representante = xrepresentante,
			contacto_representante = xcontacto_representante,
			nombre_prevencionista = xnombre_prevencionista,
			contacto_prevencionista = xcontacto_prevencionista,
			masa_sum = xmasa_sum,
			segmentacion = xsegmentacion,
			multiregional = xmultiregional,
			num_centros = xnum_centros,
			holding = xholding,
			num_CHPS = xnum_CHPS,
			nom_presidente = xnom_presidente,
			nom_secretario = xnom_secretario,
			saami = xsaami,
			amputaciones = xamputaciones,
			fatales = xfatales,
			proyectos_desarrollados = xproyectos_desarrollados,
			--certificaciones CPHS
			num_CPHScertificados = xnum_CPHScertificados,
			tipo_certificacion = xtipo_certificacion,
			fecha_certificacion = xfecha_certificacion,
			fecha_caducidad = xfecha_caducidad,
			--- PEC ESTANDAR
			fecha_certificacionPECE = xfecha_certificacionPECE,
			fecha_caducidadPECE = xfecha_caducidadPECE,
			nivel_logroPECE = xnivel_logroPECE,
			fecha_proxAuditoriaPECE = xfecha_certificacionPECE,
			--- PEC COMPETITIVA
			fecha_certificacionPECC = xfecha_certificacionPECC,
			fecha_caducidadPECC = xfecha_caducidadPECC,
			nivel_logroPECC = xnivel_logroPECC,
			fecha_proxAuditoriaPECC = xfecha_proxAuditoriaPECC,
			--- PEC EXCELENCIA
			fecha_certificacionPECEX = xfecha_certificacionPECEX,
			fecha_caducidadPECEX = xfecha_caducidadPECEX,
			nivel_logroPECEx = xnivel_logroPECEx,
			fecha_proxAuditoriaPECEX = xfecha_proxAuditoriaPECEX,
			--- Accidentabilidad
			tasa_accidentabilidad = xtasa_accidentabilidad,
			siniestralidad = xsiniestralidad,
			fatales_acc = xfatales_acc,
			invalidez = xinvalidez,
			--- protocolos Prexor
			adherenciaPREX = xadherenciaPREX,
			fecha_adherenciaPREX = xfecha_adherenciaPREX,
			fecha_vencimientoPREX = xfecha_vencimientoPREX,	
			indemnizacionesPREX = xindemnizacionesPREX,
			num_casosIndemnizacionesPREX = xnum_casosIndemnizacionesPREX,
			pensionesPREX = xpensionesPREX,
			num_casosPensionesPREX = xnum_casosPensionesPREX,
			actas_difusionePrex = xactas_difusionePrex,
			nivel_exposicionPREX = xnivel_exposicionPREX,
			---PLANESI
			adherenciaPLAN = xadherenciaPLAN,
			fecha_adherenciaPLAN = xfecha_adherenciaPLAN,
			fecha_vencimientoPLAN = xfecha_vencimientoPLAN,
			indemnizacionesPLAN = xindemnizacionesPLAN,
			num_casosIndemnizacionPLAN = xnum_casosIndemnizacionPLAN,
			pensionesPLAN = xpensionesPLAN,
			num_casosPensionesPLAN = xnum_casosPensionesPLAN,
			actas_difusionPLAN = xactas_difusionPLAN,
			nivel_exposicionPLAN = xnivel_exposicionPLAN,
			---PSICOSOCIAL
			adherenciaPSICO = xadherenciaPSICO,
			---TMERS
			difusion_protocolo = xdifusion_protocolo

        where
            id_empresa = xid_empressa;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_empresa] error al modificar empresa(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
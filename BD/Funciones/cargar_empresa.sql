create or replace function public.cargar_empresa
(
    in xid_empresa numeric, 
    out empresas refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';
    begin

        numerror := 0;
        msjerror := '';
        open empresas for

            select
            num_adherente,
			nombre,
			id_empresa,
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
            from 
                empresa
            where
                id_empresa = xid_empresa;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_empresa] error al cargar empresa(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
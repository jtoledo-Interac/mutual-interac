﻿create or replace function public.cargar_empresa
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
            id_empresa,
            num_adherente,
			nombre,
			cod_cartera,
			nom_experto,
			razon_social,
			ano_de_adhesion,
			segmentacion,
			holding,
			estrategica,
			situacion,
			multi_region,
			casa_matriz,
			num_centros_trabajo,
			masa_sum_metropilitana ,
			masa_sum_nacional ,
			planes_de_cuenta ,
			planes_de_trabajo ,
			firma_de_planes ,
			sistema_de_gestion ,
			firma_protocolo ,
			etapa_sistema_gestion ,
			num_cphs ,
			num_cphs_certificado ,
			num_cphs_bronce ,
			num_cphs_plata ,
			num_cphs_oro ,
			prexor,
			prexor_etapa ,
			prexor_texto ,
			planesi ,
			planesi_etapa ,
			planesi_texto ,
			asbesto,
			asbesto_etapa,
			asbesto_texto,
			hipobaria ,
			hipobaria_etapa ,
			hipobaria_texto ,
			radiaciones ,
			radiaciones_etapa ,
			radiaciones_texto ,
			asma ,
			asma_etapa ,
			asma_texto ,
			solventes ,
			solventes_etapa ,
			solventes_texto ,
			metales,
			metales_etapa,
			metales_texto,
			oxido ,
			oxido_etapa ,
			oxido_texto ,
			plaguicida ,
			plaguicida_etapa ,
			plaguicida_texto ,
			psicosociales ,
			psicosociales_etapa ,
			psicosociales_texto ,
			mmc ,
			mmc_etapa ,
			mmc_texto ,
			tmert ,
			tmert_etapa ,
			tmert_texto ,
			radiacion_uv ,
			radiacion_uv_etapa ,
			radiacion_uv_texto ,
			ultima_visita_experto,
			ultima_visita_director,
			ultima_visita_gtte,
			ultima_visita_alta_gerencia,
			reporte_visita ,
			riesgo_de_fuga ,
			reclamo_ultimo_periodo,
			participacion_mesa_trabajo 
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
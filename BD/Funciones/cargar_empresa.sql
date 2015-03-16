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
			    cod_cartera,
			    nom_experto,
			    razon_social,
			    ano_de_adhesion,
			    segmentacion,
			    holding,
			    situacion,
			    multi_region,
			    casa_matriz,
			    region_casa_matriz,
			    masa_sum,
			    planes_de_cuenta,
			    planes_de_trabajo,
			    firma_de_planes,
			    sistema_de_gestion,
			    constitucion_cphs,
			    certificacion_cphs,
			    mmc,
			    tmert,
			    planesi,
			    plaguicida,
			    radiacion_uv,
			    hipobaria,
			    prexor,
			    psicosociales,
			    proyecto_investigacion,
			    ultima_visita_experto,
			    ultima_visita_director,
			    ultima_visita_gtte,
			    ultima_visita_alta_gerencia,
			    reporte_visita,
			    riesgo_de_fuga,
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
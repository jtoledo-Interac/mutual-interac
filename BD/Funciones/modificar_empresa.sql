create or replace function public.modificar_empresa
(
    IN xid_empresa numeric,
	IN xnum_adherente varchar,
	IN xnombre varchar,
	IN xcod_cartera varchar,
	IN xnom_experto varchar,
	IN xrazon_social varchar,
	IN xano_de_adhesion timestamp,
	IN xsegmentacion varchar,
	IN xholding varchar,
	IN xsituacion varchar,
	IN xmulti_region varchar,
	IN xcasa_matriz varchar,
	IN xregion_casa_matriz varchar,
	IN xmasa_sum varchar,
    IN xplanes_de_cuenta varchar,
    IN xplanes_de_trabajo varchar,
    IN xfirma_de_planes varchar,
    IN xsistema_de_gestion varchar,
    IN xconstitucion_cphs varchar,
    IN xcertificacion_cphs varchar,
    IN xmmc varchar,
    IN xtmert varchar,
    IN xplanesi varchar,
    IN xplaguicida varchar,
    IN xradiacion_uv varchar,
    IN xhipobaria varchar,
    IN xprexor varchar,
    IN xpsicosociales varchar,
    IN xproyecto_investigacion varchar,
    IN xultima_visita_experto timestamp,
    IN xultima_visita_director timestamp,
    IN xultima_visita_gtte timestamp,
    IN xultima_visita_alta_gerencia timestamp,
    IN xreporte_visita varchar,
    IN xriesgo_de_fuga varchar,
    IN xreclamo_ultimo_periodo timestamp,
    IN xparticipacion_mesa_trabajo varchar,
	OUT numerror varchar,
	OUT msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            empresa
        set 
	    num_adherente = xnum_adherente,
	    nombre = xnombre,
	    cod_cartera = xcod_cartera,
	    nom_experto = xnom_experto,
	    razon_social = xrazon_social,
	    ano_de_adhesion = xano_de_adhesion,
	    segmentacion = xsegmentacion,
	    holding = xholding,
	    situacion = xsituacion,
	    multi_region = xmulti_region,
	    casa_matriz = xcasa_matriz,
	    region_casa_matriz = xregion_casa_matriz,
	    masa_sum = xmasa_sum,
	    planes_de_cuenta = xplanes_de_cuenta,
	    planes_de_trabajo = xplanes_de_trabajo,
	    firma_de_planes = xfirma_de_planes,
	    sistema_de_gestion = xsistema_de_gestion,
	    constitucion_cphs = xconstitucion_cphs,
	    certificacion_cphs = xcertificacion_cphs,
	    mmc = xmmc,
	    tmert = xtmert,
	    planesi = xplanesi,
	    plaguicida = xplaguicida,
	    radiacion_uv = xradiacion_uv,
	    hipobaria = xhipobaria,
	    prexor = xprexor,
	    psicosociales = xpsicosociales,
	    proyecto_investigacion = xproyecto_investigacion,
	    ultima_visita_experto = xultima_visita_experto,
	    ultima_visita_director = xultima_visita_director,
	    ultima_visita_gtte = xultima_visita_gtte,
	    ultima_visita_alta_gerencia = xultima_visita_alta_gerencia,
	    reporte_visita = xreporte_visita,
	    riesgo_de_fuga = xriesgo_de_fuga,
	    reclamo_ultimo_periodo = xreclamo_ultimo_periodo,
	    participacion_mesa_trabajo = xparticipacion_mesa_trabajo

        where
            id_empresa = xid_empresa;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_empresa] error al modificar empresa(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
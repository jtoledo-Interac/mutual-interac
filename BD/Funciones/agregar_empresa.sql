create or replace function public.agregar_empresa
(
	IN xnum_adherente varchar,
	IN xnombre varchar,
	IN xcod_cartera varchar,
	IN xnom_experto varchar,
	IN xrazon_social varchar,
	IN xano_de_adhesion varchar,
	IN xsegmentacion varchar,
	IN xholding varchar,
	IN xsituacion varchar,
	IN xmulti_region varchar,
	IN xcasa_matriz varchar,
	IN xregion_casa_matriz varchar,
	IN xmesa_sum varchar,
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

		insert into empresa
		(
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
	    mesa_sum,
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
		)
        values
		(
	    xnum_adherente,
	    xnombre,
	    xcod_cartera,
	    xnom_experto,
	    xrazon_social,
	    xano_de_adhesion,
	    xsegmentacion,
	    xholding,
	    xsituacion,
	    xmulti_region,
	    xcasa_matriz,
	    xregion_casa_matriz,
	    xmesa_sum,
	    xplanes_de_cuenta,
	    xplanes_de_trabajo,
	    xfirma_de_planes,
	    xsistema_de_gestion,
	    xconstitucion_cphs,
	    xcertificacion_cphs,
	    xmmc,
	    xtmert,
	    xplanesi,
	    xplaguicida,
	    xradiacion_uv,
	    xhipobaria,
	    xprexor,
	    xpsicosociales,
	    xproyecto_investigacion,
	    xultima_visita_experto,
	    xultima_visita_director,
	    xultima_visita_gtte,
	    xultima_visita_alta_gerencia,
	    xreporte_visita,
	    xriesgo_de_fuga,
	    xreclamo_ultimo_periodo,
	    xparticipacion_mesa_trabajo
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
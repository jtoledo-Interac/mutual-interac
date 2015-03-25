CREATE TABLE public.empresa (
    id_empresa serial not null,
    num_adherente varchar(200) not null,
    nombre	varchar(200) null,
    cod_cartera varchar(200) null,
    nom_experto varchar(200) null,
    razon_social varchar(200) null,
    ano_de_adhesion timestamp null,
    segmentacion varchar(200) null,
    holding varchar(200) null,
    situacion varchar(200) null,
    multi_region varchar(200) null,
    casa_matriz varchar(200) null,
    num_centros_trabajo varchar(200) null,
    masa_sum_metropilitana varchar(200) null,
    masa_sum_nacional varchar(200) null,
    planes_de_cuenta varchar(200) null,
    planes_de_trabajo varchar(200) null,
    firma_de_planes varchar(200) null,
    sistema_de_gestion varchar(200) null,
    firma_protocolo timestamp null,
    etapa_sistema_gestion varchar(200) null,
    num_cphs varchar(200) null,
    num_cphs_certificado varchar(200) null,
    num_cphs_bronce varchar(200) null,
    num_cphs_plata varchar(200) null,
    num_cphs_oro varchar(200) null,
    prexor varchar (200) null,
    prexor_etapa varchar(200) null,
    prexor_texto varchar(200) null,
    planesi varchar(200) null,
    planesi_etapa varchar(200) null,
    planesi_texto varchar(200) null,
    hipobaria varchar(200) null,
    hipobaria_etapa varchar(200) null,
    hipobaria_texto varchar(200) null,
    radiaciones varchar(200) null,
    radiaciones_etapa varchar(200) null,
    radiaciones_texto varchar(200) null,
    asma varchar(200) null,
    asma_etapa varchar(200) null,
    asma_texto varchar(200) null,
    psicosociales varchar(200) null,
    proyecto_investigacion varchar(200) null,
    ultima_visita_experto timestamp null,
    ultima_visita_director timestamp null,
    ultima_visita_gtte timestamp null,
    ultima_visita_alta_gerencia timestamp null,
    reporte_visita varchar(200) null,
    riesgo_de_fuga varchar(200) null,
    reclamo_ultimo_periodo timestamp,
    participacion_mesa_trabajo varchar(200) null,
    primary key(id_empresa)
);
create table public.reclamo
( 
	id_reclamo integer not null,
	num_adherente varchar(100) null,
	nombre_solicitante varchar(100) null,
	email_solicitante varchar(100) null,
	fono_solicitante varchar(1000) null,
	region_solicitante varchar(100) null,
	cod_tipo varchar(100) null,
	cod_motivo varchar(100) null,
	cod_prioridad varchar(100) null,
	cod_cartera varchar(100) null,
	fec_ingreso timestamp null,
	glosa varchar(2000) null,
	adjunto varchar(100) null,
	observaciones varchar(1000) null,
	cod_estado varchar(100) null,
	responsable_ingreso varchar(100) null,
	responsable_actual varchar(100) null,
	dias_bandeja integer null,
	dias_sistema integer null,
	cod_medio_respuesta varchar(100) null,
	fec_respuesta timestamp null,
	primary key(id_reclamo)
)
GO


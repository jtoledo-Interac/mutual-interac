create table public.reclamo
( 
	id_reclamo integer not null,
	num_adherente varchar(100) null,
	nombre_solicitante varchar(100) null,
	email_solicitante varchar(100) null,
	fono_solicitante varchar(1000) null,
	region_solicitante varchar(100) null,
	id_tipo numeric null,
	id_motivo numeric null,
	id_prioridad numeric null,
	id_cartera numeric null,
	fec_ingreso timestamp null,
	glosa varchar(2000) null,
	adjunto varchar(100) null,
	observaciones varchar(1000) null,
	id_estado varchar(100) null,
	responsable_ingreso varchar(100) null,
	responsable_actual varchar(100) null,
	dias_bandeja integer null,
	dias_sistema integer null,
	id_medio_respuesta numeric null,
	fec_respuesta timestamp null,
	primary key(id_reclamo)
)



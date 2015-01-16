create table public.documento
( 
	id_documento    integer not null,
	nombre          varchar(100) null,
	num_folio       varchar(100) null,
	num_adherente   varchar(100) null,
	descripcion   	varchar(1000) null,
	cod_cartera   	varchar(100) null,
	cod_producto   	varchar(100) null,
	cod_area    	varchar(100) null,
	fec_creacion  	timestamp null,
	primary key(id_documento)
)
GO
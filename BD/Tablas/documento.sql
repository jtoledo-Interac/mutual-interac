create table public.documento
( 
	id_documento    	integer not null,
	nombre          	varchar(100) null,
	num_folio       	varchar(100) null,
	num_adherente   	varchar(100) null,
	descripcion   		varchar(1000) null,
	id_cartera   		numeric null,
	id_producto   		numeric null,
	cod_area    		varchar(100) null,
	fec_creacion  		timestamp null,
	invalideces			boolean null,
	sami				boolean null,
	fatales				boolean null,
	graves				boolean null,
	graves_amputados	boolean null,
	primary key(id_documento)
)

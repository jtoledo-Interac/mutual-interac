create table public.usuario
( 
	idusuario    	integer not null,
	rut          	varchar(8) null,
	dv           	varchar(1) null,
	nombres      	varchar(100) null,
	apepaterno   	varchar(100) null,
	apematerno   	varchar(100) null,
	nomusuario   	varchar(100) null,
	contrasena    	varchar(100) null,
	codgenero    	varchar(1) null,
	fecnacimiento	date null,
	direccion    	varchar(100) null,
	idcomuna    	integer null,
	idprovincia     integer null,
	idregion    	integer null,
	codpais      	varchar(10) null,
	telefono     	varchar(100) null,
	celular      	varchar(100) null,
	email         	varchar(100) null,
	cantintentos	integer,
	feccreacion  	timestamp null,
	feccontrasena	timestamp null,
	indvigencia  	varchar(1) null,
	primary key(idusuario)
)
GO
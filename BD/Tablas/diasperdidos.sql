CREATE TABLE public.diasperdidos (
    id_dias 		serial not null,
	id_empresa   	integer not null,
    dias_perdidos	integer NOT NULL,
	fecha_ingreso   timestamp,
    primary key(id_dias)
);
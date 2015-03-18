CREATE TABLE public.diasperdidos (
    id_dias 		serial not null,
	id_empresa   	integer not null,
    dias_perdidos	integer NOT NULL,
	periodo		    integer NOT NULL,
    primary key(id_dias)
);
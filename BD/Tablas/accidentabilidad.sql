CREATE TABLE public.accidentabilidad (
    id_accidente 	serial not null,
	id_empresa   	integer NOT NULL,
    accidentes		float NOT NULL,
	fecha_ingreso   timestamp,
    primary key(id_accidente)
);
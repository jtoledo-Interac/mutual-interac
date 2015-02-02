create TABLE archivo_prueba
(
  id serial NOT NULL,
  ruta character varying(100),
  nombre_archivo character varying(100)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE archivo_prueba
  OWNER TO postgres;

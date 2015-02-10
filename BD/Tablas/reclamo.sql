

CREATE TABLE reclamo
(
  id_reclamo integer NOT NULL,
  num_adherente character varying(100),
  nombre_solicitante character varying(100),
  email_solicitante character varying(100),
  fono_solicitante character varying(1000),
  region_solicitante character varying(100),
  id_tipo numeric,
  id_motivo numeric,
  id_prioridad numeric,
  id_cartera numeric,
  fec_ingreso timestamp without time zone,
  glosa character varying(2000),
  adjunto character varying(100),
  observaciones character varying(1000),
  responsable_ingreso character varying(100),
  responsable_actual character varying(100),
  id_medio_respuesta numeric,
  fec_respuesta timestamp without time zone,
  id_estado numeric,
  dias_bandeja character varying(50),
  dias_sistema character varying(50),
  CONSTRAINT reclamo_pkey PRIMARY KEY (id_reclamo)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE reclamo
  OWNER TO postgres;

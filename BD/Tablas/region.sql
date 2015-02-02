create TABLE region
(
  cod_region character varying NOT NULL,
  des_region character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE region
  OWNER TO postgres;
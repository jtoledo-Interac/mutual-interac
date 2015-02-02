create table provincia
(
  pro_nidprovincia numeric(15,5) not null,
  pro_snombre character varying(23),
  pro_nidregion numeric(15,5)
)
with (
  oids=false
);
alter table provincia
  owner to postgres;

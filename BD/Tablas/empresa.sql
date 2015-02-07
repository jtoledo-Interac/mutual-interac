CREATE TABLE public.empresa (
    id_empresa serial not null,
    num_adherente integer not null,
    nombre	varchar(200) null,
    primary key(id_empresa)
)
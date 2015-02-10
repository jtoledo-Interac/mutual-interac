CREATE TABLE public.empresa (
    id_empresa serial not null,
    num_adherente varchar(200) not null,
    nombre	varchar(200) null,
    primary key(id_empresa)
)
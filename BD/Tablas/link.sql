CREATE TABLE public.link 
(
    id_link 	serial NOT NULL,
    url_link	varchar(200) NULL,
    des_link	varchar(200) NULL,
     id_tipo_link numeric,
    primary key(id_link)
)

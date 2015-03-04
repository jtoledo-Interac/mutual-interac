create or replace function public.modificar_tipo_link
(
    in xid_tipo_link numeric,
    in xdes_tipo_link varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
           tipo_link
        set 
            des_tipo_link = xdes_tipo_link
        where
            id_tipo_link = xid_tipo_link;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_medio] error al modificar medio(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
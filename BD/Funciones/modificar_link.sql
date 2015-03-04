create or replace function public.modificar_link
(
    in xid_link numeric,
    in xlink varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            links_respuesta
        set 
            des_link = xlink
        where
            id_link = xid_link;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_link] error al modificar link(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
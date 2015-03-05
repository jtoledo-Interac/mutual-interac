create or replace function public.modificar_link
(
    in xid_link numeric,
    in xid_tipo_link numeric,
    in xurl_link varchar,
    in xdes_link varchar,    
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            link
        set 
            des_link = xdes_link,
            url_link = xurl_link,
            id_tipo_link = xid_tipo_link
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
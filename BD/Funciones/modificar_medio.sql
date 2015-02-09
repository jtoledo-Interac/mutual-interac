create or replace function public.modificar_medio
(
    in xid_medio numeric,
    in xmedio varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            medios_respuesta
        set 
            des_medio_respuesta = xmedio
        where
            id_medio_respuesta = xidd_medio;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_medio] error al modificar medio(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
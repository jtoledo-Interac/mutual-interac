create or replace function public.modificar_estado
(
    in xid_estado numeric,
    in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            estado
        set 
            des_estado = xnombre
        where
            id_estado = xid_estado;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_estado] error al modificar estado(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
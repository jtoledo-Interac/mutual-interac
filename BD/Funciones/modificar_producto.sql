create or replace function public.modificar_producto
(
    in xid_producto numeric,
    in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            producto
        set 
            des_producto = xnombre
        where
            id_producto = xid_producto;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_producto] error al modificar producto(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
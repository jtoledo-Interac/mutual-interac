create or replace function public.modificar_producto
(
    in xcod_producto varchar,
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
            cod_producto = xcod_producto;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_producto] error al modificar producto(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
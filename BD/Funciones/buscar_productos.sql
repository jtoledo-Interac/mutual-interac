create or replace function public.buscar_productos
(
    out productos refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := '0';
		msjerror := ' ';

        open productos for

        select
            cod_producto,
            des_producto
        from 
            producto
        order by
            des_producto;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_productos] error al buscar productos(sql) ' ||sqlerrm;
                return;	
    end;

$body$
language 'plpgsql'
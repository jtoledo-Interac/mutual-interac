create or replace function public.buscar_productos
(
    in xnomproducto$ varchar, 
    out productos refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xnomproducto varchar;
    begin
        xnomproducto := coalesce(upper(trim(xnomproducto$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open productos for

        select
            id_producto,
            des_producto
        from 
            producto
        where
             upper(des_producto) like '%' || xnomproducto ||'%' 
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
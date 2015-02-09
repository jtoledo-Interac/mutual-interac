create or replace function public.buscar_parametros
(
    out carteras refcursor,
    out productos refcursor, 
    out areas refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
begin
    begin
        numerror := '0';
        msjerror := ' ';

        open carteras for

        select
            id_cartera,
            des_cartera
        from 
            cartera
        order by
            des_cartera;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[buscar_parametros] error al buscar carteras(sql) ' ||sqlerrm;
                return; 
    end;

    begin
        numerror := '0';
        msjerror := ' ';

        open productos for

        select
            id_producto,
            des_producto
        from 
            producto
        order by
            des_producto;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[buscar_parametros] error al buscar productos(sql) ' ||sqlerrm;
                return; 
    end;

    begin
        numerror := '0';
        msjerror := ' ';

        open areas for

        select
            cod_area,
            des_area
        from 
            area
        order by
            des_area;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[buscar_parametros] error al buscar areas(sql) ' ||sqlerrm;
                return; 
    end;
end;
$body$
language 'plpgsql'
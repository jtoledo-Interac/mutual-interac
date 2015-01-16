create or replace function public.buscar_carteras
(
    out carteras refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := '0';
        msjerror := ' ';

        open carteras for

        select
            cod_cartera,
            des_cartera
        from 
            cartera
        order by
            des_cartera;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_carteras] error al buscar carteras(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
create or replace function public.buscar_tipos
(
    out tipos refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := '0';
        msjerror := ' ';

        open tipos for

        select
            cod_tipo,
            des_tipo
        from 
            tipo
        order by
            des_tipo;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_tipos] error al buscar tipos(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
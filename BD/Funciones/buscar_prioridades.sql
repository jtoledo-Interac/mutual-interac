create or replace function public.buscar_prioridades
(
    out prioridades refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := '0';
        msjerror := ' ';

        open prioridades for

        select
            cod_prioridad,
            des_prioridad
        from 
            prioridad
        order by
            des_prioridad;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_prioridades] error al buscar prioridades(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
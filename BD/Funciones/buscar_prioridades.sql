create or replace function public.buscar_prioridades
(
    in xnomprioridad$ varchar, 
    out prioridades refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xnomprioridad varchar;
    begin
        xnomprioridad := coalesce(upper(trim(xnomprioridad$)),'') || '%';
        numerror := '0';
        msjerror := ' ';

        open prioridades for

        select
            cod_prioridad,
            des_prioridad
        from 
            prioridad
        where
             upper(des_prioridad) like '%' || xnomprioridad ||'%' 
        order by
            des_prioridad;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_prioridads] error al buscar prioridads(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
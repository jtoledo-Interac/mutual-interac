create or replace function public.buscar_tipos
(
    in xnomtipo$ varchar, 
    out tipos refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xnomtipo varchar;
    begin
        xnomtipo := coalesce(upper(trim(xnomtipo$)),'') || '%';
        numerror := '0';
        msjerror := ' ';

        open tipos for

        select
            cod_tipo,
            des_tipo
        from 
            tipo
        where
             upper(des_tipo) like '%' || xnomtipo ||'%' 
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
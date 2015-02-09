create or replace function public.buscar_medios
(
    in xnommedio$ varchar, 
    out medios refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xnommedio varchar;
    begin
        xnommedio := coalesce(upper(trim(xnommedio$)),'') || '%';
        numerror := '0';
        msjerror := ' ';

        open medios for

        select
            id_medio,
            des_medio
        from 
            medio_respuesta
        where
             upper(des_medio) like '%' || xnommedio ||'%'                  
        order by
            des_medio;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_medios] error al buscar medios(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
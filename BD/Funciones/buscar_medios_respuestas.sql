create or replace function public.buscar_medios_respuestas
(
    in xnommedios_respuesta$ varchar, 
    out medios_respuestas refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xnommedios_respuesta varchar;
    begin
        xnommedios_respuesta := coalesce(upper(trim(xnommedios_respuesta$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open medios_respuestas for

        select
            cod_medios_respuesta,
            des_medios_respuesta
        from 
            medios_respuesta
        where
             upper(des_medios_respuesta) like '%' || xnommedios_respuesta ||'%' 
        order by
            des_medios_respuesta;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_medios_respuestas] error al buscar medios_respuestas(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
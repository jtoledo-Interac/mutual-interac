create or replace function public.buscar_par_reclamos
(
    out tipos refcursor,
    out motivos refcursor, 
    out prioridades refcursor,
    out carteras refcursor,
    out estados refcursor,
    out medios refcursor,
    out medios_respuestas refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
begin
    
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

    begin
        numerror := '0';
        msjerror := ' ';

        open motivos for

        select
            cod_motivo,
            des_motivo
        from 
            motivo
        order by
            des_motivo;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_motivos] error al buscar motivos(sql) ' ||sqlerrm;
                return; 
    end;

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

    begin
        numerror := '0';
        msjerror := ' ';

        open estados for

        select
            cod_estado,
            des_estado
        from 
            estado
        order by
            des_estado;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_estados] error al buscar estados(sql) ' ||sqlerrm;
                return; 
    end;


    begin
        numerror := '0';
        msjerror := ' ';

        open medios_respuestas for

        select
            cod_medios_respuesta,
            des_medios_respuesta
        from 
            medios_respuesta
        order by
            des_medios_respuesta;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_medios_respuestas] error al buscar medios_respuestas(sql) ' ||sqlerrm;
                return; 
    end;
end;
$body$
language 'plpgsql'
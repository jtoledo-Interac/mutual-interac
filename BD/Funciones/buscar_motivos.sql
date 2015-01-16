create or replace function public.buscar_motivos
(
    out motivos refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

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

$body$
language 'plpgsql'
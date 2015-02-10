create or replace function public.buscar_motivos
(
    in xnommotivo$ varchar, 
    out motivos refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xnommotivo varchar;
    begin
        xnommotivo := coalesce(upper(trim(xnommotivo$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open motivos for

        select
            id_motivo,
            des_motivo
        from 
            motivo
        where
             upper(des_motivo) like '%' || xnommotivo ||'%' 
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
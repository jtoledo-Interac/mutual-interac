create or replace function public.buscar_estados
(
    in xnomestado$ varchar, 
    out estados refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xnomestado varchar;
    begin
        xnomestado := coalesce(upper(trim(xnomestado$)),'') || '%';
        numerror := '0';
        msjerror := ' ';

        open estados for

        select
            id_estado,
            des_estado
        from 
            estado
        where
             upper(des_estado) like '%' || xnomestado ||'%' 
        order by
            des_estado;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_estados] error al buscar estados(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
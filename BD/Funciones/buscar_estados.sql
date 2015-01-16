create or replace function public.buscar_estados
(
    out estados refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

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

$body$
language 'plpgsql'
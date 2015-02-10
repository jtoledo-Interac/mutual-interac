create or replace function public.buscar_carteras
(
    in xnomcartera$ varchar,
    out carteras refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
     declare xnomcartera varchar;

    begin
        numerror := 0;
        msjerror := ' ';

        xnomcartera := coalesce(upper(trim(xnomcartera$)),'') || '%';

        open carteras for

        select
            id_cartera,
            des_cartera
        from 
            cartera
        where 
            upper(des_cartera) like '%' || xnomcartera ||'%'
         order by
            id_cartera;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_carteras] error al buscar carteras(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
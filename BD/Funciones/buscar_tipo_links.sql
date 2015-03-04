create or replace function public.buscar_tipo_links
(
    in xnomlink$ varchar, 
    out links refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xnomlink varchar;
    begin
        xnomlink := coalesce(upper(trim(xnomlink$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open links for

        select
            id_tipo_link,
            des_tipo_link
        from 
            tipo_link
        where
             upper(des_tipo_link) like '%' || xnomlink ||'%'                  
        order by
            des_tipo_link;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[buscar_tipo_links] error al buscar tipó_links(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
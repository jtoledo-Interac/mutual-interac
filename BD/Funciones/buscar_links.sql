create or replace function public.buscar_links
(
    in xid_tipo_link$ numeric,
    in xdes_link$ varchar,
    out links refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xid_tipo_link numeric;
        declare xdes_link varchar;
    begin
        
        numerror := 0;
        msjerror := ' ';
        xdes_link := coalesce(upper(trim(xdes_link$)),'');
        xid_tipo_link=xid_tipo_link$;
        open links for

        select
            id_link,     
            url_link,
            des_link,
            r.id_tipo_link as id_tipo_link,
            m.des_tipo_link as des_tipo_link
            
        from 
            link r
            inner join tipo_link as m
                on r.id_tipo_link = m.id_tipo_link

        where
                upper(des_link) like '%' || xdes_link ||'%' and
              (xid_tipo_link =      0 or r.id_tipo_link = xid_tipo_link)          
        order by
            des_tipo_link;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_links] error al buscar links(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
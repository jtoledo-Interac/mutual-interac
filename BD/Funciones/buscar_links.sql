create or replace function public.buscar_links
(
    in xid_tipo_link$ numeric, 
    out links refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$
        declare xid_tipo_link numeric;
    begin
        
        numerror := 0;
        msjerror := ' ';
        xid_tipo_link=xid_tipo_link$;
        open links for

        select
            id_link,     
            url_link,
            r.id_tipo_link as id_tipo_link,
            m.des_tipo_link as des_tipo_link,
            des_link
        from 
            link r
            inner join tipo_link as t
                on r.id_tipo_link = t.id_tipo_link
        where
              (xid_tipo_link =      0 or r.id_tipo = xid_tipo_link)          
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
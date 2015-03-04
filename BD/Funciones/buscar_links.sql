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
        xnomlink := coalesce(upper(trim(xnomlink$)),'') || '%';
        numerror := 0;
        msjerror := ' ';
        xid_tipo_link=xid_tipo_link$;
        open links for

        select
            id_link,     
            url_link,
            r.id_tipo_link as id_tipo_link
            m.des_tipo_link as des_tipo_link
            des_link
        from 
            link r
            inner join tipo_link as t
                on r.id_tipo_link = t.id_tipo_link
        where
             upper(des_link_respuesta) like '%' || xnomlink ||'%'                  
        order by
            des_link_respuesta;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_links] error al buscar links(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'
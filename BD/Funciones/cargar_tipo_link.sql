create or replace function public.cargar_tipo_link
(
    in xid_tipo_link numeric, 
    out tipo_links  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';
    begin
        open tipo_links for

            select
                id_tipo_link,
                des_tipo_link                
            from 
                tipo_link
                where
                    id_tipo_link = xid_tipo_link; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_tipo_link  error al cargar tipo_link sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
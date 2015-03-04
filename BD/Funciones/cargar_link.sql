create or replace function public.cargar_link
(
    in xid_link numeric, 
    out links  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';
    begin
        open links for

            select
                id_link,
                url_link,
                des_link               
            from 
                link       
                where
                    id_link = xid_link; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_link  error al cargar link sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
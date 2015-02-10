create or replace function public.cargar_tipo
(
    in xid_tipo numeric, 
    out tipo  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';
    begin
        open tipo  for

            select
                id_tipo,
                des_tipo                
            from 
                tipo             
                where
                id_tipo = xid_tipo; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_tipo  error al cargar tipo sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
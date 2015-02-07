create or replace function public.cargar_producto
(
    in xid_producto numeric, 
    out producto  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open producto  for

            select
                id_producto,
                des_producto                
            from 
                producto             
                where
                id_producto = xid_producto; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_producto  error al cargar producto sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
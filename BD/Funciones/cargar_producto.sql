create or replace function public.cargar_producto
(
    in xcod_producto varchar, 
    out producto  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open producto  for

            select
                cod_producto,
                des_producto                
            from 
                producto             
                where
                cod_producto = xcod_producto; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_producto  error al cargar producto sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
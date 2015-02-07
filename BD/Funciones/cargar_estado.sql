create or replace function public.cargar_estado
(
    in xid_estado numeric, 
    out estado  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open estado  for

            select
                id_estado,
                des_estado                
            from 
                estado             
                where
                id_estado = xid_estado; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_estado  error al cargar estado sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
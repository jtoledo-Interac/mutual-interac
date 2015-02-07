create or replace function public.cargar_prioridad
(
    in xid_prioridad numeric, 
    out prioridad  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open prioridad  for

            select
                id_prioridad,
                des_prioridad                
            from 
                prioridad             
                where
                id_prioridad = xid_prioridad; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_prioridad  error al cargar prioridad sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
create or replace function public.cargar_prioridad
(
    in xcod_prioridad varchar, 
    out prioridad  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open prioridad  for

            select
                cod_prioridad,
                des_prioridad                
            from 
                prioridad             
                where
                cod_prioridad = xcod_prioridad; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_prioridad  error al cargar prioridad sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
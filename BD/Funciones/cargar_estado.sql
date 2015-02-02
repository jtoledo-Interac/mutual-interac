create or replace function public.cargar_estado
(
    in xcod_estado varchar, 
    out estado  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open estado  for

            select
                cod_estado,
                des_estado                
            from 
                estado             
                where
                cod_estado = xcod_estado; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_estado  error al cargar estado sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
create or replace function public.cargar_tipo
(
    in xcod_tipo varchar, 
    out tipo  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open tipo  for

            select
                cod_tipo,
                des_tipo                
            from 
                tipo             
                where
                cod_tipo = xcod_tipo; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_tipo  error al cargar tipo sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
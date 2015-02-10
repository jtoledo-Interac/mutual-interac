create or replace function public.cargar_medio_respuesta
(
    in xcod_medio_respuesta varchar, 
    out medio_respuesta  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';
    begin
        open medio_respuesta  for

            select
                cod_medio_respuesta,
                des_medio_respuesta                
            from 
                medio_respuesta             
                where
                cod_medio_respuesta = xcod_medio_respuesta; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_medio_respuesta  error al cargar medio_respuesta sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
create or replace function public.cargar_medio
(
    in xcod_medio varchar, 
    out medios  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open medios for

            select
                cod_medio_respuesta,
                des_medio_respuesta                
            from 
                medios_respuesta             
                where
                cod_medio_respuesta = xcod_medio; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_medio  error al cargar medio sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
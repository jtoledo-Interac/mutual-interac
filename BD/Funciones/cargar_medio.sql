create or replace function public.cargar_medio
(
    in xid_medio numeric, 
    out medios  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';
    begin
        open medios for

            select
                id_medio_respuesta,
                des_medio_respuesta                
            from 
                medios_respuesta             
                where
                    id_medio_respuesta = xid_medio; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_medio  error al cargar medio sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
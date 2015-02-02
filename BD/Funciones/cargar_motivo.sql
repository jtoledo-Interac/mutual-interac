create or replace function public.cargar_motivo
(
    in xcod_motivo varchar, 
    out motivo  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open motivo  for

            select
                cod_motivo,
                des_motivo                
            from 
                motivo             
                where
                cod_motivo = xcod_motivo; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_motivo  error al cargar motivo sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
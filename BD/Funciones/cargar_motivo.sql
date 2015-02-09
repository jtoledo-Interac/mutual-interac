create or replace function public.cargar_motivo
(
    in xid_motivo numeric, 
    out motivo  refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open motivo  for

            select
                id_motivo,
                des_motivo                
            from 
                motivo             
                where
                id_motivo = xid_motivo; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_motivo  error al cargar motivo sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
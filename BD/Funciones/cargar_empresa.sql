create or replace function public.cargar_empresa
(
    in id_empresa numeric, 
    out empresas refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open empresas for

            select
                num_adherente,
                id_empresa,
                nombre
            from 
                empresa
            where
                num_adherente = xnum_adherente;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_empresa] error al cargar empresa(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
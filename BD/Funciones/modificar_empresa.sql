DROP FUNCTION modificar_empresa(numeric, character varying);
create or replace function public.modificar_empresa
(
    in xid_empressa numeric,
    in xnum_adherente varchar,
    in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            empresa
        set 
            nombre = xnombre,
            num_adherente = xnum_adherente

        where
            id_empresa = xid_empressa;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_empresa] error al modificar empresa(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
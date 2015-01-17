create or replace function public.modificar_empresa
(
    in xnum_adherente numeric,
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
            nombre = xnombre
        where
            num_adherente = xnum_adherente;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_empresa] error al modificar empresa(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
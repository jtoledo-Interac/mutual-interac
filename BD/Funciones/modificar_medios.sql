create or replace function public.modificar_medio
(
    in xcod_medio varchar,
    in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            medio
        set 
            des_medio = xnombre
        where
            cod_medio = xcod_medio;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_medio] error al modificar medio(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
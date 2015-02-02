create or replace function public.modificar_tipo
(
    in xcod_tipo varchar,
    in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            tipo
        set 
            des_tipo = xnombre
        where
            cod_tipo = xcod_tipo;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_tipo] error al modificar tipo(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
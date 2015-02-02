create or replace function public.modificar_medio_respuesta
(
    in xcod_medio_respuesta varchar,
    in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            medio_respuesta
        set 
            des_medio_respuesta = xnombre
        where
            cod_medio_respuesta = xcod_medio_respuesta;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_medio_respuesta] error al modificar medio_respuesta(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
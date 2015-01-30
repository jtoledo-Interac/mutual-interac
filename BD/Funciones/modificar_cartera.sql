create or replace function public.modificar_cartera
(
    in xcod_cartera varchar,
    in xdes_cartera varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            cartera
        set 
            des_cartera = xdes_cartera
        where
            cod_cartera = xcod_cartera;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_cartera] error al modificar cartera(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
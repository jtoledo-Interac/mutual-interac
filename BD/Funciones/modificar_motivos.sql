create or replace function public.modificar_motivo
(
    in xcod_motivo varchar,
    in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            motivo
        set 
            des_motivo = xnombre
        where
            cod_motivo = xcod_motivo;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_motivo] error al modificar motivo(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
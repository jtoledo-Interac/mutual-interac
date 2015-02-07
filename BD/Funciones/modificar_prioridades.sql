create or replace function public.modificar_prioridad
(
    in xid_prioridad numeric,
    in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            prioridad
        set 
            des_prioridad = xnombre
        where
            id_prioridad = xid_prioridad;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_prioridad] error al modificar prioridad(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
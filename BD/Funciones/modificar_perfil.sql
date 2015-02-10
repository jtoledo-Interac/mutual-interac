create or replace function public.modificar_perfil
(
    in xid_perfil numeric,
    in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            perfil
        set 
            des_perfil = xnombre
        where
            id_perfil = xid_perfil;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_perfil] error al modificar perfil(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
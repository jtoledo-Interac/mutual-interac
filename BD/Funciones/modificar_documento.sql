create or replace function public.modificar_documento
(
    in xid_documento numeric,
    in xnombre varchar,
    in xnum_folio varchar,
    in xnum_adherente varchar,
    in xdescripcion varchar,
    in xid_cartera varchar,
    in xid_producto varchar,
    in xcod_area varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin
        numerror := 0;
        msjerror := '';

        update 
            documento
        set 
            nombre = xnombre,
            num_folio = xnum_folio,
            num_adherente = xnum_adherente,
            descripcion = xdescripcion,
            id_cartera = xid_cartera,
            id_producto =  xid_producto,
            cod_area = xcod_area
        where
            id_documento = xid_documento;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_documento] error al modificar documento(sql) ' ||sqlerrm;
                return; 
    end;
$body$
language 'plpgsql'
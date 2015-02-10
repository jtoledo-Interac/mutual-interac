create or replace function public.cargar_documento
(
    in xniddocumento numeric, 
    out documentos refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';    
    begin
        open documentos for

            select
                id_documento,
                nombre,
                num_folio,
                num_adherente,
                descripcion,
                id_cartera,
                id_producto,
                cod_area,
                fec_creacion
            from 
                documento
            where
                id_documento = xniddocumento;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_documento] error al cargar documento(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
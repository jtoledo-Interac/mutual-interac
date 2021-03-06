create or replace function public.agregar_documento
(
	in xnombre varchar,
	in xnum_folio varchar,
	in xnum_adherente varchar,
	in xdescripcion varchar,
	in xid_cartera numeric,
	in xid_producto numeric,
	in xcod_area varchar,
    out xid_documento bigint, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xid_documento$ bigint;

	begin
	
		xid_documento$ := nextval('seq_documento');
		numerror := 0;
		msjerror := '';

		insert into documento
		(
			id_documento,
			nombre,
			num_folio,
			num_adherente,
			descripcion,
			id_cartera,
			id_producto,
			cod_area,
			fec_creacion
		)
        values
		(
			xid_documento$,
			xnombre,
			xnum_folio,
			xnum_adherente,
			xdescripcion,
			xid_cartera,
			xid_producto,
			xcod_area,
			now()
		);

        xid_documento := xid_documento$;
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_documento] error al crear documento(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
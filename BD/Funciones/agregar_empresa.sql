create or replace function public.agregar_empresa
(
	in xnum_adherente varchar,
	in xnombre varchar,
    --out xid_documento bigint, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    --declare xid_documento$ bigint;

	begin	
		--xid_documento$ := nextval('seq_documento');
		numerror := 0;
		msjerror := '';

		insert into empresa
		(
			num_adherente,
			nombre
		)
        values
		(
			xnum_adherente$,
			xnombre
		);

        --xid_documento := xid_documento$;
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_empresa] error al crear empresa(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
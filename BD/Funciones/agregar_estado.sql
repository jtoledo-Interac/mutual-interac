create or replace function public.agregar_estado
(
	in xid_estado numeric,
	in xdes_estado varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into estado
		(
			id_estado,
			des_estado
		)
        values
		(
			xid_estado,
			xdes_estado
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_estado] error al crear estado(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
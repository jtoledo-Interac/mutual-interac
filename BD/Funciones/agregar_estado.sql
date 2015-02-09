create or replace function public.agregar_estado
(
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
			des_estado
		)
        values
		(
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
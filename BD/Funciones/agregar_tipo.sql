create or replace function public.agregar_tipo
(
	
	in xdes_tipo varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into tipo
		(
			
			des_tipo
		)
        values
		(
			
			xdes_tipo
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_tipo] error al crear tipo(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
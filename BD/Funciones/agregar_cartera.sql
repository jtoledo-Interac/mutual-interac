create or replace function public.agregar_cartera
(
	in xdes_cartera varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into cartera
		(			
			des_cartera
		)
        values
		(			
			xdes_cartera
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_cartera] error al crear cartera(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
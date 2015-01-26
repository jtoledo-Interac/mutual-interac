create or replace function public.agregar_cartera
(
	in xcod_cartera varchar,
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
			cod_cartera,
			des_cartera
		)
        values
		(
			xcod_cartera,
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
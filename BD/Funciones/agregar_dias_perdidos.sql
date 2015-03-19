create or replace function public.agregar_dias_perdidos
(
	IN xid_empresa integer,
	IN xdias_perdidos integer,
	IN xfecha_ingreso integer,
	OUT numerror varchar,
	OUT msjerror varchar
) returns record as

$body$

    

	begin	
		
		numerror := 0;
		msjerror := '';

		insert into diasperdidos
		(
		id_empresa,   	
		dias_perdidos,
		fecha_ingreso
		)
        values
		(
	    xid_empresa,
		xdias_perdidos,
		xfecha_ingreso
		);

       
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_dias_perdidos] error al crear diasperdidos(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
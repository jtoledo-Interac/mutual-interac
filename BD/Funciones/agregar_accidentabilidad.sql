create or replace function public.agregar_accidentabilidad
(
	IN xid_empresa integer,
	IN xaccidentes float,
	IN xfecha_ingreso timestamp,
	OUT numerror varchar,
	OUT msjerror varchar
) returns record as

$body$   

	begin	
		
		numerror := 0;
		msjerror := '';

		insert into accidentabilidad
		(
		id_empresa,   	
		accidentes,
		fecha_ingreso
		)
        values
		(
	    xid_empresa,
		xaccidentes,
		xfecha_ingreso
		);
       
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_accidentabilidad] error al crear accidentabilidad(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
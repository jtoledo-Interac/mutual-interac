create or replace function public.agregar_accidentabilidad
(
	IN xid_empresa integer,
	IN xaccidentes float,
	IN xperiodo integer,
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
		periodo
		)
        values
		(
	    xid_empresa ,
		xaccidentes,
		xperiodo
		);

       
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_accidentabilida] error al crear accidentabilidad(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
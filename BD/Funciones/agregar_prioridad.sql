create or replace function public.agregar_prioridad
(
	in xid_prioridad numeric,
	in xdes_prioridad varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into prioridad
		(
			id_prioridad,
			des_prioridad
		)
        values
		(
			xid_prioridad,
			xdes_prioridad
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_prioridad] error al crear prioridad(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
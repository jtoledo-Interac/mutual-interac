create or replace function public.agregar_prioridad
(
	in xcod_prioridad varchar,
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
			cod_prioridad,
			des_prioridad
		)
        values
		(
			xcod_prioridad,
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
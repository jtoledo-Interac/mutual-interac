create or replace function public.agregar_medio
(
	in xdes_medio varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into medios_respuesta
		(
			des_medio_respuesta
		)
        values
		(
			xdes_medio
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_medio] error al crear medio(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
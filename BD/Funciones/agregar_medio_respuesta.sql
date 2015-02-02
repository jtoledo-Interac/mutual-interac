create or replace function public.agregar_medio_respuesta
(
	in xcod_medio_respuesta varchar,
	in xdes_medio_respuesta varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into medios_respuesta
		(
			cod_medio_respuesta,
			des_medio_respuesta
		)
        values
		(
			xcod_medio_respuesta,
			xdes_medio_respuesta
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_medio_respuesta	] error al crear medio(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
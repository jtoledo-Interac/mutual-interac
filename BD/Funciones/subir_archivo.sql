create or replace function subir_archivo(in patharchivo character varying, in nombrearchivo character varying, out numerror character varying, out msjerror character varying)
  returns record as
$body$

	begin

		numerror := 0;
		msjerror := '';

		insert into archivo_prueba
		(
			ruta,
			nombre_archivo
		)
        values
		(
			patharchivo,
			nombrearchivo
		);
		
     	return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_empresa] error al crear empresa(sql) ' ||sqlerrm;
				return;	
	end;
$body$
  language plpgsql volatile
  cost 100;
alter function subir_archivo(character varying, character varying)
  owner to postgres;

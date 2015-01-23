-- Function: subir_archivo(character varying, character varying)

-- DROP FUNCTION subir_archivo(character varying, character varying);

CREATE OR REPLACE FUNCTION subir_archivo(IN patharchivo character varying, IN nombrearchivo character varying, OUT numerror character varying, OUT msjerror character varying)
  RETURNS record AS
$BODY$

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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION subir_archivo(character varying, character varying)
  OWNER TO postgres;

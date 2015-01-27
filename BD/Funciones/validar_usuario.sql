-- Function: validar_usuario(character varying)

-- DROP FUNCTION validar_usuario(character varying);

CREATE OR REPLACE FUNCTION validar_usuario(IN username_in character varying, OUT id_out integer, OUT email_out character varying, OUT numerror character varying, OUT msjerror character varying)
  RETURNS record AS
$BODY$
	declare xusu_snomusuario varchar(100);
	declare xusu_idusuario integer;
	declare xusu_semail 	 varchar(100);

begin
	numerror :='0';
	msjerror :=' ';

	select 
		email,
		idusuario
	into
		xusu_semail,
		xusu_idusuario
	from 
		usuario
	where
		nomusuario = username_in;
	IF FOUND THEN
		email_out := xusu_semail;
		id_out := xusu_idusuario;
	ELSE
	numerror := '1';
	msjerror := 'Usuario no encontrado';
	END IF;
	end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION validar_usuario(character varying)
  OWNER TO postgres;

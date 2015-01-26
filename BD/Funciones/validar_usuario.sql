-- Function: validar_usuario(character varying)

-- DROP FUNCTION validar_usuario(character varying);

CREATE OR REPLACE FUNCTION validar_usuario(IN username_in character varying, OUT email_out character varying, OUT numerror character varying, OUT msjerror character varying)
  RETURNS record AS
$BODY$
	declare xusu_snomusuario varchar(100);
	declare xusu_semail 	 varchar(100);

begin

       	numerror :='0';
	msjerror :=' ';

	select 
	usu_semail
	into
	xusu_semail
	from 
		usuario
	where
		usu_snomusuario=username_in;
	IF FOUND THEN
		email_out := xusu_semail;
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
-- Function: validar_usuario(character varying)

-- DROP FUNCTION validar_usuario(character varying);

CREATE OR REPLACE FUNCTION validar_usuario(IN username_in character varying, OUT email_out character varying, OUT numerror character varying, OUT msjerror character varying)
  RETURNS record AS
$BODY$
	declare xusu_snomusuario varchar(100);
	declare xusu_semail 	 varchar(100);

begin

   	numerror :='0';
	msjerror :=' ';

	select 
		email
		into
		xusu_semail
	from 
		usuario
	where
		nomusuario = username_in;
	IF FOUND THEN
		email_out := xusu_semail;
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

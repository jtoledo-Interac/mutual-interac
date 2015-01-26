CREATE OR REPLACE FUNCTION validar_email(
	IN email_in character varying,
	OUT id_out integer,
	OUT flag boolean, 
	OUT numerror character varying, 
	OUT msjerror character varying
) RETURNS record AS

$BODY$     
	declare xusu_semail varchar(100);
	declare xusu_idusuario integer;
	
	begin
		numerror := '0';
		msjerror := ' ';
 
		select
			email, idusuario   
		into
			xusu_semail, xusu_idusuario
		from
			usuario
		where
			(email) = email_in;
		IF FOUND THEN
			id_out := xusu_idusuario;
			flag=TRUE;
		ELSE
			flag=FALSE;
			numerror := '1';
			msjerror := 'Email no encontrado.';
		end if;
	end;     
$BODY$
LANGUAGE plpgsql

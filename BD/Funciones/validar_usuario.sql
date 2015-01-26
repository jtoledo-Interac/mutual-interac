create or replace function validar_usuario(in username_in character varying, out email_out character varying, out numerror character varying, out msjerror character varying)
  returns record as
$body$
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
	if found then
		email_out := xusu_semail;
	else
	numerror := '1';
	msjerror := 'usuario no encontrado';
	end if;
	end;

$body$
  language plpgsql volatile
  cost 100;
alter function validar_usuario(character varying)
  owner to postgres;
-- function: validar_usuario(character varying)

-- drop function validar_usuario(character varying);

create or replace function validar_usuario(in username_in character varying, out email_out character varying, out numerror character varying, out msjerror character varying)
  returns record as
$body$
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
	if found then
		email_out := xusu_semail;
	else
	numerror := '1';
	msjerror := 'usuario no encontrado';
	end if;
	end;

$body$
  language plpgsql volatile
  cost 100;
alter function validar_usuario(character varying)
  owner to postgres;

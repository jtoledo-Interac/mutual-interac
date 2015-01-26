create or replace function 
(
  in email_in character varying, 
  out flag boolean, 
  out numerror character varying, 
  out msjerror character varying
  )returns record as
$body$
     
  declare xusu_semail varchar(100);     
     
  begin
    numerror := '0';
    msjerror := ' ';

    select
    email            
    into
    xusu_semail 
            
    from
      usuario
    where
      (email) = email_in;
      
    if found then     
      flag=true;
    else
      flag=false;
      numerror := '1';
      msjerror := 'email no encontrado.';
      end if;
  
  end;     
$body$
  language plpgsql volatile
  cost 100;
alter function validar_email(character varying)
  owner to postgres;

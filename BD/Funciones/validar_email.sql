-- Function: validar_email(character varying)


CREATE OR REPLACE FUNCTION validar_email(IN email_in character varying, OUT flag boolean, OUT numerror character varying, OUT msjerror character varying)
  RETURNS record AS
$BODY$
     
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
	    IF FOUND THEN
	    
		   flag=TRUE;
	    ELSE
		flag=FALSE;
		numerror := '1';
		msjerror := 'Email no encontrado.';
	    end if;
	
        end;
     
    $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION validar_email(character varying)
  OWNER TO postgres;

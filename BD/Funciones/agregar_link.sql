create or replace function public.agregar_link
(
	in xdes_link varchar,
	in xurl_link  varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into link_respuesta
		(
			des_link_respuesta,
			url_link
		)
        values
		(
			xdes_link,
			xurl_link
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_link] error al crear link(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
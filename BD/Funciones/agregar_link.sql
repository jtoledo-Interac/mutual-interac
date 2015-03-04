create or replace function public.agregar_link
(
	in xdes_link varchar,
	in xurl_link  varchar,
	in xid_tipo_link numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into link
		(
			des_link,
			url_link,
			id_tipo_link
		)
        values
		(
			xdes_link,
			xurl_link,
			xid_tipo_link
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
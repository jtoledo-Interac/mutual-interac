create or replace function public.agregar_tipo_link
(
	in xdes_tipo_link varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into tipo_link
		(
			des_tipo_link
		)
        values
		(
			xdes_tipo_link
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_tipo_link] error al crear tipo link(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
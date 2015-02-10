create or replace function public.agregar_perfil
(
	in xdes_perfil varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into perfil
		(
			des_perfil
		)
        values
		(
			xdes_perfil
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_perfil] error al crear perfil(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
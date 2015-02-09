create or replace function public.agregar_empresa
(
	in xnum_adherente varchar,
	in xnombre varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    

	begin	
		
		numerror := 0;
		msjerror := '';

		insert into empresa
		(
			num_adherente,
			nombre
		)
        values
		(
			xnum_adherente$,
			xnombre
		);

       
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_empresa] error al crear empresa(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
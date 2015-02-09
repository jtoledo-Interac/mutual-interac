create or replace function public.agregar_motivo
(	
	in xdes_motivo varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into motivo
		(			
			des_motivo
		)
        values
		(			
			xdes_motivo
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_motivo] error al crear motivo(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
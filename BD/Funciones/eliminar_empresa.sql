create or replace function public.eliminar_empresa
(
    in xnum_adherente numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            empresa
        where
            num_adherente = xnum_adherente;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_documento] error al eliminar empresa(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
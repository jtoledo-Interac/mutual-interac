create or replace function public.eliminar_documento
(
    in xiddocumento numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            documento
        where
            id_documento= xiddocumento;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_documento] error al eliminar documento(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
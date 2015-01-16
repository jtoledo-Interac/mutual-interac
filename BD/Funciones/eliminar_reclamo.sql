create or replace function public.eliminar_reclamo
(
    in xidreclamo numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            reclamo
        where
            id_reclamo = xidreclamo;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_reclamo] error al eliminar el reclamo(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
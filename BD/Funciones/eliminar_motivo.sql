create or replace function public.eliminar_motivo
(
    in xcod_motivo varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            motivo
        where
            cod_motivo = xcod_motivo;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_motivo] error al eliminar motivo(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
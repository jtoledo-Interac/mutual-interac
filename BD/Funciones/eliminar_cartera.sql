create or replace function public.eliminar_cartera
(
    in xcod_cartera numeric,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            cartera
        where
            cod_cartera = xcod_cartera;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_cartera] error al eliminar cartera(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
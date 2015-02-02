create or replace function public.eliminar_producto
(
    in xcod_producto varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            producto
        where
            cod_producto = xcod_producto;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_producto] error al eliminar producto(sql) ' ||sqlerrm;
				return;	
	end;

$body$
language 'plpgsql'
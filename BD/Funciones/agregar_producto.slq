create or replace function public.agregar_producto
(
	in xcod_producto varchar,
	in xdes_producto varchar,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$  

	begin
	
		numerror := 0;
		msjerror := '';

		insert into producto
		(
			cod_producto,
			des_producto
		)
        values
		(
			xcod_producto,
			xdes_producto
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_producto] error al crear producto(sql) ' ||sqlerrm;
				return;	
	end;
$body$
language 'plpgsql'
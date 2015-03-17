create or replace function public.cargar_dias_perdidos
(
    in xid_empresa numeric,
	in xfecha_inicio timestamp,
	in xfecha_fin timestamp,
    out empresas refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';
    begin

        numerror := 0;
        msjerror := '';
        open diasperdidos for

            select
            	id_empresa,
				fecha_ingreso,
				dias_perdidos,
			
            from 
                diasperdidos
            where
                id_empresa = xid_empresa and xfecha_inicio>=fecha_ingreso and xfecha_fin<= fecha_ingreso;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_dias_perdidos] error al cargar diasperdidos(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
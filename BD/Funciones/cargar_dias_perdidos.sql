create or replace function public.cargar_dias_perdidos
(
    in xid_empresa numeric,
	in xper_inicio numeric,
	in xper_fin numeric,
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
				periodo,
				dias_perdidos,
			
            from 
                diasperdidos
            where
                id_empresa = xid_empresa and xper_inicio>=periodo and xper_fin<= periodo;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_dias_perdidos] error al cargar diasperdidos(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
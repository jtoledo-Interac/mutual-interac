create or replace function public.cargar_reporte
(
    in xnombre$ varchar,
    out empresas refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xnombre varchar;
    declare xnum_adherente varchar;

    begin

        numerror := 0;
		msjerror := ' ';

        xnombre := coalesce(upper(trim(xnombre$)),'') || '%';

        open empresas for

        select
            id_empresa,
            nombre
        from 
            empresa
        where
            upper(nombre) like '%' || xnombre ||'%';
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_reportes] error al buscar empresas(sql) ' ||sqlerrm;
                return;	
    end;

$body$
language 'plpgsql'

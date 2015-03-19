create or replace function public.cargar_reporte
(
    in xid_empresa integer,
    in xinicio_periodo varchar,
    in xfin_periodo varchar,
    out reportes refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    begin

        numerror := 0;
        msjerror := ' ';

        open reportes for

        select
            e.nombre,
            d.dias_perdidos,
            d.fecha_ingreso,
            a.accidentes,
            a.fecha_ingreso
        from 
            empresa as e, diasperdidos as d, accidentabilidad as a
        where
            e.id_empresa = xid_empresa
            (d.fecha_ingreso >= xinicio_periodo and d.fecha_ingreso <= xfin_periodo)
            (a.fecha_ingreso >= xinicio_periodo and a.fecha_ingreso <= xfin_periodo);
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_reportes] error al cargar el reporte(sql) ' ||sqlerrm;
                return; 
    end;

$body$
language 'plpgsql'

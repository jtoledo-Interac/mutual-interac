create or replace function public.buscar_empresas
(
    in xnombre$ varchar,
    in xnum_adherente$ varchar,
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

        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
        else
            xnum_adherente := upper(trim(xnum_adherente$));
        end if;

        open empresas for

        select
            id_empresa,
            num_adherente,
            nombre,
            cod_cartera,
            nom_experto,
            razon_social,
            ano_de_adhesion,
            segmentacion,
            holding,
            situacion,
            multi_region,
            casa_matriz,
            region_casa_matriz,
            masa_sum,
            planes_de_cuenta,
            planes_de_trabajo,
            firma_de_planes,
            sistema_de_gestion,
            constitucion_cphs,
            certificacion_cphs,
            mmc,
            tmert,
            planesi,
            plaguicida,
            radiacion_uv,
            hipobaria,
            prexor,
            psicosociales,
            proyecto_investigacion,
            ultima_visita_experto,
            ultima_visita_director,
            ultima_visita_gtte,
            ultima_visita_alta_gerencia,
            reporte_visita,
            riesgo_de_fuga,
            reclamo_ultimo_periodo,
            participacion_mesa_trabajo
        from 
            empresa
        where
            upper(nombre) like '%' || xnombre ||'%' and
            (xnum_adherente =  ' ' or upper(trim(num_adherente)) = xnum_adherente)
            
        order by
            nombre;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_empresas] error al buscar empresas(sql) ' ||sqlerrm;
                return;	
    end;

$body$
language 'plpgsql'
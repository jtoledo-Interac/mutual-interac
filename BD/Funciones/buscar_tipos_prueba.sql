create or replace function buscar_tipos_prueba
(
    in "xnomtipo$" character varying, 
    in "ordenarpor$" character varying, 
    in "orden$" character varying, 
    in "pagactual$" numeric, 
    in "canregxpag$" numeric, 
    out tipos refcursor, 
    out numerror character varying, 
    out msjerror character varying,
    out "totalregistros$" numeric
)returns record as

$body$

    declare xnomtipo varchar;
    declare  xncantregdesde$ numeric;
    declare  xncantreghasta$ numeric;
    declare  xordenarpor$  varchar;
    declare  xorden$ varchar;    

    begin
        xnomtipo := coalesce(upper(trim(xnomtipo$)),'') || '%';
        numerror := '0';
        msjerror := ' ';
        begin        
            select 
                count(*)
            into
                totalregistros$
            from            
            (            
                select
                    cod_tipo,
                    des_tipo
                from 
                    tipo
                where
                     upper(des_tipo) like '%' || xnomtipo ||'%' 
            )as subquery;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[busca_tipos] error al buscar tipos(sql) ' ||sqlerrm;
                    return; 
        end;

        if canregxpag$ = 0 then
            --todos
            xncantreghasta$ := totalregistros$;
            xncantregdesde$ := 0;
        else
            --parcial (paginacion)
            xncantreghasta$ := pagactual$ * canregxpag$;
            xncantregdesde$ := xncantreghasta$ - canregxpag$;
        end if;

        begin    
            open tipos for

            select 
                *
            from 
            (   
                select 
                    row_number()over ()  as fila,       
                    consulta1
                from
                (
                    select
                        cod_tipo,
                        des_tipo
                    from 
                        tipo
                    where
                         upper(des_tipo) like '%' || xnomtipo ||'%' 
                    order by
                        des_tipo
                )as consulta1  
            )as consulta2 where fila > xncantregdesde$ and fila <= xncantreghasta$;           

            exception
            when others then           
                numerror := sqlstate;
                msjerror := '[busca_tipos] error al buscar tipos(sql) ' ||sqlerrm;
                return; 
        end;
    end;

$body$
language 'plpgsql'
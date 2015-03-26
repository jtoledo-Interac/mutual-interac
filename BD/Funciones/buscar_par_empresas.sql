create or replace function buscar_par_empresas
(
    out carteras refcursor,
    out regiones refcursor,
    out numerror character varying, 
    out msjerror character varying
)
  returns record as

$body$
begin
    begin
        numerror := '0';
        msjerror := ' ';

        open carteras for

        select
            id_cartera,
            des_cartera
        from 
            cartera
        order by
            des_cartera;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_carteras] error al buscar carteras(sql) ' ||sqlerrm;
                return; 
    end;
    
    begin
        numerror := '0';
        msjerror := ' ';

        open regiones for

        select
            cod_region,
            des_region
               
         from 
            region
        order by
            cod_region;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_comunas] error al buscar comunas(sql) ' ||sqlerrm;
                return; 
    end;
end;
$body$
language plpgsql

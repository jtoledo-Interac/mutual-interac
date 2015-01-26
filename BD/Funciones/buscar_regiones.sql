create or replace function buscar_regiones
(
  out regiones refcursor, 
  out numerror character varying, 
  out msjerror character varying
)
  returns record as
$body$

    begin
        numerror := '0';
  msjerror := ' ';

        open regiones for

        select
      reg_snombre,
        reg_nidregion
           
         from 
            region
        order by
            reg_snombre;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_comunas] error al buscar comunas(sql) ' ||sqlerrm;
                return; 
    end;

$body$
  language plpgsql volatile
  cost 100;
alter function buscar_regiones()
  owner to postgres;

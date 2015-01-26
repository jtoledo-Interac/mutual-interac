CREATE OR REPLACE FUNCTION buscar_estados(OUT estados refcursor, OUT numerror character varying, OUT msjerror character varying)
  RETURNS record AS
$BODY$

    begin
        numerror := '0';
        msjerror := ' ';

        open estados for

        select
            cod_estado,
            des_estado
        from 
            estado
        order by
            des_estado;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_estados] error al buscar estados(sql) ' ||sqlerrm;
                return; 
    end;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION buscar_estados()
  OWNER TO postgres;

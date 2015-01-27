create or replace function public.buscar_empresas
(
    in xnombre$ varchar
    in xnum_adherente$ varchar
    out empresas refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xnombre varchar;
    declare xnum_adherente varchar;

    begin

        numerror := '0';
		msjerror := ' ';

        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
        else
            xnum_adherente := upper(trim(xnum_adherente$));
        end if;

        if trim(xnombre$) = '' then
            xnombre := ' ';
        else
            xnombre := upper(trim(xnombre$));
        end if;


        open empresas for

        select
            num_adherente,
            nombre
        from 
            empresa
        where
            (xnum_adherente =  ' ' or upper(trim(num_adherente)) = xnum_adherente) and
            (xnombre =  ' ' or upper(trim(nombre)) = xnombre) 
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

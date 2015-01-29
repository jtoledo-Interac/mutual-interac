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

        xnombre := coalesce(upper(trim(xnombre$)),'') || '%';

        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
        else
            xnum_adherente := upper(trim(xnum_adherente$));
        end if;

     


        open empresas for

        select
            num_adherente,
            nombre
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

create or replace function public.buscar_perfiles
(
    in xnombre$ varchar,
    out perfiles refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

    declare xnombre varchar;

    begin

        numerror := 0;
		msjerror := ' ';

        xnombre := coalesce(upper(trim(xnombre$)),'') || '%';   

        open perfiles for

        select
            id_perfil,
            des_perfil
        from 
            perfil
        where
             upper(des_perfil) like '%' || xnombre ||'%'
            
        order by
            id_perfil;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_perfiles] error al buscar perfiles(sql) ' ||sqlerrm;
                return;	
    end;

$body$
language 'plpgsql'

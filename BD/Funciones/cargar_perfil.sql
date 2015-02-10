create or replace function public.cargar_perfil
(
    in xid_perfil numeric, 
    out perfil refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    numerror := 0;
    msjerror := ' ';
    begin
        open perfil for

            select
                id_perfil,
                des_perfil                
            from 
                perfil             
                where
                id_perfil = xid_perfil; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_perfil] error al cargar perfil sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
create or replace function public.buscar_perfiles_usuario
(
    in in_idusuario numeric,
    out out_perfiles refcursor, 
    out numerror varchar, 
    out msjerror varchar
) returns record as
$body$
    declare xnombre varchar;
    begin
        numerror := '0';
		msjerror := ' ';
		
        open out_perfiles for
        select
            perfil.des_perfil
        from 
            perfil_usuario, perfil
        where
			perfil_usuario.id_perfil = perfil.id_perfil
			and perfil_usuario.idusuario = in_idusuario;
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_perfiles_usuario] error al buscar perfiles(sql) ' ||sqlerrm;
                return;	
    end;
$body$
language 'plpgsql'

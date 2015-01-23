create or replace function public.cargar_cartera
(
    in xcod_cartera numeric, 
    out carteras refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open carteras for

            select
                des_cartera
               
            from 
                cartera
            where
                cod_cartera = xcod_cartera;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_cartera] error al cargar cartera(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
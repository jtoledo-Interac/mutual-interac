create or replace function public.cargar_cartera
(
    in xid_cartera numeric, 
    out carteras refcursor,
    out numerror varchar, 
    out msjerror varchar
) returns record as

$body$

begin
    
    begin
        open carteras for

            select
                id_cartera,
                des_cartera
            from 
                cartera
            where
                id_cartera = xid_cartera;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_cartera] error al cargar cartera(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$body$
language 'plpgsql'
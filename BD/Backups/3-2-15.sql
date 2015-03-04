--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.7
-- Dumped by pg_dump version 9.3.5
-- Started on 2015-03-03 16:28:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE mutual;
--
-- TOC entry 3082 (class 1262 OID 16637)
-- Name: mutual; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE mutual WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE mutual OWNER TO postgres;

\connect mutual

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 199 (class 3079 OID 12648)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 199
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 258 (class 1255 OID 17074)
-- Name: agregar_cartera(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_cartera(xdes_cartera character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into cartera
		(			
			des_cartera
		)
        values
		(			
			xdes_cartera
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_cartera] error al crear cartera(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_cartera(xdes_cartera character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 241 (class 1255 OID 17165)
-- Name: agregar_documento(character varying, character varying, character varying, character varying, numeric, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_documento(xnombre character varying, xnum_folio character varying, xnum_adherente character varying, xdescripcion character varying, xid_cartera numeric, xid_producto numeric, xcod_area character varying, OUT xid_documento bigint, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xid_documento$ bigint;

	begin
	
		xid_documento$ := nextval('seq_documento');
		numerror := 0;
		msjerror := '';

		insert into documento
		(
			id_documento,
			nombre,
			num_folio,
			num_adherente,
			descripcion,
			id_cartera,
			id_producto,
			cod_area,
			fec_creacion
		)
        values
		(
			xid_documento$,
			xnombre,
			xnum_folio,
			xnum_adherente,
			xdescripcion,
			xid_cartera,
			xid_producto,
			xcod_area,
			now()
		);

        xid_documento := xid_documento$;
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_documento] error al crear documento(sql) ' ||sqlerrm;
				return;	
	end;
$_$;


ALTER FUNCTION public.agregar_documento(xnombre character varying, xnum_folio character varying, xnum_adherente character varying, xdescripcion character varying, xid_cartera numeric, xid_producto numeric, xcod_area character varying, OUT xid_documento bigint, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 281 (class 1255 OID 17212)
-- Name: agregar_empresa(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_empresa(xnum_adherente character varying, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    

	begin	
		
		numerror := 0;
		msjerror := '';

		insert into empresa
		(
			num_adherente,
			nombre
		)
        values
		(
			xnum_adherente,
			xnombre
		);

       
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_empresa] error al crear empresa(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_empresa(xnum_adherente character varying, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 17095)
-- Name: agregar_estado(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_estado(xdes_estado character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into estado
		(
			des_estado
		)
        values
		(
			xdes_estado
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_estado] error al crear estado(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_estado(xdes_estado character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 17138)
-- Name: agregar_medio(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_medio(xdes_medio character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into medios_respuesta
		(
			des_medio_respuesta
		)
        values
		(
			xdes_medio
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_medio] error al crear medio(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_medio(xdes_medio character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 222 (class 1255 OID 16941)
-- Name: agregar_medio_respuesta(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_medio_respuesta(xcod_medio_respuesta character varying, xdes_medio_respuesta character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into medios_respuesta
		(
			cod_medio_respuesta,
			des_medio_respuesta
		)
        values
		(
			xcod_medio_respuesta,
			xdes_medio_respuesta
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_medio_respuesta	] error al crear medio(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_medio_respuesta(xcod_medio_respuesta character varying, xdes_medio_respuesta character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 17111)
-- Name: agregar_motivo(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_motivo(xdes_motivo character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into motivo
		(			
			des_motivo
		)
        values
		(			
			xdes_motivo
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_motivo] error al crear motivo(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_motivo(xdes_motivo character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 221 (class 1255 OID 17232)
-- Name: agregar_perfil(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_perfil(xdes_perfil character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into perfil
		(
			des_perfil
		)
        values
		(
			xdes_perfil
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_perfil] error al crear perfil(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_perfil(xdes_perfil character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 17151)
-- Name: agregar_prioridad(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_prioridad(xdes_prioridad character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into prioridad
		(
			des_prioridad
		)
        values
		(
			xdes_prioridad
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_prioridad] error al crear prioridad(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_prioridad(xdes_prioridad character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 17019)
-- Name: agregar_producto(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_producto(xdes_producto character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$  

		begin
		
			numerror := 0;
			msjerror := '';

			insert into producto
			(				
				des_producto
			)
	        values
			(				
				xdes_producto
			);

	        return;

			exception
				when others then
					numerror := sqlstate;
					msjerror := '[agregar_producto] error al crear producto(sql) ' ||sqlerrm;
					return;	
		end;
	$$;


ALTER FUNCTION public.agregar_producto(xdes_producto character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 279 (class 1255 OID 17202)
-- Name: agregar_reclamo(character varying, character varying, character varying, character varying, character varying, numeric, numeric, numeric, numeric, timestamp without time zone, character varying, character varying, character varying, numeric, character varying, character varying, character varying, character varying, numeric, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_reclamo(xnum_adherente character varying, xnombre_solicitante character varying, xemail_solicitante character varying, xfono_solicitante character varying, xregion_solicitante character varying, xid_tipo numeric, xid_motivo numeric, xid_prioridad numeric, xid_cartera numeric, xfec_ingreso timestamp without time zone, xglosa character varying, xadjunto character varying, xobservaciones character varying, xid_estado numeric, xresponsable_ingreso character varying, xresponsable_actual character varying, xdias_bandeja character varying, xdias_sistema character varying, xid_medio_respuesta numeric, xfec_respuesta timestamp without time zone, OUT xid_reclamo bigint, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xid_reclamo$ bigint;

	begin
	
		xid_reclamo$ := nextval('seq_reclamo');
		numerror := 0;
		msjerror := '';

		insert into reclamo
		(
			id_reclamo,
			num_adherente,
			nombre_solicitante,
			email_solicitante,
			fono_solicitante,
			region_solicitante,
			id_tipo,
			id_motivo,
			id_prioridad,
			id_cartera,
			fec_ingreso,
			glosa,
			adjunto,
			observaciones,
			id_estado,
			responsable_ingreso,
			responsable_actual,
			dias_bandeja,
			dias_sistema,
			id_medio_respuesta,
			fec_respuesta
		)
        values
		(
			xid_reclamo$,
			xnum_adherente,
			xnombre_solicitante,
			xemail_solicitante,
			xfono_solicitante,
			xregion_solicitante,
			xid_tipo,
			xid_motivo,
			xid_prioridad,
			xid_cartera,
			xfec_ingreso,
			xglosa,
			xadjunto,
			xobservaciones,
			xid_estado,
			xresponsable_ingreso,
			xresponsable_actual,
			xdias_bandeja,
			xdias_sistema,
			xid_medio_respuesta,
			xfec_respuesta
		);

        xid_reclamo := xid_reclamo$;
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_reclamo] error al crear reclamo(sql) ' ||sqlerrm;
				return;	
	end;
$_$;


ALTER FUNCTION public.agregar_reclamo(xnum_adherente character varying, xnombre_solicitante character varying, xemail_solicitante character varying, xfono_solicitante character varying, xregion_solicitante character varying, xid_tipo numeric, xid_motivo numeric, xid_prioridad numeric, xid_cartera numeric, xfec_ingreso timestamp without time zone, xglosa character varying, xadjunto character varying, xobservaciones character varying, xid_estado numeric, xresponsable_ingreso character varying, xresponsable_actual character varying, xdias_bandeja character varying, xdias_sistema character varying, xid_medio_respuesta numeric, xfec_respuesta timestamp without time zone, OUT xid_reclamo bigint, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 17057)
-- Name: agregar_tipo(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_tipo(xdes_tipo character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into tipo
		(
			
			des_tipo
		)
        values
		(
			
			xdes_tipo
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_tipo] error al crear tipo(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_tipo(xdes_tipo character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 212 (class 1255 OID 16638)
-- Name: agregar_usuario(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, date, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_usuario(xrut character varying, xdv character varying, xnombres character varying, xapepaterno character varying, xapematerno character varying, xnomusuario character varying, xcontrasena character varying, xcodgenero character varying, xfecnacimiento date, xtelefono character varying, xcelular character varying, xemail character varying, OUT xnidusuario bigint, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xnidusuario$ bigint;

	begin
	
		xnidusuario$ := nextval('seq_usuario');
		numerror := 0;
		msjerror := '';

		insert into usuario
		(
			idusuario,
			rut,
			dv,
			nombres,
			apepaterno,
			apematerno,
			nomusuario,
			contrasena,
			codgenero,
			fecnacimiento,
			telefono,
			celular,
			email,
			feccreacion,
			indvigencia
		)
        values
		(
			xnidusuario$,
			xrut,
			xdv,
			xnombres,
			xapepaterno,
			xapematerno,
			xnomusuario,
			xcontrasena,
			xcodgenero,
			xfecnacimiento,
			xtelefono,
			xcelular,
			xemail,
			now(),
			'h'
		);

        xnidusuario := xnidusuario$;
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_usuario] error al crear usuario(sql) ' ||sqlerrm;
				return;	
	end;
$_$;


ALTER FUNCTION public.agregar_usuario(xrut character varying, xdv character varying, xnombres character varying, xapepaterno character varying, xapematerno character varying, xnomusuario character varying, xcontrasena character varying, xcodgenero character varying, xfecnacimiento date, xtelefono character varying, xcelular character varying, xemail character varying, OUT xnidusuario bigint, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 17075)
-- Name: buscar_carteras(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_carteras("xnomcartera$" character varying, OUT carteras refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
     declare xnomcartera varchar;

    begin
        numerror := 0;
        msjerror := ' ';

        xnomcartera := coalesce(upper(trim(xnomcartera$)),'') || '%';

        open carteras for

        select
            id_cartera,
            des_cartera
        from 
            cartera
        where 
            upper(des_cartera) like '%' || xnomcartera ||'%'
         order by
            id_cartera;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_carteras] error al buscar carteras(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_carteras("xnomcartera$" character varying, OUT carteras refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 287 (class 1255 OID 17307)
-- Name: buscar_documentos(character varying, character varying, character varying, numeric, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_documentos("xnombre$" character varying, "xnum_folio$" character varying, "xnum_adherente$" character varying, "xid_cartera$" numeric, "xid_producto$" numeric, "xcod_area$" character varying, OUT documentos refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xnombre varchar;
    declare xnum_folio varchar;
    declare xnum_adherente varchar;
    declare xid_cartera numeric;
    declare xid_producto numeric;
    declare xcod_area varchar;

    begin
        numerror := 0;
        msjerror := ' ';


        /*filtros*/
        xnombre := '%' || coalesce(upper(trim(xnombre$)),'') || '%';
        xnum_folio :=  coalesce(upper(trim(xnum_folio$)),'')   ;
        xnum_adherente :=  coalesce(upper(trim(xnum_adherente$)),'')   ;
        xid_cartera := xid_cartera$;
        xid_producto := xid_producto$;
        
	
        if trim(xnum_folio$) = '' then
            xnum_folio := ' ';
            end if;
            
        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
            end if;
            

        if trim(xcod_area$) = '' then
            xcod_area := ' ';
        else
            xcod_area := upper(trim(xcod_area$));
        end if;

        open documentos for

        select
            id_documento,
            nombre,
            num_folio,
            num_adherente,
            descripcion,
            d.id_cartera as id_cartera,
            c.des_cartera as des_cartera,
            d.id_producto as id_producto,
            p.des_producto as des_producto,
            d.cod_area as cod_area,
            a.des_area as des_area,
            fec_creacion
        from 
            documento d 
        inner join area as a 
            on d.cod_area = a.cod_area
        inner join cartera as c 
            on d.id_cartera = c.id_cartera
        inner join producto as p 
            on d.id_producto = p.id_producto
where
            upper(d.nombre) like '%' || xnombre ||'%'         and
            (xnum_folio = ' ' or upper(d.num_folio) = xnum_folio) and
            (xnum_adherente = ' ' or upper(d.num_adherente) = xnum_adherente) and
            (xid_cartera = 0  or d.id_cartera = xid_cartera) and
            (xid_producto = 0 or d.id_producto = xid_producto) and
            (xcod_area =  ' ' or upper(d.cod_area) = xcod_area)
        order by
            id_documento;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_documentos] error al buscar documentos(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_documentos("xnombre$" character varying, "xnum_folio$" character varying, "xnum_adherente$" character varying, "xid_cartera$" numeric, "xid_producto$" numeric, "xcod_area$" character varying, OUT documentos refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 276 (class 1255 OID 17220)
-- Name: buscar_empresas(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_empresas("xnombre$" character varying, "xnum_adherente$" character varying, OUT empresas refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xnombre varchar;
    declare xnum_adherente varchar;

    begin

        numerror := 0;
		msjerror := ' ';

        xnombre := coalesce(upper(trim(xnombre$)),'') || '%';

        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
        else
            xnum_adherente := upper(trim(xnum_adherente$));
        end if;

     


        open empresas for

        select
            id_empresa,
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

$_$;


ALTER FUNCTION public.buscar_empresas("xnombre$" character varying, "xnum_adherente$" character varying, OUT empresas refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 277 (class 1255 OID 17098)
-- Name: buscar_estados(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_estados("xnomestado$" character varying, OUT estados refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
        declare xnomestado varchar;
    begin
        xnomestado := coalesce(upper(trim(xnomestado$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open estados for

        select
            id_estado,
            des_estado
        from 
            estado
        where
             upper(des_estado) like '%' || xnomestado ||'%' 
        order by
            des_estado;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_estados] error al buscar estados(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_estados("xnomestado$" character varying, OUT estados refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 17189)
-- Name: buscar_medios(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_medios("xnommedio$" character varying, OUT medios refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
        declare xnommedio varchar;
    begin
        xnommedio := coalesce(upper(trim(xnommedio$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open medios for

        select
            id_medio_respuesta,
            des_medio_respuesta
        from 
            medios_respuesta
        where
             upper(des_medio_respuesta) like '%' || xnommedio ||'%'                  
        order by
            des_medio_respuesta;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_medios] error al buscar medios(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_medios("xnommedio$" character varying, OUT medios refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 16950)
-- Name: buscar_medios_respuestas(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_medios_respuestas("xnommedios_respuesta$" character varying, OUT medios_respuestas refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
        declare xnommedios_respuesta varchar;
    begin
        xnommedios_respuesta := coalesce(upper(trim(xnommedios_respuesta$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open medios_respuestas for

        select
            cod_medios_respuesta,
            des_medios_respuesta
        from 
            medios_respuesta
        where
             upper(des_medios_respuesta) like '%' || xnommedios_respuesta ||'%' 
        order by
            des_medios_respuesta;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_medios_respuestas] error al buscar medios_respuestas(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_medios_respuestas("xnommedios_respuesta$" character varying, OUT medios_respuestas refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 266 (class 1255 OID 17112)
-- Name: buscar_motivos(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_motivos("xnommotivo$" character varying, OUT motivos refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
        declare xnommotivo varchar;
    begin
        xnommotivo := coalesce(upper(trim(xnommotivo$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open motivos for

        select
            id_motivo,
            des_motivo
        from 
            motivo
        where
             upper(des_motivo) like '%' || xnommotivo ||'%' 
        order by
            des_motivo;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_motivos] error al buscar motivos(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_motivos("xnommotivo$" character varying, OUT motivos refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 270 (class 1255 OID 17186)
-- Name: buscar_par_reclamos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_par_reclamos(OUT tipos refcursor, OUT motivos refcursor, OUT prioridades refcursor, OUT carteras refcursor, OUT estados refcursor, OUT medios_respuestas refcursor, OUT regiones refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
    
    begin
        numerror := 0;
        msjerror := ' ';

        open tipos for

        select
            id_tipo,
            des_tipo
        from 
            tipo
        order by
            des_tipo;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_tipos] error al buscar tipos(sql) ' ||sqlerrm;
                return; 
    end;

    begin
        numerror := '0';
        msjerror := ' ';

        open motivos for

        select
            id_motivo,
            des_motivo
        from 
            motivo
        order by
            des_motivo;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_motivos] error al buscar motivos(sql) ' ||sqlerrm;
                return; 
    end;

    begin
        numerror := '0';
        msjerror := ' ';

        open prioridades for

        select
            id_prioridad,
            des_prioridad
        from 
            prioridad
        order by
            des_prioridad;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_prioridades] error al buscar prioridades(sql) ' ||sqlerrm;
                return; 
    end;

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

        open estados for

        select
            id_estado,
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


    begin
        numerror := '0';
        msjerror := ' ';

        open medios_respuestas for

        select
            id_medio_respuesta,
            des_medio_respuesta
        from 
            medios_respuesta
        order by
            des_medio_respuesta;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_medios_respuestas] error al buscar medios_respuestas(sql) ' ||sqlerrm;
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
$$;


ALTER FUNCTION public.buscar_par_reclamos(OUT tipos refcursor, OUT motivos refcursor, OUT prioridades refcursor, OUT carteras refcursor, OUT estados refcursor, OUT medios_respuestas refcursor, OUT regiones refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 17102)
-- Name: buscar_parametros(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_parametros(OUT carteras refcursor, OUT productos refcursor, OUT areas refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
    begin
        numerror := 0;
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
                msjerror := '[buscar_parametros] error al buscar carteras(sql) ' ||sqlerrm;
                return; 
    end;

    begin
        numerror := '0';
        msjerror := ' ';

        open productos for

        select
            id_producto,
            des_producto
        from 
            producto
        order by
            des_producto;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[buscar_parametros] error al buscar productos(sql) ' ||sqlerrm;
                return; 
    end;

    begin
        numerror := '0';
        msjerror := ' ';

        open areas for

        select
            cod_area,
            des_area
        from 
            area
        order by
            des_area;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[buscar_parametros] error al buscar areas(sql) ' ||sqlerrm;
                return; 
    end;
end;
$$;


ALTER FUNCTION public.buscar_parametros(OUT carteras refcursor, OUT productos refcursor, OUT areas refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 278 (class 1255 OID 17221)
-- Name: buscar_perfiles(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_perfiles("xnombre$" character varying, OUT perfiles refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

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

$_$;


ALTER FUNCTION public.buscar_perfiles("xnombre$" character varying, OUT perfiles refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 17267)
-- Name: buscar_perfiles_usuario(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_perfiles_usuario(in_idusuario numeric, OUT out_perfiles refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
    declare xnombre varchar;
    begin
        numerror := 0;
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
$$;


ALTER FUNCTION public.buscar_perfiles_usuario(in_idusuario numeric, OUT out_perfiles refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 17153)
-- Name: buscar_prioridades(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_prioridades("xnomprioridad$" character varying, OUT prioridades refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
        declare xnomprioridad varchar;
    begin
        xnomprioridad := coalesce(upper(trim(xnomprioridad$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open prioridades for

        select
            id_prioridad,
            des_prioridad
        from 
            prioridad
        where
             upper(des_prioridad) like '%' || xnomprioridad ||'%' 
        order by
            des_prioridad;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_prioridads] error al buscar prioridads(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_prioridades("xnomprioridad$" character varying, OUT prioridades refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 17020)
-- Name: buscar_productos(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_productos("xnomproducto$" character varying, OUT productos refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
        declare xnomproducto varchar;
    begin
        xnomproducto := coalesce(upper(trim(xnomproducto$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open productos for

        select
            id_producto,
            des_producto
        from 
            producto
        where
             upper(des_producto) like '%' || xnomproducto ||'%' 
        order by
            des_producto;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_productos] error al buscar productos(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_productos("xnomproducto$" character varying, OUT productos refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 17200)
-- Name: buscar_reclamos(character varying, character varying, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_reclamos("xnombre_solicitante$" character varying, "xnum_adherente$" character varying, "xid_cartera$" numeric, "xid_tipo$" numeric, "xid_estado$" numeric, "xid_prioridad$" numeric, "xid_reclamo$" numeric, OUT reclamos refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xid_reclamo numeric;
    declare xnombre_solicitante varchar;
    declare xnum_adherente varchar;
    declare xid_cartera numeric;
    declare xid_tipo numeric;
    declare xid_estado numeric;
    declare xid_prioridad numeric;

    begin
        numerror := 0;
        msjerror := ' ';

        
        xnombre_solicitante := coalesce(upper(trim(xnombre_solicitante$)),'') || '%';
    
       
        xid_reclamo=xid_reclamo$;
    

        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
        else
            xnum_adherente := upper(trim(xnum_adherente$));
        end if;

          
        xid_cartera=xid_cartera$;
        xid_tipo=xid_tipo$;
        xid_estado=xid_estado$;
        xid_prioridad=xid_prioridad$;
       

        open reclamos for

        select
            id_reclamo,
            num_adherente,
            nombre_solicitante,
            email_solicitante,
            fono_solicitante,
            region_solicitante,
            r.id_tipo as id_tipo,
            t.des_tipo as des_tipo,
            r.id_motivo as id_motivo,
            m.des_motivo as des_motivo,
	    r.id_prioridad as id_prioridad,
            p.des_prioridad as des_prioridad,
            r.id_cartera as id_cartera,
            c.des_cartera as des_cartera,
            fec_ingreso,
            glosa,
            adjunto,
            observaciones,
            r.id_estado as id_estado,
            e.des_estado as des_estado,
            responsable_ingreso,
            responsable_actual,
            dias_bandeja,
            dias_sistema,
            r.id_medio_respuesta as id_medio_respuesta,
            me.des_medio_respuesta as des_medio_respuesta,
            fec_respuesta
        from 
            reclamo r
         inner join tipo as t
                on r.id_tipo = t.id_tipo
           inner join motivo as m
                on r.id_motivo = m.id_motivo
            inner join prioridad as p
                on r.id_prioridad = p.id_prioridad
            inner join cartera as c
                on r.id_cartera = c.id_cartera
            inner join estado as e
                on r.id_estado = e.id_estado
            inner join medios_respuesta me
                on r.id_medio_respuesta = me.id_medio_respuesta   
      where
          upper(nombre_solicitante) like '%' || xnombre_solicitante ||'%'            and
		(xnum_adherente =  ' ' or upper(trim(num_adherente)) = xnum_adherente)and
         (xid_cartera =   0 or r.id_cartera = xid_cartera) and
	(xid_tipo =      0 or r.id_tipo = xid_tipo) and
           (xid_estado =    0 or r.id_estado = xid_estado) and
            (xid_prioridad = 0 or r.id_prioridad = xid_prioridad) and
          (xid_reclamo = 0 or id_reclamo = xid_reclamo)
        
          order by
            id_reclamo;           
             
    
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_reclamos] error al buscar reclamos(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_reclamos("xnombre_solicitante$" character varying, "xnum_adherente$" character varying, "xid_cartera$" numeric, "xid_tipo$" numeric, "xid_estado$" numeric, "xid_prioridad$" numeric, "xid_reclamo$" numeric, OUT reclamos refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 274 (class 1255 OID 17190)
-- Name: buscar_reclamos_paginacion(character varying, character varying, numeric, numeric, numeric, numeric, numeric, character varying, character varying, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_reclamos_paginacion("xnombre_solicitante$" character varying, "xnum_adherente$" character varying, "xid_cartera$" numeric, "xid_tipo$" numeric, "xid_estado$" numeric, "xid_prioridad$" numeric, "xid_reclamo$" numeric, "ordenarpor$" character varying, "orden$" character varying, "pagactual$" numeric, "canregxpag$" numeric, OUT reclamos refcursor, OUT numerror character varying, OUT msjerror character varying, OUT "totalregistros$" numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xid_reclamo numeric;
    declare xnombre_solicitante varchar;
    declare xnum_adherente varchar;
    declare xid_cartera numeric;
    declare xid_tipo numeric;
    declare xid_estado numeric;
    declare xid_prioridad numeric;
    declare  xncantregdesde$ numeric;
    declare  xncantreghasta$ numeric;
    declare  xordenarpor$  varchar;
    declare  xorden$ varchar;    

    begin
        numerror := 0;
        msjerror := ' ';

        
        xnombre_solicitante := coalesce(upper(trim(xnombre_solicitante$)),'') || '%';
        xordenarpor$ := upper(trim(ordenarpor$));
        xorden$      := upper(trim(orden$));
        xid_reclamo=xid_reclamo$;
        xid_cartera=xid_cartera$;
        xid_tipo=xid_tipo$;
        xid_estado=xid_estado$;
        xid_prioridad=xid_prioridad$;

        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
        else
            xnum_adherente := upper(trim(xnum_adherente$));
        end if;


    
       begin        
            select 
                count(*)
            into
                totalregistros$
            from            
            (
                select
                    id_reclamo,
                    num_adherente,
                    nombre_solicitante,
                    email_solicitante,
                    fono_solicitante,
                    region_solicitante,
                    r.id_tipo as id_tipo,
                    t.des_tipo as des_tipo,
                    r.id_motivo as id_motivo,
                    m.des_motivo as des_motivo,
                    r.id_prioridad as id_prioridad,
                    p.des_prioridad as des_prioridad,
                    r.id_cartera as id_cartera,
                    c.des_cartera as des_cartera,
                    fec_ingreso,
                    glosa,
                    adjunto,
                    observaciones,
                    r.id_estado as id_estado,
                    e.des_estado as des_estado,
                    responsable_ingreso,
                    responsable_actual,
                    dias_bandeja,
                    dias_sistema,
                    r.id_medio_respuesta as id_medio_respuesta,
                    me.des_medio_respuesta as des_medio_respuesta,
                    fec_respuesta
                from 
                    reclamo r
                    inner join tipo as t
                        on r.id_tipo = t.id_tipo
                    inner join motivo as m
                        on r.id_motivo = m.id_motivo
                    inner join prioridad as p
                        on r.id_prioridad = p.id_prioridad
                    inner join cartera as c
                        on r.id_cartera = c.id_cartera
                    inner join estado as e
                        on r.id_estado = e.id_estado
                    inner join medios_respuesta me
                        on r.id_medio_respuesta = me.id_medio_respuesta 
                where
                  upper(nombre_solicitante) like '%' || xnombre_solicitante ||'%' and
                   (xnum_adherente =  ' ' or num_adherente = xnum_adherente) and
                    (xid_cartera = 0 or c.id_cartera = xid_cartera) and
                    (xid_tipo = 0 or r.id_tipo = xid_tipo) and
                    (xid_estado =  0 or r.id_estado = xid_estado) and
                    (xid_prioridad = 0 or r.id_prioridad = xid_prioridad) and
                  (xid_reclamo = 0 or id_reclamo = xid_reclamo)
                
            )as subrutina;          
                 
        
            exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_reclamos] error al buscar reclamos(sql) ' ||sqlerrm;
                return; 
        end;


         if canregxpag$ = 0 then
            --todos
            xncantreghasta$ := totalregistros$;
            xncantregdesde$ := 0;
        else
            --parcial (paginacion)
            xncantreghasta$ := pagactual$ * canregxpag$;
            xncantregdesde$ := xncantreghasta$ - canregxpag$;
        end if;


 begin    
            open reclamos for

            select 
                *
            from 
            (   
                select 
                    row_number()over ()  as fila,       
                    consulta1
                from
                (
                    select
                        id_reclamo,
                        num_adherente,
                        nombre_solicitante,
                        email_solicitante,
                        fono_solicitante,
                        region_solicitante,
                        r.id_tipo as id_tipo,
                        t.des_tipo as des_tipo,
                        r.id_motivo as id_motivo,
                        m.des_motivo as des_motivo,
                        r.id_prioridad as id_prioridad,
                        p.des_prioridad as des_prioridad,
                        r.id_cartera as id_cartera,
                        c.des_cartera as des_cartera,
                        fec_ingreso,
                        glosa,
                        adjunto,
                        observaciones,
                        r.id_estado as id_estado,
                        e.des_estado as des_estado,
                        responsable_ingreso,
                        responsable_actual,
                        dias_bandeja,
                        dias_sistema,
                        r.id_medio_respuesta as id_medio_respuesta,
                        me.des_medio_respuesta as des_medio_respuesta,
                        fec_respuesta
                    from 
                       reclamo r
                        inner join tipo as t
                            on r.id_tipo = t.id_tipo
                        inner join motivo as m
                            on r.id_motivo = m.id_motivo
                        inner join prioridad as p
                            on r.id_prioridad = p.id_prioridad
                        inner join cartera as c
                            on r.id_cartera = c.id_cartera
                        inner join estado as e
                            on r.id_estado = e.id_estado
                        inner join medios_respuesta me
                            on r.id_medio_respuesta = me.id_medio_respuesta 
                    where
                        upper(nombre_solicitante) like '%' || xnombre_solicitante ||'%' and
                        (xnum_adherente =  ' ' or upper(trim(num_adherente)) = xnum_adherente) and
                        (xid_cartera =   0 or r.id_cartera = xid_cartera) and
                        (xid_tipo =      0 or r.id_tipo = xid_tipo) and
                        (xid_estado =    0 or r.id_estado = xid_estado) and
                        (xid_prioridad = 0 or r.id_prioridad = xid_prioridad) and
                        (xid_reclamo = 0 or id_reclamo = xid_reclamo)
                    order by
                        nombre_solicitante
                )as consulta1  
            )as consulta2 where fila > xncantregdesde$ and fila <= xncantreghasta$;           

            exception
            when others then           
                numerror := sqlstate;
                msjerror := '[busca_tipos] error al buscar tipos(sql) ' ||sqlerrm;
                return; 
        end;
    end;

$_$;


ALTER FUNCTION public.buscar_reclamos_paginacion("xnombre_solicitante$" character varying, "xnum_adherente$" character varying, "xid_cartera$" numeric, "xid_tipo$" numeric, "xid_estado$" numeric, "xid_prioridad$" numeric, "xid_reclamo$" numeric, "ordenarpor$" character varying, "orden$" character varying, "pagactual$" numeric, "canregxpag$" numeric, OUT reclamos refcursor, OUT numerror character varying, OUT msjerror character varying, OUT "totalregistros$" numeric) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 16838)
-- Name: buscar_regiones(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_regiones(OUT regiones refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
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

$$;


ALTER FUNCTION public.buscar_regiones(OUT regiones refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 17036)
-- Name: buscar_tipos(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_tipos("xnomtipo$" character varying, OUT tipos refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
        declare xnomtipo varchar;
    begin
        xnomtipo := coalesce(upper(trim(xnomtipo$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open tipos for

        select
            id_tipo,
            des_tipo
        from 
            tipo
        where
             upper(des_tipo) like '%' || xnomtipo ||'%' 
        order by
            des_tipo;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_tipos] error al buscar tipos(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_tipos("xnomtipo$" character varying, OUT tipos refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 17000)
-- Name: buscar_tipos_prueba(character varying, character varying, character varying, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_tipos_prueba("xnomtipo$" character varying, "ordenarpor$" character varying, "orden$" character varying, "pagactual$" numeric, "canregxpag$" numeric, OUT tipos refcursor, OUT numerror character varying, OUT msjerror character varying, OUT "totalregistros$" numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xnomtipo varchar;
    declare  xncantregdesde$ numeric;
    declare  xncantreghasta$ numeric;
    declare  xordenarpor$  varchar;
    declare  xorden$ varchar;    

    begin
        xnomtipo := coalesce(upper(trim(xnomtipo$)),'') || '%';
        numerror := 0;
        msjerror := ' ';
        begin        
            select 
                count(*)
            into
                totalregistros$
            from            
            (            
                select
                    cod_tipo,
                    des_tipo
                from 
                    tipo
                where
                     upper(des_tipo) like '%' || xnomtipo ||'%' 
            )as subquery;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[busca_tipos] error al buscar tipos(sql) ' ||sqlerrm;
                    return; 
        end;

        if canregxpag$ = 0 then
            --todos
            xncantreghasta$ := totalregistros$;
            xncantregdesde$ := 0;
        else
            --parcial (paginacion)
            xncantreghasta$ := pagactual$ * canregxpag$;
            xncantregdesde$ := xncantreghasta$ - canregxpag$;
        end if;

        begin    
            open tipos for

            select 
                *
            from 
            (   
                select 
                    row_number()over ()  as fila,       
                    consulta1
                from
                (
                    select
                        cod_tipo,
                        des_tipo
                    from 
                        tipo
                    where
                         upper(des_tipo) like '%' || xnomtipo ||'%' 
                    order by
                        des_tipo
                )as consulta1  
            )as consulta2 where fila > xncantregdesde$ and fila <= xncantreghasta$;           

            exception
            when others then           
                numerror := sqlstate;
                msjerror := '[busca_tipos] error al buscar tipos(sql) ' ||sqlerrm;
                return; 
        end;
    end;

$_$;


ALTER FUNCTION public.buscar_tipos_prueba("xnomtipo$" character varying, "ordenarpor$" character varying, "orden$" character varying, "pagactual$" numeric, "canregxpag$" numeric, OUT tipos refcursor, OUT numerror character varying, OUT msjerror character varying, OUT "totalregistros$" numeric) OWNER TO postgres;

--
-- TOC entry 288 (class 1255 OID 17308)
-- Name: buscar_usuarios(character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_usuarios("rut$" character varying, "dv$" character varying, "nombres$" character varying, "apepaterno$" character varying, "apematerno$" character varying, "nomusuario$" character varying, OUT usuarios refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xrut varchar; 
    declare xdv varchar;
    declare xnombres varchar;
    declare xapepaterno varchar;
    declare xapematerno varchar;
    declare xnomusuario varchar;

    begin
        numerror := 0;
        msjerror := ' ';

        /*filtros*/
        xrut := '%' || coalesce(upper(trim(rut$)),'') || '%';
        xnombres    := '%' ||coalesce(upper(trim(nombres$)),'') || '%';
        xapepaterno := '%' || coalesce(upper(trim(apepaterno$)),'') || '%';
        xapematerno := '%' || coalesce(upper(trim(apematerno$)),'') || '%';
        xnomusuario := '%' || coalesce(upper(trim(nomusuario$)),'') || '%';

        open usuarios for

        select
            idusuario,
            rut,
            dv,
            nombres,
            apepaterno,
            apematerno,
            nomusuario,
            contrasena,
            codgenero,
            fecnacimiento,        
            telefono,
            celular,
            email,
            cantintentos,
            feccreacion,
            feccontrasena,
            indvigencia
        from 
            usuario
        where
            rut like xrut and
            upper(nombres) like '%' || xnombres ||'%' and
            upper(apepaterno) like xapepaterno and
            upper(apematerno) like xapematerno and
            upper(nomusuario) like xnomusuario
        order by
            idusuario; 
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_usuarios] error al buscar usuarios(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_usuarios("rut$" character varying, "dv$" character varying, "nombres$" character varying, "apepaterno$" character varying, "apematerno$" character varying, "nomusuario$" character varying, OUT usuarios refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 17096)
-- Name: cargar_cartera(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_cartera(xid_cartera numeric, OUT carteras refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
	numerror := 0;
        msjerror := ' ';
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

$$;


ALTER FUNCTION public.cargar_cartera(xid_cartera numeric, OUT carteras refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 219 (class 1255 OID 17167)
-- Name: cargar_documento(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_documento(xniddocumento numeric, OUT documentos refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open documentos for

            select
                id_documento,
                nombre,
                num_folio,
                num_adherente,
                descripcion,
                id_cartera,
                id_producto,
                cod_area,
                fec_creacion
            from 
                documento
            where
                id_documento = xniddocumento;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_documento] error al cargar documento(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_documento(xniddocumento numeric, OUT documentos refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 275 (class 1255 OID 17214)
-- Name: cargar_empresa(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_empresa(xid_empresa numeric, OUT empresas refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin

        numerror := 0;
        msjerror := '';
        open empresas for

            select
                num_adherente,
                id_empresa,
                nombre
            from 
                empresa
            where
                id_empresa = xid_empresa;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_empresa] error al cargar empresa(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_empresa(xid_empresa numeric, OUT empresas refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 220 (class 1255 OID 17099)
-- Name: cargar_estado(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_estado(xid_estado numeric, OUT estado refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open estado  for

            select
                id_estado,
                des_estado                
            from 
                estado             
                where
                id_estado = xid_estado; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_estado  error al cargar estado sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_estado(xid_estado numeric, OUT estado refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 17140)
-- Name: cargar_medio(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_medio(xid_medio numeric, OUT medios refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open medios for

            select
                id_medio_respuesta,
                des_medio_respuesta                
            from 
                medios_respuesta             
                where
                    id_medio_respuesta = xid_medio; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_medio  error al cargar medio sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_medio(xid_medio numeric, OUT medios refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 16960)
-- Name: cargar_medio_respuesta(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_medio_respuesta(xcod_medio_respuesta character varying, OUT medio_respuesta refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open medio_respuesta  for

            select
                cod_medio_respuesta,
                des_medio_respuesta                
            from 
                medio_respuesta             
                where
                cod_medio_respuesta = xcod_medio_respuesta; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_medio_respuesta  error al cargar medio_respuesta sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_medio_respuesta(xcod_medio_respuesta character varying, OUT medio_respuesta refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 268 (class 1255 OID 17113)
-- Name: cargar_motivo(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_motivo(xid_motivo numeric, OUT motivo refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open motivo  for

            select
                id_motivo,
                des_motivo                
            from 
                motivo             
                where
                id_motivo = xid_motivo; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_motivo  error al cargar motivo sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_motivo(xid_motivo numeric, OUT motivo refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 17263)
-- Name: cargar_perfil(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_perfil(xid_perfil numeric, OUT perfil refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
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

$$;


ALTER FUNCTION public.cargar_perfil(xid_perfil numeric, OUT perfil refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 243 (class 1255 OID 17154)
-- Name: cargar_prioridad(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_prioridad(xid_prioridad numeric, OUT prioridad refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open prioridad  for

            select
                id_prioridad,
                des_prioridad                
            from 
                prioridad             
                where
                id_prioridad = xid_prioridad; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_prioridad  error al cargar prioridad sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_prioridad(xid_prioridad numeric, OUT prioridad refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 17021)
-- Name: cargar_producto(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_producto(xid_producto numeric, OUT producto refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open producto  for

            select
                id_producto,
                des_producto                
            from 
                producto             
                where
                id_producto = xid_producto; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_producto  error al cargar producto sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_producto(xid_producto numeric, OUT producto refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 17183)
-- Name: cargar_reclamo(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_reclamo(xid_reclamo numeric, OUT reclamos refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open reclamos for

            select
                id_reclamo,
                num_adherente,
                nombre_solicitante,
                email_solicitante,
                fono_solicitante,
                region_solicitante,
                id_tipo,
                id_motivo,
                id_prioridad,
                id_cartera,
                fec_ingreso,
                glosa,
                adjunto,
                observaciones,
                id_estado,
                responsable_ingreso,
                responsable_actual,
                dias_bandeja,
                dias_sistema,
                id_medio_respuesta,
                fec_respuesta
            from 
                reclamo
            where
                id_reclamo = xid_reclamo;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_reclamo] error al cargar reclamo(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_reclamo(xid_reclamo numeric, OUT reclamos refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 17037)
-- Name: cargar_tipo(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_tipo(xid_tipo numeric, OUT tipo refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open tipo  for

            select
                id_tipo,
                des_tipo                
            from 
                tipo             
                where
                id_tipo = xid_tipo; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_tipo  error al cargar tipo sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_tipo(xid_tipo numeric, OUT tipo refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 16643)
-- Name: cargar_usuario(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_usuario(xnidusuario numeric, OUT usuarios refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
    numerror := 0;
        msjerror := ' ';
        open usuarios for

            select
                idusuario,
                rut,
                dv,
                nombres,
                apepaterno,
                apematerno,
                nomusuario,
                contrasena,
                codgenero,
                fecnacimiento,
                direccion,
                idcomuna,
                idprovincia, 
                idregion,
                codpais,
                telefono,
                celular,
                email,
                cantintentos,
                feccreacion,
                feccontrasena,
                indvigencia
            from 
                usuario
            where
                idusuario = xnidusuario;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_usuarios] error al cargar usuario(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_usuario(xnidusuario numeric, OUT usuarios refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 17077)
-- Name: eliminar_cartera(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_cartera(xid_cartera numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            cartera
        where
            id_cartera = xid_cartera;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_cartera] error al eliminar cartera(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_cartera(xid_cartera numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 215 (class 1255 OID 17168)
-- Name: eliminar_documento(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_documento(xiddocumento numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            documento
        where
            id_documento= xiddocumento;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_documento] error al eliminar documento(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_documento(xiddocumento numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 242 (class 1255 OID 17270)
-- Name: eliminar_empresa(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_empresa(xid_empresa numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            empresa
        where
            id_empresa = xid_empresa;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_documento] error al eliminar empresa(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_empresa(xid_empresa numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 17100)
-- Name: eliminar_estado(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_estado(xid_estado numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            estado
        where
            id_estado = xid_estado;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_estado] error al eliminar estado(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_estado(xid_estado numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 17141)
-- Name: eliminar_medio(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_medio(xid_medio numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            medios_respuesta
        where
            id_medio_respuesta = xid_medio;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_medio] error al eliminar medio(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_medio(xid_medio numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 16961)
-- Name: eliminar_medio_respuesta(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_medio_respuesta(xcod_medio_respuesta character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            medio_respuesta
        where
            cod_medio_respuesta = xcod_medio_respuesta;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_medio_respuesta] error al eliminar medio_respuesta(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_medio_respuesta(xcod_medio_respuesta character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 17114)
-- Name: eliminar_motivo(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_motivo(xid_motivo numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            motivo
        where
            id_motivo = xid_motivo;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_motivo] error al eliminar motivo(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_motivo(xid_motivo numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 282 (class 1255 OID 17264)
-- Name: eliminar_perfil(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_perfil(xid_perfil numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            perfil
        where
            id_perfil = xid_perfil;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_perfil] error al eliminar perfil(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_perfil(xid_perfil numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 240 (class 1255 OID 17155)
-- Name: eliminar_prioridad(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_prioridad(xid_prioridad numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            prioridad
        where
            id_prioridad = xid_prioridad;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_prioridad] error al eliminar prioridad(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_prioridad(xid_prioridad numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 17022)
-- Name: eliminar_producto(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_producto(xid_producto numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            producto
        where
            id_producto = xid_producto;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_producto] error al eliminar producto(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_producto(xid_producto numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 269 (class 1255 OID 17184)
-- Name: eliminar_reclamo(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_reclamo(xidreclamo numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            reclamo
        where
            id_reclamo = xidreclamo;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_reclamo] error al eliminar el reclamo(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_reclamo(xidreclamo numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 17038)
-- Name: eliminar_tipo(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_tipo(xid_tipo numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            tipo
        where
            id_tipo = xid_tipo;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_tipo] error al eliminar tipo(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_tipo(xid_tipo numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 213 (class 1255 OID 16644)
-- Name: eliminar_usuario(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_usuario(xidusuario numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            usuario
        where
            idusuario = xidusuario;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_usuario] error al eliminar usuario(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_usuario(xidusuario numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 286 (class 1255 OID 16889)
-- Name: login(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION login(username character varying, in_contrasena character varying, OUT out_id integer, OUT out_email character varying, OUT out_nombre character varying, OUT out_apellido_paterno character varying, OUT out_apellido_materno character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    declare _id                 integer;
    declare _email              varchar(100);
    declare _nombre       		varchar(100);
    declare _apellido_paterno	varchar(100);
	declare _apellido_materno	varchar(100);
	
    begin
        numerror := 0;
        msjerror := ' ';

        select
            idusuario,
            email,
            nombres,
            apepaterno,
            apematerno
        into
            _id,
            _email,
            _nombre,
            _apellido_paterno,
            _apellido_materno
        from
            usuario
        where
            upper(nomusuario) = upper(username) and  in_contrasena = contrasena;

        if found then
		out_id := _id;
        out_email := _email;
        out_nombre := _nombre;
		out_apellido_paterno := _apellido_paterno;
		out_apellido_materno := _apellido_materno;
        return;

        else
        numerror := '1';
        msjerror := 'Datos de inicio de sesión inválidos.';
        end if;
    end;
$$;


ALTER FUNCTION public.login(username character varying, in_contrasena character varying, OUT out_id integer, OUT out_email character varying, OUT out_nombre character varying, OUT out_apellido_paterno character varying, OUT out_apellido_materno character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 17097)
-- Name: modificar_cartera(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_cartera(xid_cartera numeric, xdes_cartera character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            cartera
        set 
            des_cartera = xdes_cartera
        where
            id_cartera = xid_cartera;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_cartera] error al modificar cartera(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_cartera(xid_cartera numeric, xdes_cartera character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16831)
-- Name: modificar_contrasena(integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_contrasena(xidusuario integer, xcontrasena character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		update 
            usuario
        set 
			contrasena = xcontrasena
        where
            idusuario = xidusuario;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[modificar_usuario] error al modificar usuario(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.modificar_contrasena(xidusuario integer, xcontrasena character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 17169)
-- Name: modificar_documento(numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_documento(xid_documento numeric, xnombre character varying, xnum_folio character varying, xnum_adherente character varying, xdescripcion character varying, xid_cartera character varying, xid_producto character varying, xcod_area character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            documento
        set 
            nombre = xnombre,
            num_folio = xnum_folio,
            num_adherente = xnum_adherente,
            descripcion = xdescripcion,
            id_cartera = xid_cartera,
            id_producto =  xid_producto,
            cod_area = xcod_area
        where
            id_documento = xid_documento;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_documento] error al modificar documento(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_documento(xid_documento numeric, xnombre character varying, xnum_folio character varying, xnum_adherente character varying, xdescripcion character varying, xid_cartera character varying, xid_producto character varying, xcod_area character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 272 (class 1255 OID 17188)
-- Name: modificar_documento(numeric, character varying, character varying, character varying, character varying, numeric, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_documento(xid_documento numeric, xnombre character varying, xnum_folio character varying, xnum_adherente character varying, xdescripcion character varying, xid_cartera numeric, xid_producto numeric, xcod_area character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            documento
        set 
            nombre = xnombre,
            num_folio = xnum_folio,
            num_adherente = xnum_adherente,
            descripcion = xdescripcion,
            id_cartera = xid_cartera,
            id_producto =  xid_producto,
            cod_area = xcod_area
        where
            id_documento = xid_documento;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_documento] error al modificar documento(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_documento(xid_documento numeric, xnombre character varying, xnum_folio character varying, xnum_adherente character varying, xdescripcion character varying, xid_cartera numeric, xid_producto numeric, xcod_area character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 285 (class 1255 OID 17276)
-- Name: modificar_empresa(numeric, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_empresa(xid_empressa numeric, xnum_adherente character varying, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            empresa
        set 
            nombre = xnombre,
            num_adherente = xnum_adherente

        where
            id_empresa = xid_empressa;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_empresa] error al modificar empresa(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_empresa(xid_empressa numeric, xnum_adherente character varying, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 17101)
-- Name: modificar_estado(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_estado(xid_estado numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            estado
        set 
            des_estado = xnombre
        where
            id_estado = xid_estado;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_estado] error al modificar estado(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_estado(xid_estado numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 17142)
-- Name: modificar_medio(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_medio(xid_medio numeric, xmedio character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            medios_respuesta
        set 
            des_medio_respuesta = xmedio
        where
            id_medio_respuesta = xid_medio;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_medio] error al modificar medio(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_medio(xid_medio numeric, xmedio character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 223 (class 1255 OID 16959)
-- Name: modificar_medio_respuesta(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_medio_respuesta(xcod_medio_respuesta character varying, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            medio_respuesta
        set 
            des_medio_respuesta = xnombre
        where
            cod_medio_respuesta = xcod_medio_respuesta;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_medio_respuesta] error al modificar medio_respuesta(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_medio_respuesta(xcod_medio_respuesta character varying, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 265 (class 1255 OID 17115)
-- Name: modificar_motivo(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_motivo(xid_motivo numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            motivo
        set 
            des_motivo = xnombre
        where
            id_motivo = xid_motivo;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_motivo] error al modificar motivo(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_motivo(xid_motivo numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 17268)
-- Name: modificar_perfil(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_perfil(xid_perfil numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            perfil
        set 
            des_perfil = xnombre
        where
            id_perfil = xid_perfil;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_perfil] error al modificar perfil(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_perfil(xid_perfil numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 17156)
-- Name: modificar_prioridad(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_prioridad(xid_prioridad numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            prioridad
        set 
            des_prioridad = xnombre
        where
            id_prioridad = xid_prioridad;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_prioridad] error al modificar prioridad(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_prioridad(xid_prioridad numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 17023)
-- Name: modificar_producto(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_producto(xid_producto numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            producto
        set 
            des_producto = xnombre
        where
            id_producto = xid_producto;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_producto] error al modificar producto(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_producto(xid_producto numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 280 (class 1255 OID 17204)
-- Name: modificar_reclamo(numeric, character varying, character varying, character varying, character varying, character varying, numeric, numeric, numeric, numeric, timestamp without time zone, character varying, character varying, character varying, numeric, character varying, character varying, character varying, character varying, numeric, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_reclamo(xid_reclamo numeric, xnum_adherente character varying, xnombre_solicitante character varying, xemail_solicitante character varying, xfono_solicitante character varying, xregion_solicitante character varying, xid_tipo numeric, xid_motivo numeric, xid_prioridad numeric, xid_cartera numeric, xfec_ingreso timestamp without time zone, xglosa character varying, xadjunto character varying, xobservaciones character varying, xid_estado numeric, xresponsable_ingreso character varying, xresponsable_actual character varying, xdias_bandeja character varying, xdias_sistema character varying, xid_medio_respuesta numeric, xfec_respuesta timestamp without time zone, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$


	begin
	
		numerror := 0;
		msjerror := '';

		update 
			reclamo
		set
		
			num_adherente = xnum_adherente,
			nombre_solicitante = xnombre_solicitante,
			email_solicitante = xemail_solicitante,
			fono_solicitante = xfono_solicitante, 
			region_solicitante = xregion_solicitante,
			id_tipo = xid_tipo,
			id_motivo = xid_motivo,
			id_prioridad = xid_prioridad,
			id_cartera = xid_cartera,
			fec_ingreso = xfec_ingreso,
			glosa = xglosa,
			adjunto = xadjunto,
			observaciones = xobservaciones,
			id_estado = xid_estado,
			responsable_ingreso = xresponsable_ingreso,
			responsable_actual = xresponsable_actual,
			dias_bandeja = xdias_bandeja,
			dias_sistema = xdias_sistema,
			id_medio_respuesta = xid_medio_respuesta,
			fec_respuesta = xfec_respuesta
		
		where
        id_reclamo = xid_reclamo;
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_reclamo] error al crear reclamo(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.modificar_reclamo(xid_reclamo numeric, xnum_adherente character varying, xnombre_solicitante character varying, xemail_solicitante character varying, xfono_solicitante character varying, xregion_solicitante character varying, xid_tipo numeric, xid_motivo numeric, xid_prioridad numeric, xid_cartera numeric, xfec_ingreso timestamp without time zone, xglosa character varying, xadjunto character varying, xobservaciones character varying, xid_estado numeric, xresponsable_ingreso character varying, xresponsable_actual character varying, xdias_bandeja character varying, xdias_sistema character varying, xid_medio_respuesta numeric, xfec_respuesta timestamp without time zone, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 17039)
-- Name: modificar_tipo(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_tipo(xid_tipo numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            tipo
        set 
            des_tipo = xnombre
        where
            id_tipo = xid_tipo;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_tipo] error al modificar tipo(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_tipo(xid_tipo numeric, xnombre character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 16893)
-- Name: modificar_usuario(numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, date, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_usuario(xidusuario numeric, xrut character varying, xdv character varying, xnombres character varying, xapepaterno character varying, xapematerno character varying, xnomusuario character varying, xcodgenero character varying, xfecnacimiento date, xtelefono character varying, xcelular character varying, xemail character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		update 
            usuario
        set 
			rut = xrut,
			dv = xdv,
			nombres = xnombres,
			apepaterno = xapepaterno,
			apematerno = xapematerno,
			nomusuario = xnomusuario,
			codgenero = xcodgenero,
			fecnacimiento = xfecnacimiento,
			telefono = xtelefono,
			celular = xcelular,
			email = xemail
        where
            idusuario = xidusuario;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[modificar_usuario] error al modificar usuario(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.modificar_usuario(xidusuario numeric, xrut character varying, xdv character varying, xnombres character varying, xapepaterno character varying, xapematerno character varying, xnomusuario character varying, xcodgenero character varying, xfecnacimiento date, xtelefono character varying, xcelular character varying, xemail character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 16783)
-- Name: subir_archivo(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subir_archivo(patharchivo character varying, nombrearchivo character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin

		numerror := 0;
		msjerror := '';

		insert into archivo_prueba
		(
			ruta,
			nombre_archivo
		)
        values
		(
			patharchivo,
			nombrearchivo
		);
		
     	return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_empresa] error al crear empresa(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.subir_archivo(patharchivo character varying, nombrearchivo character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 16846)
-- Name: validar_email(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION validar_email(email_in character varying, OUT username_out character varying, OUT flag boolean, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$     
	declare xusu_semail varchar(100);
	declare xusu_nomusuario varchar(100);
	
	begin
		numerror := 0;
		msjerror := ' ';
 
		select
			nomusuario   
		into
			xusu_nomusuario
		from
			usuario
		where
			(email) = email_in;
		IF FOUND THEN
			username_out := xusu_nomusuario;
			flag=TRUE;
		ELSE
			flag=FALSE;
			numerror := '1';
			msjerror := 'Email no encontrado.';
		end if;
	end;     
$$;


ALTER FUNCTION public.validar_email(email_in character varying, OUT username_out character varying, OUT flag boolean, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 16859)
-- Name: validar_usuario(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION validar_usuario(username_in character varying, OUT id_out integer, OUT email_out character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
	declare xusu_snomusuario varchar(100);
	declare xusu_idusuario integer;
	declare xusu_semail 	 varchar(100);

begin
	numerror :=0;
	msjerror :=' ';

	select 
		email,
		idusuario
	into
		xusu_semail,
		xusu_idusuario
	from 
		usuario
	where
		nomusuario = username_in;
	IF FOUND THEN
		email_out := xusu_semail;
		id_out := xusu_idusuario;
	ELSE
	numerror := '1';
	msjerror := 'Usuario no encontrado';
	END IF;
	end;

$$;


ALTER FUNCTION public.validar_usuario(username_in character varying, OUT id_out integer, OUT email_out character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 175 (class 1259 OID 16779)
-- Name: archivo_prueba; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE archivo_prueba (
    id integer NOT NULL,
    ruta character varying(100),
    nombre_archivo character varying(100)
);


ALTER TABLE public.archivo_prueba OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 16777)
-- Name: archivo_prueba_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE archivo_prueba_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.archivo_prueba_id_seq OWNER TO postgres;

--
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 174
-- Name: archivo_prueba_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE archivo_prueba_id_seq OWNED BY archivo_prueba.id;


--
-- TOC entry 168 (class 1259 OID 16647)
-- Name: area; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE area (
    cod_area character varying(5) NOT NULL,
    des_area character varying(200)
);


ALTER TABLE public.area OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 17081)
-- Name: cartera; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cartera (
    id_cartera integer NOT NULL,
    des_cartera character varying(200)
);


ALTER TABLE public.cartera OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 17079)
-- Name: cartera_id_cartera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cartera_id_cartera_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cartera_id_cartera_seq OWNER TO postgres;

--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 182
-- Name: cartera_id_cartera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cartera_id_cartera_seq OWNED BY cartera.id_cartera;


--
-- TOC entry 198 (class 1259 OID 17290)
-- Name: documento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documento (
    id_documento integer NOT NULL,
    nombre character varying(100),
    num_folio character varying(100),
    num_adherente character varying(100),
    descripcion character varying(1000),
    id_cartera integer,
    id_producto integer,
    cod_area character varying(100),
    ruta character varying(200),
    fec_creacion timestamp without time zone
);


ALTER TABLE public.documento OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 17288)
-- Name: documento_id_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE documento_id_documento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documento_id_documento_seq OWNER TO postgres;

--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 197
-- Name: documento_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE documento_id_documento_seq OWNED BY documento.id_documento;


--
-- TOC entry 173 (class 1259 OID 16746)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE empresa (
    num_adherente character varying(200) NOT NULL,
    nombre character varying(200),
    id_empresa integer NOT NULL
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 17116)
-- Name: empresa_id_empresa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE empresa_id_empresa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.empresa_id_empresa_seq OWNER TO postgres;

--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 188
-- Name: empresa_id_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE empresa_id_empresa_seq OWNED BY empresa.id_empresa;


--
-- TOC entry 185 (class 1259 OID 17089)
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estado (
    id_estado integer NOT NULL,
    des_estado character varying(200)
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 17087)
-- Name: estado_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE estado_id_estado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estado_id_estado_seq OWNER TO postgres;

--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 184
-- Name: estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estado_id_estado_seq OWNED BY estado.id_estado;


--
-- TOC entry 190 (class 1259 OID 17132)
-- Name: medios_respuesta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE medios_respuesta (
    id_medio_respuesta integer NOT NULL,
    des_medio_respuesta character varying(200)
);


ALTER TABLE public.medios_respuesta OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 17130)
-- Name: medios_respuesta_id_medio_respuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE medios_respuesta_id_medio_respuesta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.medios_respuesta_id_medio_respuesta_seq OWNER TO postgres;

--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 189
-- Name: medios_respuesta_id_medio_respuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE medios_respuesta_id_medio_respuesta_seq OWNED BY medios_respuesta.id_medio_respuesta;


--
-- TOC entry 187 (class 1259 OID 17105)
-- Name: motivo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE motivo (
    id_motivo integer NOT NULL,
    des_motivo character varying(200)
);


ALTER TABLE public.motivo OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 17103)
-- Name: motivo_id_motivo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE motivo_id_motivo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.motivo_id_motivo_seq OWNER TO postgres;

--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 186
-- Name: motivo_id_motivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE motivo_id_motivo_seq OWNED BY motivo.id_motivo;


--
-- TOC entry 195 (class 1259 OID 17226)
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE perfil (
    id_perfil integer NOT NULL,
    des_perfil character varying(25)
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 17224)
-- Name: perfil_id_perfil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE perfil_id_perfil_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perfil_id_perfil_seq OWNER TO postgres;

--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 194
-- Name: perfil_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE perfil_id_perfil_seq OWNED BY perfil.id_perfil;


--
-- TOC entry 196 (class 1259 OID 17250)
-- Name: perfil_usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE perfil_usuario (
    idusuario integer,
    id_perfil integer
);


ALTER TABLE public.perfil_usuario OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 17145)
-- Name: prioridad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE prioridad (
    id_prioridad integer NOT NULL,
    des_prioridad character varying(200)
);


ALTER TABLE public.prioridad OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 17143)
-- Name: prioridad_id_prioridad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE prioridad_id_prioridad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prioridad_id_prioridad_seq OWNER TO postgres;

--
-- TOC entry 3094 (class 0 OID 0)
-- Dependencies: 191
-- Name: prioridad_id_prioridad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE prioridad_id_prioridad_seq OWNED BY prioridad.id_prioridad;


--
-- TOC entry 179 (class 1259 OID 17009)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE producto (
    id_producto integer NOT NULL,
    des_producto character varying(200)
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 17007)
-- Name: producto_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE producto_id_producto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.producto_id_producto_seq OWNER TO postgres;

--
-- TOC entry 3095 (class 0 OID 0)
-- Dependencies: 178
-- Name: producto_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE producto_id_producto_seq OWNED BY producto.id_producto;


--
-- TOC entry 176 (class 1259 OID 16835)
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincia (
    pro_nidprovincia numeric(15,5) NOT NULL,
    pro_snombre character varying(23),
    pro_nidregion numeric(15,5)
);


ALTER TABLE public.provincia OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 17170)
-- Name: reclamo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reclamo (
    id_reclamo integer NOT NULL,
    num_adherente character varying(100),
    nombre_solicitante character varying(100),
    email_solicitante character varying(100),
    fono_solicitante character varying(1000),
    region_solicitante character varying(100),
    id_tipo numeric,
    id_motivo numeric,
    id_prioridad numeric,
    id_cartera numeric,
    fec_ingreso timestamp without time zone,
    glosa character varying(2000),
    adjunto character varying(100),
    observaciones character varying(1000),
    responsable_ingreso character varying(100),
    responsable_actual character varying(100),
    id_medio_respuesta numeric,
    fec_respuesta timestamp without time zone,
    id_estado numeric,
    dias_bandeja character varying(50),
    dias_sistema character varying(50)
);


ALTER TABLE public.reclamo OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 16839)
-- Name: region; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE region (
    cod_region character varying NOT NULL,
    des_region character varying
);


ALTER TABLE public.region OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 16682)
-- Name: seq_documento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_documento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_documento OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 16695)
-- Name: seq_reclamo; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_reclamo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_reclamo OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 16656)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 17050)
-- Name: tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo (
    id_tipo integer NOT NULL,
    des_tipo character varying(200)
);


ALTER TABLE public.tipo OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 17048)
-- Name: tipo_id_tipo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_id_tipo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_id_tipo_seq OWNER TO postgres;

--
-- TOC entry 3096 (class 0 OID 0)
-- Dependencies: 180
-- Name: tipo_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_id_tipo_seq OWNED BY tipo.id_tipo;


--
-- TOC entry 170 (class 1259 OID 16658)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    idusuario integer NOT NULL,
    rut character varying(8),
    dv character varying(1),
    nombres character varying(100),
    apepaterno character varying(100),
    apematerno character varying(100),
    nomusuario character varying(100),
    contrasena character varying(100),
    codgenero character varying(1),
    fecnacimiento date,
    direccion character varying(100),
    idcomuna integer,
    idprovincia integer,
    idregion integer,
    codpais character varying(10),
    telefono character varying(100),
    celular character varying(100),
    email character varying(100),
    cantintentos integer,
    feccreacion timestamp without time zone,
    feccontrasena timestamp without time zone,
    indvigencia character varying(1)
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 2901 (class 2604 OID 16782)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY archivo_prueba ALTER COLUMN id SET DEFAULT nextval('archivo_prueba_id_seq'::regclass);


--
-- TOC entry 2904 (class 2604 OID 17084)
-- Name: id_cartera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cartera ALTER COLUMN id_cartera SET DEFAULT nextval('cartera_id_cartera_seq'::regclass);


--
-- TOC entry 2910 (class 2604 OID 17293)
-- Name: id_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento ALTER COLUMN id_documento SET DEFAULT nextval('documento_id_documento_seq'::regclass);


--
-- TOC entry 2900 (class 2604 OID 17118)
-- Name: id_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empresa ALTER COLUMN id_empresa SET DEFAULT nextval('empresa_id_empresa_seq'::regclass);


--
-- TOC entry 2905 (class 2604 OID 17092)
-- Name: id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado ALTER COLUMN id_estado SET DEFAULT nextval('estado_id_estado_seq'::regclass);


--
-- TOC entry 2907 (class 2604 OID 17135)
-- Name: id_medio_respuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY medios_respuesta ALTER COLUMN id_medio_respuesta SET DEFAULT nextval('medios_respuesta_id_medio_respuesta_seq'::regclass);


--
-- TOC entry 2906 (class 2604 OID 17108)
-- Name: id_motivo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY motivo ALTER COLUMN id_motivo SET DEFAULT nextval('motivo_id_motivo_seq'::regclass);


--
-- TOC entry 2909 (class 2604 OID 17229)
-- Name: id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfil ALTER COLUMN id_perfil SET DEFAULT nextval('perfil_id_perfil_seq'::regclass);


--
-- TOC entry 2908 (class 2604 OID 17148)
-- Name: id_prioridad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prioridad ALTER COLUMN id_prioridad SET DEFAULT nextval('prioridad_id_prioridad_seq'::regclass);


--
-- TOC entry 2902 (class 2604 OID 17012)
-- Name: id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY producto ALTER COLUMN id_producto SET DEFAULT nextval('producto_id_producto_seq'::regclass);


--
-- TOC entry 2903 (class 2604 OID 17053)
-- Name: id_tipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo ALTER COLUMN id_tipo SET DEFAULT nextval('tipo_id_tipo_seq'::regclass);


--
-- TOC entry 3054 (class 0 OID 16779)
-- Dependencies: 175
-- Data for Name: archivo_prueba; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (1, 'c:/archivo/', 'documento.xls');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (2, 'c:/archivo/', 'documento.xls');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (3, 'C:\archivos\Nuevo Microsoft Excel Worksheet.xls', 'Nuevo Microsoft Excel Worksheet.xls');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (4, 'C:\archivos', 'Nuevo documento de texto.txt');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (5, 'C:\archivos', 'Nuevo Microsoft Excel Worksheet.xls');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (6, 'C:\archivos', 'Nuevo Microsoft Word Document.doc');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (1227, 'asd', 'asd');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (1228, 'asd', 'asd');


--
-- TOC entry 3097 (class 0 OID 0)
-- Dependencies: 174
-- Name: archivo_prueba_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('archivo_prueba_id_seq', 1228, true);


--
-- TOC entry 3047 (class 0 OID 16647)
-- Dependencies: 168
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO area (cod_area, des_area) VALUES ('ADMIN', 'Administracion y Finanzas');
INSERT INTO area (cod_area, des_area) VALUES ('ILD', 'I + L + D');
INSERT INTO area (cod_area, des_area) VALUES ('SSOMA', 'SSOMA');
INSERT INTO area (cod_area, des_area) VALUES ('DESAR', 'Desarrollo');
INSERT INTO area (cod_area, des_area) VALUES ('PROCE', 'Procesos');
INSERT INTO area (cod_area, des_area) VALUES ('SALUD', 'Salud');
INSERT INTO area (cod_area, des_area) VALUES ('SEGUR', 'Seguro');
INSERT INTO area (cod_area, des_area) VALUES ('LEGAL', 'Asuntos Legales');


--
-- TOC entry 3062 (class 0 OID 17081)
-- Dependencies: 183
-- Data for Name: cartera; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cartera (id_cartera, des_cartera) VALUES (1, 'Cartera Transporte Publico');
INSERT INTO cartera (id_cartera, des_cartera) VALUES (2, 'Cartera Telecomunicaciones');
INSERT INTO cartera (id_cartera, des_cartera) VALUES (3, 'Cartera Transporte');
INSERT INTO cartera (id_cartera, des_cartera) VALUES (4, 'Cartera Transversal');
INSERT INTO cartera (id_cartera, des_cartera) VALUES (5, 'Cartera Transporte 2');
INSERT INTO cartera (id_cartera, des_cartera) VALUES (10, 'Cartera2');
INSERT INTO cartera (id_cartera, des_cartera) VALUES (11, 'plop');


--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 182
-- Name: cartera_id_cartera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cartera_id_cartera_seq', 11, true);


--
-- TOC entry 3077 (class 0 OID 17290)
-- Dependencies: 198
-- Data for Name: documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion) VALUES (54, 'NOMBRE', '123', '12', 'una descripcion', 10, 8, 'LEGAL', NULL, '2015-02-18 07:49:40.75591');
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion) VALUES (55, 'Una cartera random', '1236', '4616', 'Es mas de ochomil!', 4, 6, 'LEGAL', NULL, '2015-02-18 07:50:27.188252');
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion) VALUES (51, 'Hola que tal', '123', '34', 'para probar', 3, 6, 'ILD', NULL, '2015-02-16 07:27:57.548711');


--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 197
-- Name: documento_id_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('documento_id_documento_seq', 1, false);


--
-- TOC entry 3052 (class 0 OID 16746)
-- Dependencies: 173
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('63', 'PUERTOS Y LOGISTICA S.A.', 1);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('928', 'PRAXAIR CHILE LTDA.', 2);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('6903', 'SOC.DE TRANSPORTES SAN PABLO DE CURICO L', 4);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('12823', 'SOC.TRANSPORTES NORTINOS LTDA.', 5);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('13334', 'TELEDUCTOS S.A.', 6);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('15681', 'TRANSPORTES TAMARUGAL LTDA.', 7);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('17480', 'CLARO SERVICIOS EMPRESARIALES S.A.', 8);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('17867', 'KUEHNE Y NAGEL DE CHILE TRANSPORTES LTDA', 9);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('20100', 'TRANSPORTES DE COMBUSTIBLES CHILE LTDA.', 10);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('20367', 'GALLYAS TELECOM S.A.', 11);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('21052', 'EMPRESA DE TRANSPORTE FERROVIARIO S.A.', 12);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('21802', 'QUEILEN BUS LTDA.', 13);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('23265', 'EMPRESA DE TRANSPORTE DE PASAJEROS METRO S.A.', 14);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('25112', 'TRANSPORTES BELLO E HIJOS LTDA.', 15);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('26082', 'TRANSPORTES CARRASCO SILVA HNOS.LTDA.', 16);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('28998', 'TRANSELEC S.A.', 17);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('28999', 'COLBUN S.A.', 18);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('32166', 'TRANSPORTES INTERNACIONAL EXPRESO LTDA.', 19);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('32299', 'SERVICIOS DE TRANSPORTES INTEGRADOS LTDA', 20);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('33960', 'FERROCARRIL DEL PACIFICO S.A.', 21);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('36209', 'EXTEND COMUNICACIONES S.A..', 22);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('36483', 'SOC.INVERSIONES BIO-REC LTDA.', 23);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('37546', 'TRANSPORTES FERROPAK LTDA.', 24);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('38104', 'CHILEXPRESS S.A.', 25);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('38281', 'ENERGIA AUSTRAL SpA', 26);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('38417', 'GTD TELESAT S.A.', 27);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('39158', 'SOC.MARITIMA Y COMERCIAL SOMARCO LTDA.', 28);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('39173', 'TRANSPORTES LASAMA LTDA.', 29);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('39918', 'TRANSPORTES SIMUNOVIC LTDA.', 30);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('40660', 'STORBOX S.A.', 31);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('40814', 'AVANT SERVICIOS INTEGRALES S.A.', 32);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('41175', 'EMPRESA NACIONAL DE ELECTRICIDAD S.A.', 33);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('41197', 'EMPRESA DE TRANSPORTES RURALES LTDA.', 34);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('41537', 'SERVICIOS Y TRANSPORTES SETRACOM LIMITAD', 35);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('41834', 'TRANSPORTES COMETA S.A.', 36);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('41835', 'PULLMAN CARGO S.A.', 37);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('41943', 'SOC.NACIONAL DE OLEODUCTOS S.A.', 38);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('42078', 'K.D.M.S.A', 39);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('42321', 'ELECNOR CHILE S.A.', 40);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('42745', 'GASATACAMA CHILE S.A.', 41);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('43120', 'BESALCO MAQUINARIAS S.A.', 42);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('44089', 'EMPRESA ELECTRICA INDUSTRIAL S.A.', 43);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('44910', 'TRANSPORTES Y DISTRIBUCIONES LTDA.', 44);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('48109', 'TRANSPORTES MOLINA LTDA.', 45);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('48965', 'ALAS DEL NORTE S.A.', 46);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('49513', 'TRANSAP S.A.', 47);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('49631', 'TRANSPORTES CCU LTDA.', 48);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('50078', 'RUIZ Y CARREЅO S.A.', 49);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('50462', 'AGENCIA DE ADUANA HERNAN TELLERIA R Y CI', 50);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('50771', 'LINSA S.A.', 51);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('51207', 'COASIN CHILE S.A.', 52);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('51360', 'DUARTE MARTINEZ JUAN IGNACIO', 53);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('51774', 'TRANSPORTES HORMIGON DOS LTDA.', 54);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('51776', 'TRANSPORTES HORMIGON TRES LTDA.', 55);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('52015', 'KIPREOS INGENIEROS S.A.', 56);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('52884', 'GTD INTERNET S.A.', 57);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('55158', 'MAQUINARIAS Y EQUIPOS MAQSA S.A.', 58);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('55245', 'TRANSPORTE LOS CONDORES LTDA.', 59);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('55348', 'INTEREXPORT TELECOMUNIC.Y SERVICIOS SA', 60);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('55852', 'EMPRESAS LIPIGAS S.A.', 61);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('57216', 'TRANSPORTES EJECUTIVOS LIMITADA', 62);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('58898', 'SOC.DE TRANSPORTES INTERTECNO VALORES S.A.', 63);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('58939', 'CLARO INFRAESTRUCTURA 171 S.A.', 64);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('59640', 'SOC.INMOBILIARIA E INVERSIONES SANTA CRI', 65);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('59702', 'RENTA EQUIPOS BESALCO LTDA.', 66);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('59873', 'ARRENDAMIENTO EQUIPOS BESALCO LTDA.', 67);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('60851', 'SAN FELIPE MAQUINARIA S.A.', 68);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('61414', 'SOC.COMERCIAL Y DE INVERSIONES NUEVOS TI', 69);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('61943', 'EMPRESA DE LOS FERROCARRILES DEL ESTADO', 70);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('62036', 'GTD GRUPO TELEDUCTOS S.A.', 71);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('62037', 'GTD LARGA DISTANCIA S.A.', 72);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('62144', 'INGENIERIA Y MONTAJES FERROVIAL S.A.', 73);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('62933', 'NORGENER S.A.', 74);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('63160', 'INVERSIONES ALSACIA S.A.', 75);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('64129', 'SOC. NACIONAL MARITIMA S.A.', 76);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('64189', 'INTERWINS S.A.', 77);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('65556', 'CONSORCIO RDTC S.A.', 78);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('66141', 'AGGREKO CHILE LTDA.', 79);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('66261', 'GAS LICUADO MOTOR LTDA.', 80);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('66451', 'INPROLEC S.A.', 81);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('66795', 'SERV.LOGISTICOS DE ALMAC.Y DIST.EN FRIO', 82);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('67298', 'COMERCIAL NUEVO MILENIO S.A.', 83);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('67306', 'CIA. DE TRANSPORTES VENTROSA LTDA.', 84);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('67417', 'CENTRALES HIDROELECTRICAS DE AYSEN S.A.', 85);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('67483', 'TRANSPORTES BOLIVAR LTDA.', 86);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('67523', 'TRANSPORTES BENCINA Y CIA LTDA', 87);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('67926', 'SOCIEDAD DE TRANSPORTES TRANSVIAL LTDA.', 88);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('68037', 'INST. DE CAPACITACION DEL TRANSPORTE LTD', 89);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('68563', 'TRANSPORTES M ROJAS LTDA.', 90);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('69126', 'SERVITRANS S.A.', 91);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('69646', 'SOC.DE TRANSPORTES ATACAMA VIP Y CIA. LT', 92);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('69814', 'SOC.ANALISIS MINEROS LTDA.', 93);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('69918', 'ENEL LATIN AMERICA CHILE LTDA', 94);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('70604', 'HIDROCHILE S.A.', 95);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('71074', 'BUSES METROPOLITANA S.A.', 96);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('71351', 'MOBILINK S.A.', 97);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('71393', 'TRANSVID S.A.', 98);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('71419', 'INMOBILIARIA E INV.MEJORES TIEMPOS LTDA.', 99);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('71944', 'R Y R ASEOS INDUSTRIALES LTDA.', 100);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('72671', 'SERVICIO MANTENCION Y REPARACION MAFFORTT LTDA.', 101);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('72895', 'URETA ARQUEROS LTDA.', 102);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('73111', 'IMPORTADORA Y COMERCIALIZADORA MARES DEL SUR LTDA.', 103);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('73579', 'TRANSPORTES LILA MAR LTDA.', 104);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('73928', 'TNT EXPRESS WORLWIDE CHILE CARGA LTDA.', 105);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('74959', 'EXPRESS DE SANTIAGO UNO S.A.', 106);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('74996', 'TRANSPORTES STA BEATRIZ LTDA', 107);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('75043', 'CONTACTO SA', 108);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('78059', 'BUSES VULE S A ', 110);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('78114', 'ITECH SOLUCIONES  Y SERVICIOS EN TECNOLOGIAS DE LA INFORMACION S.A', 111);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('78161', 'EIT LOGISTICA SA', 112);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('78363', 'LOGISTICA Y BODEGAJES SCHIAPPASSE LIMITADA ', 113);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('78366', 'TRANSPORTES JOSE SCHIAPPACASSE MADARIAGA LTDA ', 114);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('78369', 'SCHIAPPACASSE INVESTMENT SOCIEDAD ANONIMA ', 115);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('78475', 'A J INGENIEROS S A ', 116);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('75570', '360 MOBILE SA', 109);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('78478', 'CME CONSTRUCCION Y MANTENCION ELECTROMECANICA CHILE SPA ', 118);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79192', 'CATALAN INOSTROZA CARLOS SANDRO', 119);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79221', 'ZUбIGA JADUR MARIO', 120);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79244', 'PEREZ PENA JAIME ANTONIO ', 121);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79262', 'GONZALEZ AGUILERA JORGE', 122);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79264', 'OLIVEROS CID JOSE', 123);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79265', 'SAEZ ALVAREZ JOSE', 124);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79266', 'GONZALEZ ORELLANA ALEJANDRO', 125);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79267', 'MERINO FIGUEROA LUIS', 126);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79268', 'SOTO NEGRON EDUARDO', 127);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79270', 'ZUHAYLE ORELLANA ANNI FATIMA', 128);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79271', 'PASTENE VILLA LUIS', 129);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79272', 'BALLADARES AMAYA RENE', 130);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79273', 'HIDALGO VERA CARLOS ENZO ', 131);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79275', 'FUENTES VARGAS RAFAEL ', 132);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79276', 'ESCOLONA REVELO JORGE ERNESTO', 133);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79284', 'SOC CERNA GONZALEZ LIMITADA ', 134);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79286', 'ASOC GREMIAL DE TRANSPORTE DE PASAJEROS BUSES PAINE', 135);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79287', 'DUARTE MARTINEZ JAIME JORGE ', 136);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79289', 'SALINAS JELVEZ LUZ INES ', 137);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79290', 'SUCECION BENITO MUNOZ ALVAREZ ', 138);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79291', 'SALINAS NAVARRO MIGUEL DANILO ', 139);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79292', 'SANCHEZ SANCHEZ CARLOS ENRIQUE ', 140);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79293', 'MARSA SILVA CARLOS HUGO ', 141);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79294', 'MANZOR FOURNET NELSON RAMIRO ', 142);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79297', 'MANZOR FOURNET PATRICIO HUMBERTO ', 143);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79299', 'MANZOR SOTO CARLOS RAMIRO ', 144);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79301', 'SOC DE TRANSPORTES GAMA LTDA ', 145);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79316', 'EMPRESA DE TRANSPORTES TUR MAIPO S.A.', 146);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79317', 'TRANSPORTES GUAYACAN LTDA.', 147);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79320', 'SOCIEDAD TRANSPORTE MAIPO LTDA.', 148);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79323', 'ANDRADE HERNANDEZ SERGIO EDUARDO ', 149);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79324', 'DE LA PAZ ACEVEDO CLAUDIO LUIS ', 150);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79326', 'VALDIVIA COFRE HORACIO HERNAN ', 151);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79327', 'SUSAETA MANRIQUEZ LUIS JOAQUIN ', 152);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79328', 'COLLIO VEJAR JORGE EDUARDO', 153);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79329', 'VARGAS ANDRADE JULIA DE LAS MERCEDES ', 154);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79459', 'RIQUELME CATALAN JOSE MIGUEL ', 155);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79463', 'ALVAREZ DELGADO RODRIGO IGNACIO', 156);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79465', 'EMPRESA DE RESIDUOS RESITER S.A.', 157);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79502', 'IBARRA VERA JUAN ESTEBAN ', 158);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79525', 'BARROS FUENZALIDA OSCAR IGNACIO', 159);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79629', 'SOCIEDAD DE TRANSPORTE ECOEX LTDA.', 160);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79716', 'SIRTECOM CHILE LIMITADA ', 161);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('79856', 'CASTRO SILVA FRANCISCO JAVIER ', 162);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('80064', 'NARVAEZ ROJAS LAZARO ANANIAS', 163);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('80781', 'TML S.A. ', 164);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('80799', 'CONTACTO DISTRIBUCION S.A. ', 165);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('80805', 'TRANSPORTES LAS CANTERAS S.A. ', 166);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('80854', 'KDM ENERGIA Y SERVICIOS S.A.', 167);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('80855', 'IMAGINA S.A.', 168);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81301', 'TRANSPORTES TURISTICOS SANTIAGO', 169);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81302', 'TRANSPORTES FICHTUR LTDA.', 170);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81446', 'TRANSPORTES Y TURISMO F Y F LTDA.', 171);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81447', 'EXPORTADORA IMPORT. Y COMERCIALIZADORA FARIAS Y BELTRAN LTDA.', 172);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81448', 'LOGIC GROUP S.A.', 173);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81743', 'CANTARES DE CHILE S.A.', 174);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81744', 'MARTINEZ LUCERO IVAN CARLOS', 175);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81745', 'NAVARRO GONZALEZ ESTER', 176);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81746', 'SOCIEDAD DE TRANSPORTES ORTIZ HIJO LIMITADA', 177);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81747', 'ALVAREZ GODOY RAUL FELICIANO', 178);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81748', 'QUINTEROS SARNO LIDIA MATILDE', 179);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81750', 'ASTETE GELDRES JOSEFINA DEL CARMEN', 180);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81753', 'MANZOR FOURNET CARLOS GUILLERMO', 181);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81756', 'SANCHEZ ORELLANA JOSE JORGE', 182);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('81758', 'ANDRADE ANDRADE ALFREDO FERNANDO', 183);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('82305', 'SERVICIOS DE TRANSPORTES  DE PERSONAS SANTIAGO S.A.', 184);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('83352', 'SOCIEDAD TRANSPORTES PAINE 3 S.A.', 185);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('83579', 'ESPINDOLA SANCHEZ MANUEL OCTAVIO', 186);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('83580', 'SOC COMERCIAL E INMOBILIARIA PULMAN DEL SUR LIMITADA', 187);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('83584', 'SERVICIOS DE MENSAJERIA S.A.', 188);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('83691', 'INVERSIONES ENCINA S.A', 189);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('86530', 'INSTALACIONES Y SERVICIOS INERCOM LTDA', 190);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('87390', 'VEHICULOS DE RENTA LTDA.', 191);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('87493', 'PEZOA PAVEZ GABRIELA DEL CARMEN', 192);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('87494', 'MORALES ORELLANA MARIA ANGELICA', 193);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('87496', 'POZO MORA EUGENIO DEL CARMEN', 194);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('87676', 'FLORES IBARRA HECTOR MANUEL ', 195);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('87796', 'ROCMIN SERVICIOS MNEROS SPA', 196);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88943', 'CABRERA PEбA HERIBERTO S.', 197);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88944', 'ARRIAGADA GUTIERREZ  MARIO RAMON', 198);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88947', 'CABRERA PEбA NORA DEL C.', 199);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88948', 'CARDENAS CONTRERAS LUIS S.', 200);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88949', 'CARDENAS JARA ERNESTO E.', 201);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88950', 'CAVIERES ROMERO RAUL O.', 202);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88951', 'CERDA FUENTRES JOSE MIGUEL', 203);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88952', 'FIGUEROA AYALA ALONSO E.', 204);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88953', 'FIGUEROA AYALA CARLOS ', 205);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88954', 'GUERRERO PEбA LUIS A.', 206);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88955', 'LAMA GENNARI ENRIQUE A.', 207);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88956', 'MARTICORENA FLORES HECTOR RENE', 208);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88957', 'MARTICORENA MORENO HECTOR', 209);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88958', 'MORALES ABARCA FERNANDO', 210);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88959', 'ORELLANA SANCHEZ ENRIQUE', 211);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88960', 'POBLRTE RAMIREZ MARIA', 212);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88962', 'TRANSPORTES FIGUEROA E HUJO LTDA', 213);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88963', 'VARGAS ESPINOZA FRANCISCO', 214);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88964', 'VARGAS GOMEZ HERIBERTO', 215);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88965', 'VARGAS MIRANDA PEDRO', 216);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88967', 'LIZAMA MORALES GUSTAVO', 217);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88968', 'CABRERA RODRIGUEZ ALVARO', 218);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88969', 'CABRERA ESTAI ALFREDO', 219);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88970', 'CERDA FUENTRES JOSE MIGUEL', 220);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88972', 'JARA PARDO RAUL E.', 221);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88976', 'CEA PINO ANICIO', 222);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('88977', 'CARO VELOSO LUIS S.', 223);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('89055', 'CLAUDIO C. AVENDAбO VILLABLANCA', 224);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('89056', 'LUIS A. CARDENAS JARA', 225);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('89057', 'JOSE R. GODOY RIVAS', 226);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('89059', 'GUILLERMO MUбOZ ESCOBAR', 227);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('89060', 'DOROTEO HTO. SANCHEZ GARCIA', 228);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('89466', 'RECUPERADORA DE VEHICULOS S.A.', 229);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('89468', 'SOCIEDAD CONCERSIONARIA AUTOPISTAS DE ANTOFAGASTA S.A.', 230);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('91240', 'VALDIVIA COFRE ADOLFO FELIPE', 231);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('91992', 'ICT SERVICIOS INFORMATICOS LIMITADA', 232);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('91993', 'INVERSIONES SERVICIOS Y TRANSPORTE MARIA ELENA S.A', 233);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('92517', 'TRANSPORTES FEPASA LTDA', 234);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('93090', 'KDM INDUSTRIAL S.A.', 235);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('94952', 'TRANSPORTES MORENO Y SILVA LTDA', 236);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('96572', 'UNISONO SOLUCIONES DE NEGOCIO CHILE S.A', 237);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('96985', 'TRANSPORTES SAN JUAN LTDA', 238);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('96988', 'TRANSPORTES EL TUNEL LTDA', 239);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('98460', 'SOCIEDAD DE SERVICIOS CONTABLES Y ASESORIAS VEGA PEбA Y CIA LTDA', 240);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('98461', 'SOC ADMINISTRADORA SANTA JAVIERA Y CIA LTDA', 241);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('98814', 'GTS TRANSPORTES LTDA', 242);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('99625', 'ELS SA', 243);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('99626', 'SOCIEDAD DE SERVICIOS PERS PARA EL AREA ELECTRICA LIMITADA', 244);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('99658', 'EMPRESA ELECTRICA ANGAMOS SA', 245);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('99870', 'MER INFRAESTRUCTURA CHILE SA', 246);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('101321', 'TECNASIC EQUIPOS S A', 247);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('101804', 'FEDERAL EXPRESS AGENCIA EN CHILE', 248);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('102179', 'COBRA CHILE SERVICIOS SOCIEDAD ANONIMA', 249);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('103662', 'TRANS COMUNICACIONES LTDA', 250);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('104777', 'SOCIEDAD DE TRANSPORTES LOS CORSARIOS LIMITADA', 251);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('104888', 'BUSES CIKTUR LIMITADA', 252);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('104890', 'TRANSPORTES GASPAR CIKUTOVIC GODOY EIRL', 253);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('104892', 'TRANSPORTES GASPAR CIKUTOVIC MADARIAGA EIRL', 254);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('108976', 'CELLSTAR CHILE SA', 255);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('109193', 'CELLSTAR SERVICIOS EMPRESARIALES LTDA', 256);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('111382', 'INSTALACIONES TELINTCAB LIMITADA', 257);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('111958', 'INGENIERIA Y CONSTRUCCION URBELEC ', 258);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('111997', 'INGENIERIA Y CONSTRUCCION ELECTRIC', 259);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('112167', 'SOCIEDAD COMERCIAL SINELEC LTDA', 260);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('112832', 'TRANSPORTE SANTA ELISA SPA', 261);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('113055', 'ATC SITIOS DE CHILE S A', 262);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('113071', 'HMV CHILE', 263);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('114692', 'ADMINISTRACION Y TRANSPORTES AGURTO LIMITADA', 264);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('114693', 'AGURTO LOGISTICA Y DISTRIBUCION LIMITADA', 265);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('114694', 'ALD LOGISTICA LIMITADA', 266);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('114695', 'TRANSPORTES AGURTO Y COMPAбIA LIMITADA', 267);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('121768', 'FLOTA VERSCHAE S. A.', 268);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('121770', 'TRANSPORTES VERSCHAE S. A.', 269);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('122016', 'EMPRESA ELECTRICA PUENTE ALTO LTDA', 270);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('122515', 'DHL SUPPLY CHAIN CHILE SA ', 271);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('125631', 'TRANSPORTES ANFER SA', 272);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('126450', 'ZAMBON BERLAGOSKY MARCOS SIMON', 273);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('126461', 'COMPAбIA JAC TRANSPORTES LIMITADA', 274);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('126612', 'AGUAS MAGALLANES SA', 275);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('126614', 'AGUAS ARAUCANIA SA', 277);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('127017', 'SOCIEDAD DE SERVICIOS GENERALES LIMITADA', 278);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('128522', 'TRANSPORTES DELFOS LTDA', 279);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('133684', 'BESALCO ENERGIA RENOVABLE SA', 280);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('134435', 'SANTA MARTA COURIER AND CARGO SOCIEDAD ANONIMA', 281);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('134436', 'CONDOR BUS LIMITADA ', 282);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('135572', 'STARBUS SOCIEDAD ANгNIMA', 283);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('135614', 'BRINKS CHILE S A', 284);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('135867', 'ASEO URBANO Y AREAS VERDES TRANSFICH LIMITADA', 285);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('137714', 'INGENIERIA V Y S LTDA', 286);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('137718', 'V Y S INGENIERIA Y CONSTRUCCION LTDA', 287);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('137930', 'JAM SEGURIDAD LTDA', 288);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('137959', 'AGENCIA DE ADUANA PATRICIO LARRAбAGA Y CIA LTDA', 289);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('138582', 'SERVICIOS NILAHUE LIMITADA', 290);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('138606', 'ECO SWEEP CONCESIONES Y SERVICIOS LIMITADA', 291);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('140464', 'TRANSPORTE Y LOGISTICA NORTE LIMITADA', 292);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('142730', 'NEWTRANS LOGISTIC CHILE SA', 293);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('142961', 'TRANSPORTE LIGUAY NORTE LIMITADA', 294);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('142964', 'SOCIEDAD DE TRANSPORTE LIGUAY SUR LIMITADA', 295);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('142966', 'UNITED PARCEL SERVICE DE CHILE LTDA', 296);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('142967', 'UPS SCS TRANSPORTES CHILE LTDA', 297);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('143196', 'GTD MANQUEHUE SOCIEDAD ANONIMA', 298);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('143246', 'EMPRESA DE TRANSPORTES Y SERVICIOS TRANSCARGO LIMITADA', 299);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('144574', 'ALCATEL LUCENT DE CHILE S A', 300);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('145378', 'SERVICIOS DE TELECOMUNICACIONES NETRIUM LIMITADA', 301);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('145891', 'SOCIEDAD DE SEGURIDAD INTEGRAL JORGE CIFUENTES ALMAZABAL LIMITADA', 302);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('150318', 'TRANSPORTES VERSCHAE DOS S A', 303);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('154122', 'HIPERTRANS ANDINA SA', 304);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('154367', 'SOTRASER  S.A.', 305);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('154369', 'SOTRASER LOGISTICA LTDA', 306);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('155068', 'SERVICIOS GENERALES MAPER LTDA.', 307);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('156050', 'JORQUERA TRANSPORTES S A ', 308);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('157380', 'TRANSPORTES SANTA ANA LIMITADA', 309);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('158429', 'SCP SOTRASER SA', 310);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('158688', 'TRANSPORTES HUGO CIKUTOVIC MADARIAGA E I R L', 311);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('158689', 'TRANSPORTES DUSAN CIKUTOVIC MADARIAGA E I R L', 312);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('158690', 'TRANSPORTES DINKA CIKUTOVIC MADARIAGA E I R L', 313);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('158691', 'BUSES GASPAR E CIKUTOVIC MADARIAGA E I R L', 314);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('158692', 'BUSES GASPAR H CIKUTOVIC GODOY E I R L', 315);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('159455', 'ASESORЭAS Y SERVICIOS MEGADYNE SOCIEDAD ANONIMA', 316);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('159456', 'OMEGA TELECOM SOCIEDAD ANONIMA', 317);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('159457', 'INVERSIONES OMEGA LIMITADA', 318);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('159867', 'ALMEYDA SOLAR SPA', 319);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('159868', 'TRANSPORTES MARTINEZ RASSE Y COMPAбЭA LIMITADA', 320);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('165177', 'EMPRESA TRANSPORTE MENA Y OVALLE LTDA', 321);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('165693', 'LOPEZ GUERRERO JORGE', 322);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('165694', 'LOPEZ HERRERA JOSE MARIO', 323);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('165696', 'LOPEZ HERRERA BERNABE DEL CARMEN', 324);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('168825', 'JOSE MEZA OVIEDO', 325);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('168847', 'TOLORZA TOBAR DANIEL PATRICIO', 326);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('plop', 'plop', 327);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('numAdherente', 'nombreExp', 328);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('161231', 'AGENCIA DE ADUANA ', 330);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('123', 'kobold', 331);
INSERT INTO empresa (num_adherente, nombre, id_empresa) VALUES ('126613', 'AGUAS DEL ALTIPLANO SA', 276);


--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 188
-- Name: empresa_id_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('empresa_id_empresa_seq', 338, true);


--
-- TOC entry 3064 (class 0 OID 17089)
-- Dependencies: 185
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO estado (id_estado, des_estado) VALUES (1, 'Pendientes');
INSERT INTO estado (id_estado, des_estado) VALUES (7, 'Holito');


--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 184
-- Name: estado_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estado_id_estado_seq', 7, true);


--
-- TOC entry 3069 (class 0 OID 17132)
-- Dependencies: 190
-- Data for Name: medios_respuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO medios_respuesta (id_medio_respuesta, des_medio_respuesta) VALUES (2, 'email');
INSERT INTO medios_respuesta (id_medio_respuesta, des_medio_respuesta) VALUES (5, 'web');


--
-- TOC entry 3102 (class 0 OID 0)
-- Dependencies: 189
-- Name: medios_respuesta_id_medio_respuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('medios_respuesta_id_medio_respuesta_seq', 5, true);


--
-- TOC entry 3066 (class 0 OID 17105)
-- Dependencies: 187
-- Data for Name: motivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO motivo (id_motivo, des_motivo) VALUES (2, 'Motivo 2');
INSERT INTO motivo (id_motivo, des_motivo) VALUES (1, 'Motivo 99');
INSERT INTO motivo (id_motivo, des_motivo) VALUES (8, 'Motivo 23');


--
-- TOC entry 3103 (class 0 OID 0)
-- Dependencies: 186
-- Name: motivo_id_motivo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('motivo_id_motivo_seq', 8, true);


--
-- TOC entry 3074 (class 0 OID 17226)
-- Dependencies: 195
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO perfil (id_perfil, des_perfil) VALUES (1, 'admin');
INSERT INTO perfil (id_perfil, des_perfil) VALUES (2, 'usuario');
INSERT INTO perfil (id_perfil, des_perfil) VALUES (6, 'Hola');
INSERT INTO perfil (id_perfil, des_perfil) VALUES (7, 'lalal');


--
-- TOC entry 3104 (class 0 OID 0)
-- Dependencies: 194
-- Name: perfil_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('perfil_id_perfil_seq', 7, true);


--
-- TOC entry 3075 (class 0 OID 17250)
-- Dependencies: 196
-- Data for Name: perfil_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (13, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (12, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (6, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (1, 1);


--
-- TOC entry 3071 (class 0 OID 17145)
-- Dependencies: 192
-- Data for Name: prioridad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO prioridad (id_prioridad, des_prioridad) VALUES (1, 'Baja');
INSERT INTO prioridad (id_prioridad, des_prioridad) VALUES (2, 'Media');
INSERT INTO prioridad (id_prioridad, des_prioridad) VALUES (10, 'Alta');


--
-- TOC entry 3105 (class 0 OID 0)
-- Dependencies: 191
-- Name: prioridad_id_prioridad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('prioridad_id_prioridad_seq', 10, true);


--
-- TOC entry 3058 (class 0 OID 17009)
-- Dependencies: 179
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO producto (id_producto, des_producto) VALUES (1, 'Producto 1');
INSERT INTO producto (id_producto, des_producto) VALUES (6, 'producto 2');
INSERT INTO producto (id_producto, des_producto) VALUES (8, 'lalalal');


--
-- TOC entry 3106 (class 0 OID 0)
-- Dependencies: 178
-- Name: producto_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('producto_id_producto_seq', 11, true);


--
-- TOC entry 3055 (class 0 OID 16835)
-- Dependencies: 176
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (151.00000, 'Arica', 15.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (152.00000, 'Parinacota', 15.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (11.00000, 'Iquique', 1.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (14.00000, 'Tamarugal', 1.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (21.00000, 'Antofagasta', 2.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (22.00000, 'El Loa', 2.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (23.00000, 'Tocopilla', 2.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (31.00000, 'Copiapó', 3.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (32.00000, 'Chañaral', 3.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (33.00000, 'Huasco', 3.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (41.00000, 'Elqui', 4.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (42.00000, 'Choapa', 4.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (43.00000, 'Limarí', 4.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (51.00000, 'Valparaíso', 5.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (52.00000, 'Isla de Pascua', 5.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (53.00000, 'Los Andes', 5.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (54.00000, 'Petorca', 5.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (55.00000, 'Quillota', 5.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (56.00000, 'San Antonio', 5.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (57.00000, 'San Felipe de Aconcagua', 5.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (58.00000, 'Marga Marga', 5.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (61.00000, 'Cachapoal', 6.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (62.00000, 'Cardenal Caro', 6.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (63.00000, 'Colchagua', 6.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (71.00000, 'Talca', 7.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (72.00000, 'Cauquenes', 7.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (73.00000, 'Curicó', 7.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (74.00000, 'Linares', 7.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (81.00000, 'Concepción', 8.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (82.00000, 'Arauco', 8.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (83.00000, 'Biobío', 8.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (84.00000, 'Ñuble', 8.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (91.00000, 'Cautín', 9.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (92.00000, 'Malleco', 9.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (101.00000, 'Llanquihue', 10.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (102.00000, 'Chiloé', 10.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (103.00000, 'Osorno', 10.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (104.00000, 'Palena', 10.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (111.00000, 'Coihaique', 11.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (112.00000, 'Aisén', 11.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (113.00000, 'Capitán Prat', 11.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (114.00000, 'General Carrera', 11.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (121.00000, 'Magallanes', 12.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (122.00000, 'Antártica Chilena', 12.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (123.00000, 'Tierra del Fuego', 12.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (124.00000, 'Última Esperanza', 12.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (131.00000, 'Santiago', 13.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (132.00000, 'Cordillera', 13.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (133.00000, 'Chacabuco', 13.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (134.00000, 'Maipo', 13.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (135.00000, 'Melipilla', 13.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (136.00000, 'Talagante', 13.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (141.00000, 'Valdivia', 14.00000);
INSERT INTO provincia (pro_nidprovincia, pro_snombre, pro_nidregion) VALUES (142.00000, 'Ranco', 14.00000);


--
-- TOC entry 3072 (class 0 OID 17170)
-- Dependencies: 193
-- Data for Name: reclamo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO reclamo (id_reclamo, num_adherente, nombre_solicitante, email_solicitante, fono_solicitante, region_solicitante, id_tipo, id_motivo, id_prioridad, id_cartera, fec_ingreso, glosa, adjunto, observaciones, responsable_ingreso, responsable_actual, id_medio_respuesta, fec_respuesta, id_estado, dias_bandeja, dias_sistema) VALUES (31, '838988', 'Pedro', 'pedro@pedrito.com', '223232', '10', 6, 8, 1, 3, '2015-02-19 00:00:00', ' HOlahaoalgahgoahohalhohlhoalhola', NULL, 'observaciones', 'pedro', 'pablo', 5, '2015-04-16 00:00:00', 7, '', '');


--
-- TOC entry 3056 (class 0 OID 16839)
-- Dependencies: 177
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO region (cod_region, des_region) VALUES ('1', 'TARAPACÁ');
INSERT INTO region (cod_region, des_region) VALUES ('2', 'ANTOFAGASTA');
INSERT INTO region (cod_region, des_region) VALUES ('3', 'ATACAMA');
INSERT INTO region (cod_region, des_region) VALUES ('4', 'COQUIMBO');
INSERT INTO region (cod_region, des_region) VALUES ('5', 'VALPARAÍSO');
INSERT INTO region (cod_region, des_region) VALUES ('6', 'O HIGGINS');
INSERT INTO region (cod_region, des_region) VALUES ('7', 'MAULE');
INSERT INTO region (cod_region, des_region) VALUES ('8', 'BIOBÍO');
INSERT INTO region (cod_region, des_region) VALUES ('9', 'ARAUCANÍA');
INSERT INTO region (cod_region, des_region) VALUES ('10', 'LOS LAGOS');
INSERT INTO region (cod_region, des_region) VALUES ('11', 'AYSÉN');
INSERT INTO region (cod_region, des_region) VALUES ('12', 'MAGALLANES');
INSERT INTO region (cod_region, des_region) VALUES ('13', 'METROPOLITANA DE SANTIAGO');
INSERT INTO region (cod_region, des_region) VALUES ('14', 'LOS RÍOS');
INSERT INTO region (cod_region, des_region) VALUES ('15', 'ARICA Y PARINACOTA');


--
-- TOC entry 3107 (class 0 OID 0)
-- Dependencies: 171
-- Name: seq_documento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_documento', 55, true);


--
-- TOC entry 3108 (class 0 OID 0)
-- Dependencies: 172
-- Name: seq_reclamo; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_reclamo', 32, true);


--
-- TOC entry 3109 (class 0 OID 0)
-- Dependencies: 169
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_usuario', 42, true);


--
-- TOC entry 3060 (class 0 OID 17050)
-- Dependencies: 181
-- Data for Name: tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo (id_tipo, des_tipo) VALUES (6, 'Tipo 3');
INSERT INTO tipo (id_tipo, des_tipo) VALUES (7, 'Tipo 2');
INSERT INTO tipo (id_tipo, des_tipo) VALUES (9, 'Tipo 1');


--
-- TOC entry 3110 (class 0 OID 0)
-- Dependencies: 180
-- Name: tipo_id_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_id_tipo_seq', 9, true);


--
-- TOC entry 3049 (class 0 OID 16658)
-- Dependencies: 170
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (6, '16970737', '5', 'Andrés', 'Vega', 'Yáñez', 'avy', '71E10870A1741AAD', 'M', '1988-07-09', 'mi casa', 5801, 51, 5, 'Chile', '12345678', '87654321', 'avegay@interac.cl', 1, '2015-01-26 13:44:56.141854', '2015-01-22 00:00:00', 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (31, '33333333', '3', 'agiajgi', 'eijfidsjf', 'ijsdifjdsi', 'jifsjfis', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-21', NULL, NULL, NULL, NULL, NULL, '31313', '3131', 'user@mail.com', NULL, '2015-02-18 12:05:31.905749', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (32, '99999999', '0', 'sijfidsjf', 'jdifjdif', 'jdfidjif', 'fdjifjdi', '84DE04D33D2A095D', 'M', '2015-02-12', NULL, NULL, NULL, NULL, NULL, 'telefono', 'celular', 'user@mail.com', NULL, '2015-02-18 12:07:10.484945', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (33, '38239382', '9', 'dfjdifjdi', 'jdifjdifj', 'jdifjdif', 'jidfjid', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-17', NULL, NULL, NULL, NULL, NULL, 'telefono', 'telewfono', 'user@mail.com', NULL, '2015-02-18 12:08:30.395832', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (34, '33333333', '6', 'djifdji', 'jfdifjdi', 'jfidjfi', 'jidfjfid', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-14', NULL, NULL, NULL, NULL, NULL, 'telefono', 'celular', 'user@mail.com', NULL, '2015-02-18 12:10:38.560754', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (35, '33333333', '9', 'dsjifjdsif', 'jidjfdi', 'jdifjdi', 'jdifjdif', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-05', NULL, NULL, NULL, NULL, NULL, 'telefono', 'celular', 'user@mail.com', NULL, '2015-02-18 12:12:35.86906', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (36, '33333333', '9', 'ijfij', 'jfdifji', 'fjdifjdi', 'fdjifjdi', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-19', NULL, NULL, NULL, NULL, NULL, 'telefonno', 'celular', 'user@mail.com', NULL, '2015-02-18 12:17:14.516905', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (37, '33333333', '4', 'nombre', 'ape', 'mate', 'iva', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-17', NULL, NULL, NULL, NULL, NULL, 'tele', 'celu', 'user@mail.com', NULL, '2015-02-18 12:18:48.345584', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (38, '33333333', '7', 'nomre', 'ape', 'apema', 'nvao', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-25', NULL, NULL, NULL, NULL, NULL, 'telefono', 'celular', 'user@mail.com', NULL, '2015-02-18 12:19:45.380932', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (39, '55555555', '3', 'nombre', 'ape', 'ame', 'nombre', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-19', NULL, NULL, NULL, NULL, NULL, 'telefono', 'celular', 'user@mail.com', NULL, '2015-02-18 12:21:06.350954', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (40, '48348374', '2', '728327827482748', '8724827482748', '728472847', '27848274', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-20', NULL, NULL, NULL, NULL, NULL, 'telefono', 'celular', 'user@mail.com', NULL, '2015-02-18 12:38:09.844686', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (41, '99999999', '1', 'nombres', 'ape', 'ape', 'nombre', '8B4B37C20BB5C85ED17E4EE1DCAF35F6', 'M', '2015-02-19', NULL, NULL, NULL, NULL, NULL, 'telefono', 'celular', 'user@mail.com', NULL, '2015-02-18 12:39:14.859958', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (42, '99999999', '1', 'nombre', 'apepa', 'apema', 'papap', '7225E78C537EF7CC', 'M', '2015-02-19', NULL, NULL, NULL, NULL, NULL, 'telefono', 'celular', 'user@mail.com', NULL, '2015-02-18 12:42:26.268824', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (1, '16201021', '2', 'Jorge Andrés', 'Inostroza', 'Urrutia', 'jiu', '9E02E1514729B70016A76BB942F6002C', 'M', '1986-04-04', 'Suiza 960 Casa 4 Belloto Centro', 5801, 51, 5, 'Chile', '032 2949525', '75389915', 'jinostroza@interac.cl', NULL, '2013-12-03 21:02:23.286416', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (12, '18299276', '3', 'Michele ', 'De Conti', 'Rivara', 'michele', '9CC3A942F54B9ED346BACBE1EE5B7FDF', NULL, '1993-01-22', NULL, NULL, NULL, NULL, NULL, '2953520', '12345678', 'mdeconti@interac.cl', NULL, NULL, NULL, NULL);
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (13, '17993508', '2', 'Iván Antonio', 'Zamorano', 'Cataldo', 'iza', 'F9EEDB17954E3D45', 'M', '2012-11-11', NULL, NULL, NULL, NULL, NULL, '1234567', '74086605', 'izamorano@interac.cl', NULL, '2015-01-30 10:51:46.329575', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (30, '1829955', '5', 'diego', 'flores', 'castillo', 'daigosk', '1FD1D04C74946872E76D4CA2FF750953', NULL, '2015-02-20', NULL, NULL, NULL, NULL, NULL, '2953520', '2953520', 'Diego@mail.com', NULL, '2015-02-18 08:04:30.942513', NULL, 'h');


--
-- TOC entry 2912 (class 2606 OID 16665)
-- Name: area_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY area
    ADD CONSTRAINT area_pkey PRIMARY KEY (cod_area);


--
-- TOC entry 2924 (class 2606 OID 17086)
-- Name: cartera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cartera
    ADD CONSTRAINT cartera_pkey PRIMARY KEY (id_cartera);


--
-- TOC entry 2938 (class 2606 OID 17298)
-- Name: documento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_pkey PRIMARY KEY (id_documento);


--
-- TOC entry 2916 (class 2606 OID 17223)
-- Name: empresa_num_adherente_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_num_adherente_key UNIQUE (num_adherente);


--
-- TOC entry 2918 (class 2606 OID 17124)
-- Name: empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (id_empresa);


--
-- TOC entry 2926 (class 2606 OID 17094)
-- Name: estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id_estado);


--
-- TOC entry 2930 (class 2606 OID 17137)
-- Name: medios_respuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY medios_respuesta
    ADD CONSTRAINT medios_respuesta_pkey PRIMARY KEY (id_medio_respuesta);


--
-- TOC entry 2928 (class 2606 OID 17110)
-- Name: motivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY motivo
    ADD CONSTRAINT motivo_pkey PRIMARY KEY (id_motivo);


--
-- TOC entry 2936 (class 2606 OID 17231)
-- Name: perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id_perfil);


--
-- TOC entry 2932 (class 2606 OID 17150)
-- Name: prioridad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prioridad
    ADD CONSTRAINT prioridad_pkey PRIMARY KEY (id_prioridad);


--
-- TOC entry 2920 (class 2606 OID 17014)
-- Name: producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 2934 (class 2606 OID 17177)
-- Name: reclamo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reclamo
    ADD CONSTRAINT reclamo_pkey PRIMARY KEY (id_reclamo);


--
-- TOC entry 2922 (class 2606 OID 17055)
-- Name: tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (id_tipo);


--
-- TOC entry 2914 (class 2606 OID 16671)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (idusuario);


--
-- TOC entry 2940 (class 2606 OID 17258)
-- Name: perfil_usuario_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfil_usuario
    ADD CONSTRAINT perfil_usuario_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil);


--
-- TOC entry 2939 (class 2606 OID 17253)
-- Name: perfil_usuario_idusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfil_usuario
    ADD CONSTRAINT perfil_usuario_idusuario_fkey FOREIGN KEY (idusuario) REFERENCES usuario(idusuario);


--
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-03-03 16:30:14

--
-- PostgreSQL database dump complete
--


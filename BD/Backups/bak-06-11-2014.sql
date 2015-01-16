--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.5
-- Dumped by pg_dump version 9.3.5
-- Started on 2014-11-06 18:46:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1962 (class 1262 OID 16393)
-- Name: mutual; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE mutual WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Chile.1252' LC_CTYPE = 'Spanish_Chile.1252';


ALTER DATABASE mutual OWNER TO postgres;

\connect mutual

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 174 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1965 (class 0 OID 0)
-- Dependencies: 174
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 187 (class 1255 OID 16394)
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
-- TOC entry 188 (class 1255 OID 16395)
-- Name: buscar_carteras(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_carteras(OUT carteras refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := '0';
		msjerror := ' ';

        open carteras for

        select
            cod_cartera,
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

$$;


ALTER FUNCTION public.buscar_carteras(OUT carteras refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 195 (class 1255 OID 16423)
-- Name: buscar_carteras_productos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_carteras_productos(OUT carteras refcursor, OUT productos refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
    begin
        numerror := '0';
        msjerror := ' ';

        open carteras for

        select
            cod_cartera,
            des_cartera
        from 
            cartera
        order by
            des_cartera;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_carteras_productos] error al buscar carteras(sql) ' ||sqlerrm;
                return; 
    end;

    begin
        numerror := '0';
		msjerror := ' ';

        open productos for

        select
            cod_producto,
            des_producto
        from 
            producto
        order by
            des_producto;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_carteras_productos] error al buscar productos(sql) ' ||sqlerrm;
                return;	
    end;
end;
$$;


ALTER FUNCTION public.buscar_carteras_productos(OUT carteras refcursor, OUT productos refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 189 (class 1255 OID 16396)
-- Name: buscar_productos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_productos(OUT productos refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := '0';
		msjerror := ' ';

        open productos for

        select
            cod_producto,
            des_producto
        from 
            producto
        order by
            des_producto;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_productos] error al buscar productos(sql) ' ||sqlerrm;
                return;	
    end;

$$;


ALTER FUNCTION public.buscar_productos(OUT productos refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 190 (class 1255 OID 16397)
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
        numerror := '0';
        msjerror := ' ';

        
        xrut := coalesce(upper(trim(rut$)),'') || '%';
        xnombres := '%' || coalesce(upper(trim(nombres$)),'') || '%';
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
            upper(nombres) like xnombres and
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
-- TOC entry 191 (class 1255 OID 16398)
-- Name: cargar_usuario(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_usuario(xnidusuario numeric, OUT usuarios refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    begin
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
-- TOC entry 192 (class 1255 OID 16399)
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
-- TOC entry 193 (class 1255 OID 16400)
-- Name: login(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION login(username character varying, contrasena character varying, host character varying, codaplicacion character varying, codidioma character varying, OUT ses_idsesion character varying, OUT ses_fhologueo character varying, OUT ses_fhoultimaconsulta character varying, OUT ses_scodaplicacion character varying, OUT ses_snumusuario character varying, OUT ses_srutusuario character varying, OUT ses_snomusuario character varying, OUT ses_scodidioma character varying, OUT ses_data01 character varying, OUT ses_data02 character varying, OUT ses_data03 character varying, OUT ses_data04 character varying, OUT ses_data05 character varying, OUT expiracontrasena character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xses_idsesion       varchar(100);
    declare xnumusuario			numeric(10);
    declare xrutusuario			varchar(10);
    declare xdvusuario 			varchar(10);
    declare xusername			varchar(20);
    declare xcontrasena			varchar(40);
    declare xapepaterno 		varchar(40);
    declare xapematerno 		varchar(40);
    declare xnombre 			varchar(100);
    declare xtelefono			varchar(20);
    declare xemail 				varchar(100);
    declare xindvigencia		varchar(1);  
    declare xfhocontrasena		date;
    declare xcantintentos		numeric(4,0);
    declare xfechaactual			varchar(20);
    declare xnombre_completo	varchar(255);
    declare xrut_completo       varchar(255);

    begin
        numerror := '0';
        msjerror := ' ';

        select
            u.idusuario,
            u.rut,
            u.dv,
            u.contrasena, 
            u.apepaterno,
            u.apematerno,
            u.nombres,
            u.telefono,
            u.email,
            u.indvigencia,
            u.feccontrasena,
            u.cantintentos
        into
            xnumusuario,
            xrutusuario,
            xdvusuario,
            xcontrasena, 
            xapepaterno,
            xapematerno,
            xnombre,
            xtelefono,
            xemail,
            xindvigencia,
            xfhocontrasena,
            xcantintentos
        from
            usuario u
        where
            upper(nomusuario) = upper(username);

if found then
    return;
else
RAISE EXCEPTION 'No existe el usuario %',$1;


   

end if;



        


        ses_idsesion			:= xses_idsesion;
        ses_fhologueo 			:= xfechaactual;
        ses_fhoultimaconsulta	:= xfechaactual;
        ses_scodaplicacion		:= codaplicacion;
        ses_snumusuario         := trim(to_char(xnumusuario, '99999999'));
        ses_srutusuario         := xrutusuario;
        ses_snomusuario         := xnombre_completo;
        ses_scodidioma			:= xtelefono;
        ses_data01				:= xemail;
        ses_data02				:= ' ';
        ses_data03				:= ' ';
        ses_data04				:= ' ';
        ses_data05				:= codidioma;

    end;

$_$;


ALTER FUNCTION public.login(username character varying, contrasena character varying, host character varying, codaplicacion character varying, codidioma character varying, OUT ses_idsesion character varying, OUT ses_fhologueo character varying, OUT ses_fhoultimaconsulta character varying, OUT ses_scodaplicacion character varying, OUT ses_snumusuario character varying, OUT ses_srutusuario character varying, OUT ses_snomusuario character varying, OUT ses_scodidioma character varying, OUT ses_data01 character varying, OUT ses_data02 character varying, OUT ses_data03 character varying, OUT ses_data04 character varying, OUT ses_data05 character varying, OUT expiracontrasena character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 194 (class 1255 OID 16401)
-- Name: modificar_usuario(numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, date, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_usuario(xidusuario numeric, xrut character varying, xdv character varying, xnombres character varying, xapepaterno character varying, xapematerno character varying, xnomusuario character varying, xcontrasena character varying, xcodgenero character varying, xfecnacimiento date, xtelefono character varying, xcelular character varying, xemail character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
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
			contrasena = xcontrasena,
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


ALTER FUNCTION public.modificar_usuario(xidusuario numeric, xrut character varying, xdv character varying, xnombres character varying, xapepaterno character varying, xapematerno character varying, xnomusuario character varying, xcontrasena character varying, xcodgenero character varying, xfecnacimiento date, xtelefono character varying, xcelular character varying, xemail character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 170 (class 1259 OID 16402)
-- Name: cartera; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cartera (
    cod_cartera character varying(5) NOT NULL,
    des_cartera character varying(200)
);


ALTER TABLE public.cartera OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 16405)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE producto (
    cod_producto character varying(5) NOT NULL,
    des_producto character varying(200)
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 16408)
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
-- TOC entry 173 (class 1259 OID 16410)
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
-- TOC entry 1954 (class 0 OID 16402)
-- Dependencies: 170
-- Data for Name: cartera; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cartera VALUES ('TRPUB', 'Cartera Transporte Publico');
INSERT INTO cartera VALUES ('TRANS', 'Cartera Transporte');
INSERT INTO cartera VALUES ('TELEC', 'Cartera Telecomunicaciones');
INSERT INTO cartera VALUES ('ALL', 'Cartera Transversal');


--
-- TOC entry 1955 (class 0 OID 16405)
-- Dependencies: 171
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO producto VALUES ('AFICH', 'Afiches');
INSERT INTO producto VALUES ('CATAL', 'Catalogos');
INSERT INTO producto VALUES ('DOCAP', 'Documentos de Apoyo');
INSERT INTO producto VALUES ('CAMPA', 'Campañas');


--
-- TOC entry 1966 (class 0 OID 0)
-- Dependencies: 172
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_usuario', 4, true);


--
-- TOC entry 1957 (class 0 OID 16410)
-- Dependencies: 173
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario VALUES (1, '16201021', '2', 'Jorge Andrés', 'Inostroza', 'Urrutia', 'jiu', 'vince2315', 'M', '1986-04-04', 'Suiza 960 Casa 4 Belloto Centro', 5801, 51, 5, 'Chile', '032 2949525', '75389915', 'jinostroza@interac.cl', NULL, '2013-12-03 21:02:23.286416', NULL, 'h');
INSERT INTO usuario VALUES (2, '16231169', '7', 'Sebastian', 'Pezoa', 'Di Domenico', 'spd', 'publicidad1', 'M', '1985-08-29', 'amunategui1946', 5801, 51, 5, 'chile', '', '91404098', 's_didomenico@hotmail.com', NULL, '2013-12-27 15:42:03.907807', NULL, 'h');
INSERT INTO usuario VALUES (4, '19', '', 'admin', '', '', 'admin', NULL, 'M', '2014-11-01', NULL, NULL, NULL, NULL, NULL, '', '', '', NULL, '2014-11-06 12:12:42.061', NULL, 'h');


--
-- TOC entry 1842 (class 2606 OID 16417)
-- Name: cartera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cartera
    ADD CONSTRAINT cartera_pkey PRIMARY KEY (cod_cartera);


--
-- TOC entry 1844 (class 2606 OID 16419)
-- Name: producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (cod_producto);


--
-- TOC entry 1846 (class 2606 OID 16421)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (idusuario);


--
-- TOC entry 1964 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-11-06 18:46:45

--
-- PostgreSQL database dump complete
--


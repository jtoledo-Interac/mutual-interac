--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.7
-- Dumped by pg_dump version 9.3.1
-- Started on 2015-03-30 11:09:36 CLST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 207 (class 3079 OID 12648)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 207
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 306 (class 1255 OID 17676)
-- Name: agregar_accidentabilidad(integer, double precision, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_accidentabilidad(xid_empresa integer, xaccidentes double precision, xfecha_ingreso timestamp without time zone, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$   

	begin	
		
		numerror := 0;
		msjerror := '';

		insert into accidentabilidad
		(
		id_empresa,   	
		accidentes,
		fecha_ingreso
		)
        values
		(
	    xid_empresa,
		xaccidentes,
		xfecha_ingreso
		);
       
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_accidentabilidad] error al crear accidentabilidad(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_accidentabilidad(xid_empresa integer, xaccidentes double precision, xfecha_ingreso timestamp without time zone, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 269 (class 1255 OID 17074)
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
-- TOC entry 307 (class 1255 OID 17677)
-- Name: agregar_dias_perdidos(integer, integer, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_dias_perdidos(xid_empresa integer, xdias_perdidos integer, xfecha_ingreso timestamp without time zone, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin	
		
		numerror := 0;
		msjerror := '';

		insert into diasperdidos
		(
		id_empresa,   	
		dias_perdidos,
		fecha_ingreso
		)
        values
		(
	    xid_empresa,
		xdias_perdidos,
		xfecha_ingreso
		);
       
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_dias_perdidos] error al crear diasperdidos(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_dias_perdidos(xid_empresa integer, xdias_perdidos integer, xfecha_ingreso timestamp without time zone, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 17165)
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
-- TOC entry 309 (class 1255 OID 17730)
-- Name: agregar_empresa(character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, timestamp without time zone, timestamp without time zone, character varying, character varying, timestamp without time zone, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_empresa(xnum_adherente character varying, xnombre character varying, xcod_cartera character varying, xnom_experto character varying, xrazon_social character varying, xano_de_adhesion timestamp without time zone, xsegmentacion character varying, xholding character varying, xestrategica character varying, xsituacion character varying, xmulti_region character varying, xcasa_matriz character varying, xnum_centros_trabajo character varying, xmasa_sum_metropolitana character varying, xmasa_sum_nacional character varying, xplanes_de_cuenta character varying, xplanes_de_trabajo character varying, xfirma_de_planes character varying, xsistema_de_gestion character varying, xetapa_sistema_gestion character varying, xfirma_protocolo timestamp without time zone, xnum_cphs character varying, xnum_cphs_certificado character varying, xnum_cphs_bronce character varying, xnum_cphs_plata character varying, xnum_cphs_oro character varying, xprexor character varying, xprexor_etapa character varying, xprexor_texto character varying, xplanesi character varying, xplanesi_etapa character varying, xplanesi_texto character varying, xasbesto character varying, xasbesto_etapa character varying, xasbesto_texto character varying, xhipobaria character varying, xhipobaria_etapa character varying, xhipobaria_texto character varying, xradiaciones character varying, xradiaciones_etapa character varying, xradiaciones_texto character varying, xasma character varying, xasma_etapa character varying, xasma_texto character varying, xsolventes character varying, xsolventes_etapa character varying, xsolventes_texto character varying, xmetales character varying, xmetales_etapa character varying, xmetales_texto character varying, xoxido character varying, xoxido_etapa character varying, xoxido_texto character varying, xplaguicida character varying, xplaguicida_etapa character varying, xplaguicida_texto character varying, xpsicosociales character varying, xpsicosociales_etapa character varying, xpsicosociales_texto character varying, xmmc character varying, xmmc_etapa character varying, xmmc_texto character varying, xtmert character varying, xtmert_etapa character varying, xtmert_texto character varying, xradiacion_uv character varying, xradiacion_uv_etapa character varying, xradiacion_uv_texto character varying, xultima_visita_experto timestamp without time zone, xultima_visita_director timestamp without time zone, xultima_visita_gtte timestamp without time zone, xultima_visita_alta_gerencia timestamp without time zone, xreporte_visita character varying, xriesgo_de_fuga character varying, xreclamo_ultimo_periodo timestamp without time zone, xparticipacion_mesa_trabajo character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    

	begin	
		
		numerror := 0;
		msjerror := '';

		insert into empresa
		(
			num_adherente,
			nombre,
			cod_cartera,
			nom_experto,
			razon_social,
			ano_de_adhesion,
			segmentacion,
			holding,
			estrategica,
			situacion,
			multi_region,
			casa_matriz,
			num_centros_trabajo,
			masa_sum_metropilitana ,
			masa_sum_nacional ,
			planes_de_cuenta ,
			planes_de_trabajo ,
			firma_de_planes ,
			sistema_de_gestion ,
			etapa_sistema_gestion ,
			firma_protocolo ,
			num_cphs ,
			num_cphs_certificado ,
			num_cphs_bronce ,
			num_cphs_plata ,
			num_cphs_oro ,
			prexor,
			prexor_etapa ,
			prexor_texto ,
			planesi ,
			planesi_etapa ,
			planesi_texto ,
			asbesto,
			asbesto_etapa,
			asbesto_texto,
			hipobaria ,
			hipobaria_etapa ,
			hipobaria_texto ,
			radiaciones ,
			radiaciones_etapa ,
			radiaciones_texto ,
			asma ,
			asma_etapa ,
			asma_texto ,
			solventes ,
			solventes_etapa ,
			solventes_texto ,
			metales,
			metales_etapa,
			metales_texto,
			oxido ,
			oxido_etapa ,
			oxido_texto ,
			plaguicida ,
			plaguicida_etapa ,
			plaguicida_texto ,
			psicosociales ,
			psicosociales_etapa ,
			psicosociales_texto ,
			mmc ,
			mmc_etapa ,
			mmc_texto ,
			tmert ,
			tmert_etapa ,
			tmert_texto ,
			radiacion_uv ,
			radiacion_uv_etapa ,
			radiacion_uv_texto ,
			ultima_visita_experto,
			ultima_visita_director,
			ultima_visita_gtte,
			ultima_visita_alta_gerencia,
			reporte_visita ,
			riesgo_de_fuga ,
			reclamo_ultimo_periodo,
			participacion_mesa_trabajo 
		)
        values
		(
			xnum_adherente,
			xnombre,
			xcod_cartera,
			xnom_experto,
			xrazon_social,
			xano_de_adhesion,
			xsegmentacion,
			xholding,
			xestrategica,
			xsituacion,
			xmulti_region,
			xcasa_matriz,
			xnum_centros_trabajo,
			xmasa_sum_metropolitana,
			xmasa_sum_nacional,
			xplanes_de_cuenta,
			xplanes_de_trabajo,
			xfirma_de_planes,
			xsistema_de_gestion,
			xetapa_sistema_gestion,
			xfirma_protocolo,			
			xnum_cphs,
			xnum_cphs_certificado,
			xnum_cphs_bronce,
			xnum_cphs_plata,
			xnum_cphs_oro,
			xprexor ,
			xprexor_etapa,
			xprexor_texto,
			xplanesi,
			xplanesi_etapa,
			xplanesi_texto,
			xasbesto,
			xasbesto_etapa,
			xasbesto_texto,
			xhipobaria,
			xhipobaria_etapa,
			xhipobaria_texto,
			xradiaciones,
			xradiaciones_etapa,
			xradiaciones_texto,
			xasma,
			xasma_etapa,
			xasma_texto,
			xmetales,
			xmetales_etapa,
			xmetales_texto,
			xsolventes,
			xsolventes_etapa,
			xsolventes_texto,
			xoxido,
			xoxido_etapa,
			xoxido_texto,
			xplaguicida,
			xplaguicida_etapa,
			xplaguicida_texto,
			xpsicosociales,
			xpsicosociales_etapa,
			xpsicosociales_texto,
			xmmc,
			xmmc_etapa,
			xmmc_texto,
			xtmert,
			xtmert_etapa,
			xtmert_texto,
			xradiacion_uv,
			xradiacion_uv_etapa,
			xradiacion_uv_texto,
			xultima_visita_experto,
			xultima_visita_director,
			xultima_visita_gtte,
			xultima_visita_alta_gerencia,
			xreporte_visita,
			xriesgo_de_fuga,
			xreclamo_ultimo_periodo,
			xparticipacion_mesa_trabajo
		);

       
        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_empresa] error al crear empresa(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_empresa(xnum_adherente character varying, xnombre character varying, xcod_cartera character varying, xnom_experto character varying, xrazon_social character varying, xano_de_adhesion timestamp without time zone, xsegmentacion character varying, xholding character varying, xestrategica character varying, xsituacion character varying, xmulti_region character varying, xcasa_matriz character varying, xnum_centros_trabajo character varying, xmasa_sum_metropolitana character varying, xmasa_sum_nacional character varying, xplanes_de_cuenta character varying, xplanes_de_trabajo character varying, xfirma_de_planes character varying, xsistema_de_gestion character varying, xetapa_sistema_gestion character varying, xfirma_protocolo timestamp without time zone, xnum_cphs character varying, xnum_cphs_certificado character varying, xnum_cphs_bronce character varying, xnum_cphs_plata character varying, xnum_cphs_oro character varying, xprexor character varying, xprexor_etapa character varying, xprexor_texto character varying, xplanesi character varying, xplanesi_etapa character varying, xplanesi_texto character varying, xasbesto character varying, xasbesto_etapa character varying, xasbesto_texto character varying, xhipobaria character varying, xhipobaria_etapa character varying, xhipobaria_texto character varying, xradiaciones character varying, xradiaciones_etapa character varying, xradiaciones_texto character varying, xasma character varying, xasma_etapa character varying, xasma_texto character varying, xsolventes character varying, xsolventes_etapa character varying, xsolventes_texto character varying, xmetales character varying, xmetales_etapa character varying, xmetales_texto character varying, xoxido character varying, xoxido_etapa character varying, xoxido_texto character varying, xplaguicida character varying, xplaguicida_etapa character varying, xplaguicida_texto character varying, xpsicosociales character varying, xpsicosociales_etapa character varying, xpsicosociales_texto character varying, xmmc character varying, xmmc_etapa character varying, xmmc_texto character varying, xtmert character varying, xtmert_etapa character varying, xtmert_texto character varying, xradiacion_uv character varying, xradiacion_uv_etapa character varying, xradiacion_uv_texto character varying, xultima_visita_experto timestamp without time zone, xultima_visita_director timestamp without time zone, xultima_visita_gtte timestamp without time zone, xultima_visita_alta_gerencia timestamp without time zone, xreporte_visita character varying, xriesgo_de_fuga character varying, xreclamo_ultimo_periodo timestamp without time zone, xparticipacion_mesa_trabajo character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 17095)
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
-- TOC entry 295 (class 1255 OID 17309)
-- Name: agregar_link(character varying, character varying, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_link(xdes_link character varying, xurl_link character varying, xid_tipo_link numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into link
		(
			des_link,
			url_link,
			id_tipo_link
		)
        values
		(
			xdes_link,
			xurl_link,
			xid_tipo_link
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_link] error al crear link(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_link(xdes_link character varying, xurl_link character varying, xid_tipo_link numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 17138)
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
-- TOC entry 230 (class 1255 OID 16941)
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
-- TOC entry 274 (class 1255 OID 17111)
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
-- TOC entry 229 (class 1255 OID 17232)
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
-- TOC entry 238 (class 1255 OID 17151)
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
-- TOC entry 258 (class 1255 OID 17019)
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
-- TOC entry 288 (class 1255 OID 17202)
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
-- TOC entry 268 (class 1255 OID 17057)
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
-- TOC entry 296 (class 1255 OID 17310)
-- Name: agregar_tipo_link(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregar_tipo_link(xdes_tipo_link character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$    

	begin
	
		numerror := 0;
		msjerror := '';

		insert into tipo_link
		(
			des_tipo_link
		)
        values
		(
			xdes_tipo_link
		);

        return;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[agregar_tipo_link] error al crear tipo link(sql) ' ||sqlerrm;
				return;	
	end;
$$;


ALTER FUNCTION public.agregar_tipo_link(xdes_tipo_link character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 220 (class 1255 OID 16638)
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
-- TOC entry 272 (class 1255 OID 17075)
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
-- TOC entry 314 (class 1255 OID 17737)
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
        left join area as a 
            on d.cod_area = a.cod_area
        left join cartera as c 
            on d.id_cartera = c.id_cartera
        left join producto as p 
            on d.id_producto = p.id_producto
        where
            upper(d.nombre) like '%' || xnombre ||'%'      --   and
            --(xnum_folio = ' ' or upper(d.num_folio) = xnum_folio) and
            --(xnum_adherente = ' ' or upper(d.num_adherente) = xnum_adherente) and
            --(xid_cartera = 0  or d.id_cartera = xid_cartera) and
            --(xid_producto = 0 or d.id_producto = xid_producto) and
            --(xcod_area =  ' ' or upper(d.cod_area) = xcod_area)
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
-- TOC entry 310 (class 1255 OID 17732)
-- Name: buscar_empresas(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_empresas("xnombre$" character varying, "xnum_adherente$" character varying, "xcod_cartera$" character varying, OUT empresas refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xnombre varchar;
    declare xnum_adherente varchar;
    declare xcod_cartera varchar;

    begin

        numerror := 0;
        msjerror := ' ';

        xnombre := coalesce(upper(trim(xnombre$)),'') || '%';

        if trim(xnum_adherente$) = '' then
            xnum_adherente := ' ';
        else
            xnum_adherente := upper(trim(xnum_adherente$));
        end if;

        if trim(xcod_cartera$) = '' then
            xcod_cartera := ' ';
        else
            xcod_cartera := upper(trim(xcod_cartera$));
        end if;

        open empresas for

        select
            id_empresa,
            num_adherente,
			nombre,
			cod_cartera,
			nom_experto,
			razon_social,
			ano_de_adhesion,
			segmentacion,
			holding,
			estrategica,
			situacion,
			multi_region,
			casa_matriz,
			num_centros_trabajo,
			masa_sum_metropilitana ,
			masa_sum_nacional ,
			planes_de_cuenta ,
			planes_de_trabajo ,
			firma_de_planes ,
			sistema_de_gestion ,
			etapa_sistema_gestion ,
			firma_protocolo ,
			num_cphs ,
			num_cphs_certificado ,
			num_cphs_bronce ,
			num_cphs_plata ,
			num_cphs_oro ,
			prexor,
			prexor_etapa ,
			prexor_texto ,
			planesi ,
			planesi_etapa ,
			planesi_texto ,
			asbesto,
			asbesto_etapa,
			asbesto_texto,
			hipobaria ,
			hipobaria_etapa ,
			hipobaria_texto ,
			radiaciones ,
			radiaciones_etapa ,
			radiaciones_texto ,
			asma ,
			asma_etapa ,
			asma_texto ,
			solventes ,
			solventes_etapa ,
			solventes_texto ,
			metales,
			metales_etapa,
			metales_texto,
			oxido ,
			oxido_etapa ,
			oxido_texto ,
			plaguicida ,
			plaguicida_etapa ,
			plaguicida_texto ,
			psicosociales ,
			psicosociales_etapa ,
			psicosociales_texto ,
			mmc ,
			mmc_etapa ,
			mmc_texto ,
			tmert ,
			tmert_etapa ,
			tmert_texto ,
			radiacion_uv ,
			radiacion_uv_etapa ,
			radiacion_uv_texto ,
			ultima_visita_experto,
			ultima_visita_director,
			ultima_visita_gtte,
			ultima_visita_alta_gerencia,
			reporte_visita ,
			riesgo_de_fuga ,
			reclamo_ultimo_periodo,
			participacion_mesa_trabajo 
        from 
            empresa
        where
            upper(nombre) like '%' || xnombre ||'%' and
            (xnum_adherente =  ' ' or upper(trim(num_adherente)) = xnum_adherente) and
            (xcod_cartera =  ' ' or upper(trim(cod_cartera)) = xcod_cartera)
            
        order by
            nombre;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_empresas] error al buscar empresas(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_empresas("xnombre$" character varying, "xnum_adherente$" character varying, "xcod_cartera$" character varying, OUT empresas refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 286 (class 1255 OID 17098)
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
-- TOC entry 299 (class 1255 OID 17349)
-- Name: buscar_links(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_links("xid_tipo_link$" numeric, "xdes_link$" character varying, OUT links refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
        declare xid_tipo_link numeric;
        declare xdes_link varchar;
    begin
        
        numerror := 0;
        msjerror := ' ';
        xdes_link := coalesce(upper(trim(xdes_link$)),'');
        xid_tipo_link=xid_tipo_link$;
        open links for

        select
            id_link,     
            url_link,
            des_link,
            r.id_tipo_link as id_tipo_link,
            m.des_tipo_link as des_tipo_link
            
        from 
            link r
            inner join tipo_link as m
                on r.id_tipo_link = m.id_tipo_link

        where
                upper(des_link) like '%' || xdes_link ||'%' and
              (xid_tipo_link =      0 or r.id_tipo_link = xid_tipo_link)          
        order by
            des_tipo_link;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_links] error al buscar links(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_links("xid_tipo_link$" numeric, "xdes_link$" character varying, OUT links refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 17189)
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
-- TOC entry 251 (class 1255 OID 16950)
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
-- TOC entry 277 (class 1255 OID 17112)
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
-- TOC entry 308 (class 1255 OID 17682)
-- Name: buscar_par_empresas(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_par_empresas(OUT carteras refcursor, OUT regiones refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
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


ALTER FUNCTION public.buscar_par_empresas(OUT carteras refcursor, OUT regiones refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 281 (class 1255 OID 17186)
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
-- TOC entry 278 (class 1255 OID 17102)
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
-- TOC entry 301 (class 1255 OID 17352)
-- Name: buscar_parametros_link(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_parametros_link(OUT tipo_links refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := ' ';

        open tipo_links for

        select
            id_tipo_link,
            des_tipo_link
        from 
            tipo_link
        order by
            des_tipo_link;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[buscar_parametros] error al buscar carteras(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.buscar_parametros_link(OUT tipo_links refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 287 (class 1255 OID 17221)
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
-- TOC entry 234 (class 1255 OID 17267)
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
-- TOC entry 247 (class 1255 OID 17153)
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
-- TOC entry 262 (class 1255 OID 17020)
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
-- TOC entry 292 (class 1255 OID 17200)
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
-- TOC entry 285 (class 1255 OID 17190)
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
-- TOC entry 243 (class 1255 OID 16838)
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
-- TOC entry 305 (class 1255 OID 17675)
-- Name: buscar_reportes(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_reportes("xnombre$" character varying, OUT reportes refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$

    declare xnombre varchar;

    begin

        numerror := 0;
		msjerror := ' ';

        xnombre := coalesce(upper(trim(xnombre$)),'') || '%';

        open reportes for

        select
            id_empresa,
            nombre
        from 
            empresa
        where
            upper(nombre) like '%' || xnombre ||'%'
        order by
            nombre;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[buscar_reportes] error al buscar empresas(sql) ' ||sqlerrm;
                return;	
    end;

$_$;


ALTER FUNCTION public.buscar_reportes("xnombre$" character varying, OUT reportes refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 297 (class 1255 OID 17312)
-- Name: buscar_tipo_links(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buscar_tipo_links("xnomlink$" character varying, OUT links refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
        declare xnomlink varchar;
    begin
        xnomlink := coalesce(upper(trim(xnomlink$)),'') || '%';
        numerror := 0;
        msjerror := ' ';

        open links for

        select
            id_tipo_link,
            des_tipo_link
        from 
            tipo_link
        where
             upper(des_tipo_link) like '%' || xnomlink ||'%'                  
        order by
            des_tipo_link;
        
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[buscar_tipo_links] error al buscar tipó_links(sql) ' ||sqlerrm;
                return; 
    end;

$_$;


ALTER FUNCTION public.buscar_tipo_links("xnomlink$" character varying, OUT links refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 17036)
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
-- TOC entry 260 (class 1255 OID 17000)
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
-- TOC entry 294 (class 1255 OID 17308)
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
-- TOC entry 263 (class 1255 OID 17096)
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
-- TOC entry 303 (class 1255 OID 17579)
-- Name: cargar_dias_perdidos(numeric, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_dias_perdidos(xid_empresa numeric, xfecha_inicio timestamp without time zone, xfecha_fin timestamp without time zone, OUT dias refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    numerror := 0;
    msjerror := ' ';
    begin

        numerror := 0;
        msjerror := '';
        open dias for

            select
            	id_empresa,
				fecha_ingreso,
				dias_perdidos
			
            from 
                diasperdidos
            where
                id_empresa = xid_empresa and xfecha_inicio>=fecha_ingreso and xfecha_fin<= fecha_ingreso;

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[carga_dias_perdidos] error al cargar diasperdidos(sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_dias_perdidos(xid_empresa numeric, xfecha_inicio timestamp without time zone, xfecha_fin timestamp without time zone, OUT dias refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 17167)
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
-- TOC entry 311 (class 1255 OID 17733)
-- Name: cargar_empresa(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_empresa(xid_empresa numeric, OUT empresas refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    numerror := 0;
    msjerror := ' ';
    begin

        numerror := 0;
        msjerror := '';
        open empresas for

            select
            id_empresa,
            num_adherente,
			nombre,
			cod_cartera,
			nom_experto,
			razon_social,
			ano_de_adhesion,
			segmentacion,
			holding,
			estrategica,
			situacion,
			multi_region,
			casa_matriz,
			num_centros_trabajo,
			masa_sum_metropilitana ,
			masa_sum_nacional ,
			planes_de_cuenta ,
			planes_de_trabajo ,
			firma_de_planes ,
			sistema_de_gestion ,
			firma_protocolo ,
			etapa_sistema_gestion ,
			num_cphs ,
			num_cphs_certificado ,
			num_cphs_bronce ,
			num_cphs_plata ,
			num_cphs_oro ,
			prexor,
			prexor_etapa ,
			prexor_texto ,
			planesi ,
			planesi_etapa ,
			planesi_texto ,
			asbesto,
			asbesto_etapa,
			asbesto_texto,
			hipobaria ,
			hipobaria_etapa ,
			hipobaria_texto ,
			radiaciones ,
			radiaciones_etapa ,
			radiaciones_texto ,
			asma ,
			asma_etapa ,
			asma_texto ,
			solventes ,
			solventes_etapa ,
			solventes_texto ,
			metales,
			metales_etapa,
			metales_texto,
			oxido ,
			oxido_etapa ,
			oxido_texto ,
			plaguicida ,
			plaguicida_etapa ,
			plaguicida_texto ,
			psicosociales ,
			psicosociales_etapa ,
			psicosociales_texto ,
			mmc ,
			mmc_etapa ,
			mmc_texto ,
			tmert ,
			tmert_etapa ,
			tmert_texto ,
			radiacion_uv ,
			radiacion_uv_etapa ,
			radiacion_uv_texto ,
			ultima_visita_experto,
			ultima_visita_director,
			ultima_visita_gtte,
			ultima_visita_alta_gerencia,
			reporte_visita ,
			riesgo_de_fuga ,
			reclamo_ultimo_periodo,
			participacion_mesa_trabajo 
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
-- TOC entry 228 (class 1255 OID 17099)
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
-- TOC entry 298 (class 1255 OID 17313)
-- Name: cargar_link(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_link(xid_link numeric, OUT links refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    numerror := 0;
    msjerror := ' ';
    begin
        open links for

            select
                id_link,
                url_link,
                des_link,
                id_tipo_link               
            from 
                link       
                where
                    id_link = xid_link; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_link  error al cargar link sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_link(xid_link numeric, OUT links refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 17140)
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
-- TOC entry 239 (class 1255 OID 16960)
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
-- TOC entry 279 (class 1255 OID 17113)
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
-- TOC entry 291 (class 1255 OID 17263)
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
-- TOC entry 250 (class 1255 OID 17154)
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
-- TOC entry 264 (class 1255 OID 17021)
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
-- TOC entry 282 (class 1255 OID 17183)
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
-- TOC entry 304 (class 1255 OID 17627)
-- Name: cargar_reporte(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_reporte(xid_empresa numeric, OUT reportes refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin

        numerror := 0;
        msjerror := ' ';

        open reportes for

        select
            e.id_empresa,
            e.nombre,
            d.dias_perdidos,
            d.fecha_ingreso,
            a.accidentes,
            a.fecha_ingreso
        from 
            empresa as e, diasperdidos as d, accidentabilidad as a
        where
            e.id_empresa = xid_empresa;
        exception
            when others then
                numerror := sqlstate;
                msjerror := '[busca_reportes] error al cargar el reporte(sql) ' ||sqlerrm;
                return;
    end;

$$;


ALTER FUNCTION public.cargar_reporte(xid_empresa numeric, OUT reportes refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 270 (class 1255 OID 17037)
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
-- TOC entry 252 (class 1255 OID 17314)
-- Name: cargar_tipo_link(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cargar_tipo_link(xid_tipo_link numeric, OUT tipo_links refcursor, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    numerror := 0;
    msjerror := ' ';
    begin
        open tipo_links for

            select
                id_tipo_link,
                des_tipo_link                
            from 
                tipo_link
                where
                    id_tipo_link = xid_tipo_link; 

            exception
                when others then
                    numerror := sqlstate;
                    msjerror := '[cargar_tipo_link  error al cargar tipo_link sql) ' ||sqlerrm;
                    return;	
    end;

end;

$$;


ALTER FUNCTION public.cargar_tipo_link(xid_tipo_link numeric, OUT tipo_links refcursor, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 222 (class 1255 OID 16643)
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
-- TOC entry 271 (class 1255 OID 17077)
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
-- TOC entry 223 (class 1255 OID 17168)
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
-- TOC entry 312 (class 1255 OID 17734)
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
-- TOC entry 224 (class 1255 OID 17100)
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
-- TOC entry 253 (class 1255 OID 17315)
-- Name: eliminar_link(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_link(xid_link numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            link
        where
            id_link = xid_link;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_link] error al eliminar link(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_link(xid_link numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 17141)
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
-- TOC entry 245 (class 1255 OID 16961)
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
-- TOC entry 275 (class 1255 OID 17114)
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
-- TOC entry 290 (class 1255 OID 17264)
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
-- TOC entry 302 (class 1255 OID 17357)
-- Name: eliminar_perfil_usuario(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_perfil_usuario(xidusuario numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            perfil_usuario
        where
            idusuario = xidusuario;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_perfil] error al eliminar perfil(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_perfil_usuario(xidusuario numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 17155)
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
-- TOC entry 265 (class 1255 OID 17022)
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
-- TOC entry 280 (class 1255 OID 17184)
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
-- TOC entry 266 (class 1255 OID 17038)
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
-- TOC entry 254 (class 1255 OID 17316)
-- Name: eliminar_tipo_link(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eliminar_tipo_link(xid_tipo_link numeric, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

	begin
		numerror := 0;
		msjerror := '';

		delete from
            tipo_link
        where
            id_tipo_link = xid_tipo_link;

		exception
			when others then
				numerror := sqlstate;
				msjerror := '[eliminar_tipo_link] error al eliminar tipo_link(sql) ' ||sqlerrm;
				return;	
	end;

$$;


ALTER FUNCTION public.eliminar_tipo_link(xid_tipo_link numeric, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 221 (class 1255 OID 16644)
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
-- TOC entry 293 (class 1255 OID 16889)
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
-- TOC entry 261 (class 1255 OID 17097)
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
-- TOC entry 241 (class 1255 OID 16831)
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
-- TOC entry 226 (class 1255 OID 17169)
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
-- TOC entry 283 (class 1255 OID 17188)
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
-- TOC entry 313 (class 1255 OID 17735)
-- Name: modificar_empresa(numeric, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, timestamp without time zone, timestamp without time zone, character varying, character varying, timestamp without time zone, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_empresa(xid_empresa numeric, xnum_adherente character varying, xnombre character varying, xcod_cartera character varying, xnom_experto character varying, xrazon_social character varying, xano_de_adhesion timestamp without time zone, xsegmentacion character varying, xholding character varying, xestrategica character varying, xsituacion character varying, xmulti_region character varying, xcasa_matriz character varying, xnum_centros_trabajo character varying, xmasa_sum_metropolitana character varying, xmasa_sum_nacional character varying, xplanes_de_cuenta character varying, xplanes_de_trabajo character varying, xfirma_de_planes character varying, xsistema_de_gestion character varying, xetapa_sistema_gestion character varying, xfirma_protocolo timestamp without time zone, xnum_cphs character varying, xnum_cphs_certificado character varying, xnum_cphs_bronce character varying, xnum_cphs_plata character varying, xnum_cphs_oro character varying, xprexor character varying, xprexor_etapa character varying, xprexor_texto character varying, xplanesi character varying, xplanesi_etapa character varying, xplanesi_texto character varying, xasbesto character varying, xasbesto_etapa character varying, xasbesto_texto character varying, xhipobaria character varying, xhipobaria_etapa character varying, xhipobaria_texto character varying, xradiaciones character varying, xradiaciones_etapa character varying, xradiaciones_texto character varying, xasma character varying, xasma_etapa character varying, xasma_texto character varying, xsolventes character varying, xsolventes_etapa character varying, xsolventes_texto character varying, xmetales character varying, xmetales_etapa character varying, xmetales_texto character varying, xoxido character varying, xoxido_etapa character varying, xoxido_texto character varying, xplaguicida character varying, xplaguicida_etapa character varying, xplaguicida_texto character varying, xpsicosociales character varying, xpsicosociales_etapa character varying, xpsicosociales_texto character varying, xmmc character varying, xmmc_etapa character varying, xmmc_texto character varying, xtmert character varying, xtmert_etapa character varying, xtmert_texto character varying, xradiacion_uv character varying, xradiacion_uv_etapa character varying, xradiacion_uv_texto character varying, xultima_visita_experto timestamp without time zone, xultima_visita_director timestamp without time zone, xultima_visita_gtte timestamp without time zone, xultima_visita_alta_gerencia timestamp without time zone, xreporte_visita character varying, xriesgo_de_fuga character varying, xreclamo_ultimo_periodo timestamp without time zone, xparticipacion_mesa_trabajo character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            empresa
        set 
			num_adherente=xnum_adherente,
			nombre=xnombre,
			cod_cartera=xcod_cartera,
			nom_experto=xnom_experto,
			razon_social=xrazon_social,
			ano_de_adhesion=xano_de_adhesion,
			segmentacion=xsegmentacion,
			holding=xholding,
			estrategica=xestrategica,
			situacion=xsituacion,
			multi_region=xmulti_region,
			casa_matriz=xcasa_matriz,
			num_centros_trabajo=xnum_centros_trabajo,
			masa_sum_metropilitana=xmasa_sum_metropolitana ,
			masa_sum_nacional=xmasa_sum_nacional ,
			planes_de_cuenta=xplanes_de_cuenta ,
			planes_de_trabajo=xplanes_de_trabajo,
			firma_de_planes=xfirma_de_planes,
			sistema_de_gestion=xsistema_de_gestion,
			etapa_sistema_gestion=xetapa_sistema_gestion,
			firma_protocolo=xfirma_protocolo,			
			num_cphs=xnum_cphs,
			num_cphs_certificado=xnum_cphs_certificado ,
			num_cphs_bronce=xnum_cphs_bronce,
			num_cphs_plata=xnum_cphs_plata,
			num_cphs_oro=xnum_cphs_oro,
			prexor=xprexor,
			prexor_etapa=xprexor_etapa,
			prexor_texto=xprexor_texto,
			planesi=xplanesi,
			planesi_etapa=xplanesi_etapa,
			planesi_texto=xplanesi_texto,
			asbesto=xasbesto,
			asbesto_etapa=xasbesto_etapa,
			asbesto_texto=xasbesto_texto,
			hipobaria=xhipobaria,
			hipobaria_etapa=xhipobaria_etapa,
			hipobaria_texto=xhipobaria_texto,
			radiaciones=xradiaciones,
			radiaciones_etapa=xradiaciones_etapa ,
			radiaciones_texto=xradiaciones_texto,
			asma=xasma,
			asma_etapa=xasma_etapa,
			asma_texto=xasma_texto,
			metales=xmetales,
			metales_etapa=xmetales_etapa,
			metales_texto=xmetales_texto,
			solventes=xsolventes,
			solventes_etapa=xsolventes_etapa,
			solventes_texto=xsolventes_texto,
			oxido=xoxido,
			oxido_etapa=xoxido_etapa,
			oxido_texto=xoxido_texto,
			plaguicida=xplaguicida,
			plaguicida_etapa=xplaguicida_etapa,
			plaguicida_texto=xplaguicida_texto,
			psicosociales=xpsicosociales,
			psicosociales_etapa=xpsicosociales_etapa,
			psicosociales_texto=xpsicosociales_texto,
			mmc=xmmc,
			mmc_etapa=xmmc_etapa,
			mmc_texto=xmmc_texto ,
			tmert=xtmert,
			tmert_etapa=xtmert_etapa ,
			tmert_texto=xtmert_texto,
			radiacion_uv=xradiacion_uv,
			radiacion_uv_etapa=xradiacion_uv_etapa,
			radiacion_uv_texto=xradiacion_uv_texto,
			ultima_visita_experto=xultima_visita_experto,
			ultima_visita_director=xultima_visita_director,
			ultima_visita_gtte=xultima_visita_gtte,
			ultima_visita_alta_gerencia=xultima_visita_alta_gerencia,
			reporte_visita=xreporte_visita,
			riesgo_de_fuga=xriesgo_de_fuga ,
			reclamo_ultimo_periodo=xreclamo_ultimo_periodo,
			participacion_mesa_trabajo=xparticipacion_mesa_trabajo

        where
            id_empresa = xid_empresa;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_empresa] error al modificar empresa(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_empresa(xid_empresa numeric, xnum_adherente character varying, xnombre character varying, xcod_cartera character varying, xnom_experto character varying, xrazon_social character varying, xano_de_adhesion timestamp without time zone, xsegmentacion character varying, xholding character varying, xestrategica character varying, xsituacion character varying, xmulti_region character varying, xcasa_matriz character varying, xnum_centros_trabajo character varying, xmasa_sum_metropolitana character varying, xmasa_sum_nacional character varying, xplanes_de_cuenta character varying, xplanes_de_trabajo character varying, xfirma_de_planes character varying, xsistema_de_gestion character varying, xetapa_sistema_gestion character varying, xfirma_protocolo timestamp without time zone, xnum_cphs character varying, xnum_cphs_certificado character varying, xnum_cphs_bronce character varying, xnum_cphs_plata character varying, xnum_cphs_oro character varying, xprexor character varying, xprexor_etapa character varying, xprexor_texto character varying, xplanesi character varying, xplanesi_etapa character varying, xplanesi_texto character varying, xasbesto character varying, xasbesto_etapa character varying, xasbesto_texto character varying, xhipobaria character varying, xhipobaria_etapa character varying, xhipobaria_texto character varying, xradiaciones character varying, xradiaciones_etapa character varying, xradiaciones_texto character varying, xasma character varying, xasma_etapa character varying, xasma_texto character varying, xsolventes character varying, xsolventes_etapa character varying, xsolventes_texto character varying, xmetales character varying, xmetales_etapa character varying, xmetales_texto character varying, xoxido character varying, xoxido_etapa character varying, xoxido_texto character varying, xplaguicida character varying, xplaguicida_etapa character varying, xplaguicida_texto character varying, xpsicosociales character varying, xpsicosociales_etapa character varying, xpsicosociales_texto character varying, xmmc character varying, xmmc_etapa character varying, xmmc_texto character varying, xtmert character varying, xtmert_etapa character varying, xtmert_texto character varying, xradiacion_uv character varying, xradiacion_uv_etapa character varying, xradiacion_uv_texto character varying, xultima_visita_experto timestamp without time zone, xultima_visita_director timestamp without time zone, xultima_visita_gtte timestamp without time zone, xultima_visita_alta_gerencia timestamp without time zone, xreporte_visita character varying, xriesgo_de_fuga character varying, xreclamo_ultimo_periodo timestamp without time zone, xparticipacion_mesa_trabajo character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 17101)
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
-- TOC entry 300 (class 1255 OID 17351)
-- Name: modificar_link(numeric, numeric, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_link(xid_link numeric, xid_tipo_link numeric, xurl_link character varying, xdes_link character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
            link
        set 
            des_link = xdes_link,
            url_link = xurl_link,
            id_tipo_link = xid_tipo_link
        where
            id_link = xid_link;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_link] error al modificar link(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_link(xid_link numeric, xid_tipo_link numeric, xurl_link character varying, xdes_link character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 17142)
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
-- TOC entry 231 (class 1255 OID 16959)
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
-- TOC entry 276 (class 1255 OID 17115)
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
-- TOC entry 240 (class 1255 OID 17268)
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
-- TOC entry 246 (class 1255 OID 17156)
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
-- TOC entry 259 (class 1255 OID 17023)
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
-- TOC entry 289 (class 1255 OID 17204)
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
-- TOC entry 267 (class 1255 OID 17039)
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
-- TOC entry 255 (class 1255 OID 17318)
-- Name: modificar_tipo_link(numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION modificar_tipo_link(xid_tipo_link numeric, xdes_tipo_link character varying, OUT numerror character varying, OUT msjerror character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

    begin
        numerror := 0;
        msjerror := '';

        update 
           tipo_link
        set 
            des_tipo_link = xdes_tipo_link
        where
            id_tipo_link = xid_tipo_link;

        exception
            when others then
                numerror := sqlstate;
                msjerror := '[modificar_medio] error al modificar medio(sql) ' ||sqlerrm;
                return; 
    end;
$$;


ALTER FUNCTION public.modificar_tipo_link(xid_tipo_link numeric, xdes_tipo_link character varying, OUT numerror character varying, OUT msjerror character varying) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 16893)
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
-- TOC entry 237 (class 1255 OID 16783)
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
-- TOC entry 242 (class 1255 OID 16846)
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
-- TOC entry 244 (class 1255 OID 16859)
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
-- TOC entry 202 (class 1259 OID 17561)
-- Name: accidentabilidad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE accidentabilidad (
    id_accidente integer NOT NULL,
    id_empresa integer NOT NULL,
    accidentes double precision NOT NULL,
    fecha_ingreso timestamp without time zone
);


ALTER TABLE public.accidentabilidad OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 17559)
-- Name: accidentabilidad_id_accidente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE accidentabilidad_id_accidente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accidentabilidad_id_accidente_seq OWNER TO postgres;

--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 201
-- Name: accidentabilidad_id_accidente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE accidentabilidad_id_accidente_seq OWNED BY accidentabilidad.id_accidente;


--
-- TOC entry 174 (class 1259 OID 16779)
-- Name: archivo_prueba; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE archivo_prueba (
    id integer NOT NULL,
    ruta character varying(100),
    nombre_archivo character varying(100)
);


ALTER TABLE public.archivo_prueba OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 16777)
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
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 173
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
-- TOC entry 182 (class 1259 OID 17081)
-- Name: cartera; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cartera (
    id_cartera integer NOT NULL,
    des_cartera character varying(200)
);


ALTER TABLE public.cartera OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 17079)
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
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 181
-- Name: cartera_id_cartera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cartera_id_cartera_seq OWNED BY cartera.id_cartera;


--
-- TOC entry 204 (class 1259 OID 17569)
-- Name: diasperdidos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE diasperdidos (
    id_dias integer NOT NULL,
    id_empresa integer NOT NULL,
    dias_perdidos integer NOT NULL,
    fecha_ingreso timestamp without time zone
);


ALTER TABLE public.diasperdidos OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17567)
-- Name: diasperdidos_id_dias_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE diasperdidos_id_dias_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.diasperdidos_id_dias_seq OWNER TO postgres;

--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 203
-- Name: diasperdidos_id_dias_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE diasperdidos_id_dias_seq OWNED BY diasperdidos.id_dias;


--
-- TOC entry 196 (class 1259 OID 17290)
-- Name: documento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documento (
    id_documento integer NOT NULL,
    nombre character varying(1000),
    num_folio character varying(100),
    num_adherente character varying(100),
    descripcion character varying(1000),
    id_cartera integer,
    id_producto integer,
    cod_area character varying(100),
    ruta character varying(200),
    fec_creacion timestamp without time zone,
    invalideces boolean,
    sami boolean,
    fatales boolean
);


ALTER TABLE public.documento OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 17288)
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
-- TOC entry 3154 (class 0 OID 0)
-- Dependencies: 195
-- Name: documento_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE documento_id_documento_seq OWNED BY documento.id_documento;


--
-- TOC entry 206 (class 1259 OID 17721)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE empresa (
    id_empresa integer NOT NULL,
    num_adherente character varying(200) NOT NULL,
    nombre character varying(200),
    cod_cartera character varying(200),
    nom_experto character varying(200),
    razon_social character varying(200),
    ano_de_adhesion timestamp without time zone,
    segmentacion character varying(200),
    holding character varying(200),
    estrategica character varying(200),
    situacion character varying(200),
    multi_region character varying(200),
    casa_matriz character varying(200),
    num_centros_trabajo character varying(200),
    masa_sum_metropilitana character varying(200),
    masa_sum_nacional character varying(200),
    planes_de_cuenta character varying(200),
    planes_de_trabajo character varying(200),
    firma_de_planes character varying(200),
    sistema_de_gestion character varying(200),
    etapa_sistema_gestion character varying(200),
    firma_protocolo timestamp without time zone,
    num_cphs character varying(200),
    num_cphs_certificado character varying(200),
    num_cphs_bronce character varying(200),
    num_cphs_plata character varying(200),
    num_cphs_oro character varying(200),
    prexor character varying(200),
    prexor_etapa character varying(200),
    prexor_texto character varying(200),
    planesi character varying(200),
    planesi_etapa character varying(200),
    planesi_texto character varying(200),
    asbesto character varying(200),
    asbesto_etapa character varying(200),
    asbesto_texto character varying(200),
    hipobaria character varying(200),
    hipobaria_etapa character varying(200),
    hipobaria_texto character varying(200),
    radiaciones character varying(200),
    radiaciones_etapa character varying(200),
    radiaciones_texto character varying(200),
    asma character varying(200),
    asma_etapa character varying(200),
    asma_texto character varying(200),
    solventes character varying(200),
    solventes_etapa character varying(200),
    solventes_texto character varying(200),
    metales character varying(200),
    metales_etapa character varying(200),
    metales_texto character varying(200),
    oxido character varying(200),
    oxido_etapa character varying(200),
    oxido_texto character varying(200),
    plaguicida character varying(200),
    plaguicida_etapa character varying(200),
    plaguicida_texto character varying(200),
    psicosociales character varying(200),
    psicosociales_etapa character varying(200),
    psicosociales_texto character varying(200),
    mmc character varying(200),
    mmc_etapa character varying(200),
    mmc_texto character varying(200),
    tmert character varying(200),
    tmert_etapa character varying(200),
    tmert_texto character varying(200),
    radiacion_uv character varying(200),
    radiacion_uv_etapa character varying(200),
    radiacion_uv_texto character varying(200),
    ultima_visita_experto timestamp without time zone,
    ultima_visita_director timestamp without time zone,
    ultima_visita_gtte timestamp without time zone,
    ultima_visita_alta_gerencia timestamp without time zone,
    reporte_visita character varying(200),
    riesgo_de_fuga character varying(200),
    reclamo_ultimo_periodo timestamp without time zone,
    participacion_mesa_trabajo character varying(200)
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17719)
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
-- TOC entry 3155 (class 0 OID 0)
-- Dependencies: 205
-- Name: empresa_id_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE empresa_id_empresa_seq OWNED BY empresa.id_empresa;


--
-- TOC entry 184 (class 1259 OID 17089)
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estado (
    id_estado integer NOT NULL,
    des_estado character varying(200)
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 17087)
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
-- TOC entry 3156 (class 0 OID 0)
-- Dependencies: 183
-- Name: estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estado_id_estado_seq OWNED BY estado.id_estado;


--
-- TOC entry 197 (class 1259 OID 17319)
-- Name: link; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE link (
    id_link integer NOT NULL,
    url_link character varying(200),
    des_link character varying(200),
    id_tipo_link numeric
);


ALTER TABLE public.link OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 17325)
-- Name: link_id_link_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE link_id_link_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.link_id_link_seq OWNER TO postgres;

--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 198
-- Name: link_id_link_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE link_id_link_seq OWNED BY link.id_link;


--
-- TOC entry 188 (class 1259 OID 17132)
-- Name: medios_respuesta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE medios_respuesta (
    id_medio_respuesta integer NOT NULL,
    des_medio_respuesta character varying(200)
);


ALTER TABLE public.medios_respuesta OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 17130)
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
-- TOC entry 3158 (class 0 OID 0)
-- Dependencies: 187
-- Name: medios_respuesta_id_medio_respuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE medios_respuesta_id_medio_respuesta_seq OWNED BY medios_respuesta.id_medio_respuesta;


--
-- TOC entry 186 (class 1259 OID 17105)
-- Name: motivo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE motivo (
    id_motivo integer NOT NULL,
    des_motivo character varying(200)
);


ALTER TABLE public.motivo OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 17103)
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
-- TOC entry 3159 (class 0 OID 0)
-- Dependencies: 185
-- Name: motivo_id_motivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE motivo_id_motivo_seq OWNED BY motivo.id_motivo;


--
-- TOC entry 193 (class 1259 OID 17226)
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE perfil (
    id_perfil integer NOT NULL,
    des_perfil character varying(25)
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 17224)
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
-- TOC entry 3160 (class 0 OID 0)
-- Dependencies: 192
-- Name: perfil_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE perfil_id_perfil_seq OWNED BY perfil.id_perfil;


--
-- TOC entry 194 (class 1259 OID 17250)
-- Name: perfil_usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE perfil_usuario (
    idusuario integer,
    id_perfil integer
);


ALTER TABLE public.perfil_usuario OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 17145)
-- Name: prioridad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE prioridad (
    id_prioridad integer NOT NULL,
    des_prioridad character varying(200)
);


ALTER TABLE public.prioridad OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 17143)
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
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 189
-- Name: prioridad_id_prioridad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE prioridad_id_prioridad_seq OWNED BY prioridad.id_prioridad;


--
-- TOC entry 178 (class 1259 OID 17009)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE producto (
    id_producto integer NOT NULL,
    des_producto character varying(200)
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 17007)
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
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 177
-- Name: producto_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE producto_id_producto_seq OWNED BY producto.id_producto;


--
-- TOC entry 175 (class 1259 OID 16835)
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincia (
    pro_nidprovincia numeric(15,5) NOT NULL,
    pro_snombre character varying(23),
    pro_nidregion numeric(15,5)
);


ALTER TABLE public.provincia OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 17170)
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
-- TOC entry 176 (class 1259 OID 16839)
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
-- TOC entry 180 (class 1259 OID 17050)
-- Name: tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo (
    id_tipo integer NOT NULL,
    des_tipo character varying(200)
);


ALTER TABLE public.tipo OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 17048)
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
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 179
-- Name: tipo_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_id_tipo_seq OWNED BY tipo.id_tipo;


--
-- TOC entry 199 (class 1259 OID 17327)
-- Name: tipo_link; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_link (
    id_tipo_link integer NOT NULL,
    des_tipo_link character varying(200)
);


ALTER TABLE public.tipo_link OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17330)
-- Name: tipo_link_id_tipo_link_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_link_id_tipo_link_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_link_id_tipo_link_seq OWNER TO postgres;

--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 200
-- Name: tipo_link_id_tipo_link_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_link_id_tipo_link_seq OWNED BY tipo_link.id_tipo_link;


--
-- TOC entry 170 (class 1259 OID 16658)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    idusuario integer NOT NULL,
    rut character varying(8) NOT NULL,
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
-- TOC entry 2956 (class 2604 OID 17564)
-- Name: id_accidente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY accidentabilidad ALTER COLUMN id_accidente SET DEFAULT nextval('accidentabilidad_id_accidente_seq'::regclass);


--
-- TOC entry 2944 (class 2604 OID 17332)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY archivo_prueba ALTER COLUMN id SET DEFAULT nextval('archivo_prueba_id_seq'::regclass);


--
-- TOC entry 2947 (class 2604 OID 17333)
-- Name: id_cartera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cartera ALTER COLUMN id_cartera SET DEFAULT nextval('cartera_id_cartera_seq'::regclass);


--
-- TOC entry 2957 (class 2604 OID 17572)
-- Name: id_dias; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY diasperdidos ALTER COLUMN id_dias SET DEFAULT nextval('diasperdidos_id_dias_seq'::regclass);


--
-- TOC entry 2953 (class 2604 OID 17334)
-- Name: id_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento ALTER COLUMN id_documento SET DEFAULT nextval('documento_id_documento_seq'::regclass);


--
-- TOC entry 2958 (class 2604 OID 17724)
-- Name: id_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empresa ALTER COLUMN id_empresa SET DEFAULT nextval('empresa_id_empresa_seq'::regclass);


--
-- TOC entry 2948 (class 2604 OID 17336)
-- Name: id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado ALTER COLUMN id_estado SET DEFAULT nextval('estado_id_estado_seq'::regclass);


--
-- TOC entry 2954 (class 2604 OID 17337)
-- Name: id_link; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY link ALTER COLUMN id_link SET DEFAULT nextval('link_id_link_seq'::regclass);


--
-- TOC entry 2950 (class 2604 OID 17338)
-- Name: id_medio_respuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY medios_respuesta ALTER COLUMN id_medio_respuesta SET DEFAULT nextval('medios_respuesta_id_medio_respuesta_seq'::regclass);


--
-- TOC entry 2949 (class 2604 OID 17339)
-- Name: id_motivo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY motivo ALTER COLUMN id_motivo SET DEFAULT nextval('motivo_id_motivo_seq'::regclass);


--
-- TOC entry 2952 (class 2604 OID 17340)
-- Name: id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfil ALTER COLUMN id_perfil SET DEFAULT nextval('perfil_id_perfil_seq'::regclass);


--
-- TOC entry 2951 (class 2604 OID 17341)
-- Name: id_prioridad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prioridad ALTER COLUMN id_prioridad SET DEFAULT nextval('prioridad_id_prioridad_seq'::regclass);


--
-- TOC entry 2945 (class 2604 OID 17342)
-- Name: id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY producto ALTER COLUMN id_producto SET DEFAULT nextval('producto_id_producto_seq'::regclass);


--
-- TOC entry 2946 (class 2604 OID 17343)
-- Name: id_tipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo ALTER COLUMN id_tipo SET DEFAULT nextval('tipo_id_tipo_seq'::regclass);


--
-- TOC entry 2955 (class 2604 OID 17344)
-- Name: id_tipo_link; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_link ALTER COLUMN id_tipo_link SET DEFAULT nextval('tipo_link_id_tipo_link_seq'::regclass);


--
-- TOC entry 3137 (class 0 OID 17561)
-- Dependencies: 202
-- Data for Name: accidentabilidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO accidentabilidad (id_accidente, id_empresa, accidentes, fecha_ingreso) VALUES (3, 2, 30, '2015-03-20 00:00:00');
INSERT INTO accidentabilidad (id_accidente, id_empresa, accidentes, fecha_ingreso) VALUES (2, 1, 30, '2015-03-20 00:00:00');
INSERT INTO accidentabilidad (id_accidente, id_empresa, accidentes, fecha_ingreso) VALUES (4, 3, 30, '2015-03-20 00:00:00');
INSERT INTO accidentabilidad (id_accidente, id_empresa, accidentes, fecha_ingreso) VALUES (5, 1, 50, '2015-04-20 00:00:00');
INSERT INTO accidentabilidad (id_accidente, id_empresa, accidentes, fecha_ingreso) VALUES (6, 2, 50, '2015-05-20 00:00:00');
INSERT INTO accidentabilidad (id_accidente, id_empresa, accidentes, fecha_ingreso) VALUES (7, 3, 50, '2015-05-21 00:00:00');


--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 201
-- Name: accidentabilidad_id_accidente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('accidentabilidad_id_accidente_seq', 6, true);


--
-- TOC entry 3109 (class 0 OID 16779)
-- Dependencies: 174
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
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (1, 'c:/archivo/', 'documento.xls');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (2, 'c:/archivo/', 'documento.xls');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (3, 'C:\archivos\Nuevo Microsoft Excel Worksheet.xls', 'Nuevo Microsoft Excel Worksheet.xls');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (4, 'C:\archivos', 'Nuevo documento de texto.txt');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (5, 'C:\archivos', 'Nuevo Microsoft Excel Worksheet.xls');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (6, 'C:\archivos', 'Nuevo Microsoft Word Document.doc');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (1227, 'asd', 'asd');
INSERT INTO archivo_prueba (id, ruta, nombre_archivo) VALUES (1228, 'asd', 'asd');


--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 173
-- Name: archivo_prueba_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('archivo_prueba_id_seq', 1228, true);


--
-- TOC entry 3103 (class 0 OID 16647)
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
INSERT INTO area (cod_area, des_area) VALUES ('TRANS', 'Transversal');


--
-- TOC entry 3117 (class 0 OID 17081)
-- Dependencies: 182
-- Data for Name: cartera; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cartera (id_cartera, des_cartera) VALUES (2, 'Cartera Telecomunicaciones');
INSERT INTO cartera (id_cartera, des_cartera) VALUES (4, 'Cartera Transversal');
INSERT INTO cartera (id_cartera, des_cartera) VALUES (1, 'Cartera Transporte Personas');
INSERT INTO cartera (id_cartera, des_cartera) VALUES (3, 'Cartera Transporte de Carga');


--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 181
-- Name: cartera_id_cartera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cartera_id_cartera_seq', 12, true);


--
-- TOC entry 3139 (class 0 OID 17569)
-- Dependencies: 204
-- Data for Name: diasperdidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO diasperdidos (id_dias, id_empresa, dias_perdidos, fecha_ingreso) VALUES (1, 4, 15, '2015-03-20 00:00:00');
INSERT INTO diasperdidos (id_dias, id_empresa, dias_perdidos, fecha_ingreso) VALUES (2, 4, 15, '2015-04-20 00:00:00');
INSERT INTO diasperdidos (id_dias, id_empresa, dias_perdidos, fecha_ingreso) VALUES (3, 2, 15, '2015-04-20 00:00:00');
INSERT INTO diasperdidos (id_dias, id_empresa, dias_perdidos, fecha_ingreso) VALUES (4, 2, 15, '2015-03-20 00:00:00');
INSERT INTO diasperdidos (id_dias, id_empresa, dias_perdidos, fecha_ingreso) VALUES (5, 4, 15, '2015-03-21 00:00:00');
INSERT INTO diasperdidos (id_dias, id_empresa, dias_perdidos, fecha_ingreso) VALUES (6, 2, 15, '2015-02-21 00:00:00');


--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 203
-- Name: diasperdidos_id_dias_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('diasperdidos_id_dias_seq', 4, true);


--
-- TOC entry 3131 (class 0 OID 17290)
-- Dependencies: 196
-- Data for Name: documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (67, 'LEGAL011.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (141, 'SSOMAANEXO 11.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (369, 'PROCEPROCESO FACTURACION.HTM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (523, 'ILDCIRCULAR 2399.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (626, 'SALUDENCUESTA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (1, 'SSOMAANEXO VII 2611 ACCIONES ADOPTADAS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (2, 'PROCEPROC BAJA DE VEHICULOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (3, 'PROCENORMA RESPALDO TI 2009.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (4, 'LEGALCONTINGENCIAS JUDICIALES  003 .PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (5, 'SSOMAPROTOCOLO SINDROME TUNEL CARPIANO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (6, 'SALUDNOTA INFORMATIVA SEGURIDAD CIPROFLOXACINO FLUOROQUINOLONAS SEPT 2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (7, 'SALUDINFORME TIPO EVALUACION AUDIOLOGICA PEECCA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (8, 'LEGALINSTRUCTIVO CESANTIA 001.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (9, 'DESARMUT CAPITULO 7.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (10, 'PROCEPROCEDIMIENTO DE MANEJO DE REAS CAS RED MUTUAL DE SEGURIDAD.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (11, 'SSOMAMATRIZ DE RIESGOS RETAIL- DIRECTOR PEDRO MALDONADO.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (12, 'SSOMAR-COM-07 SEGUIMIENTO Y CONTROL.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (13, 'SSOMACONTENEDOR CON PLACAS DE GRANITO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (14, 'PROCEDIAGRAMA_1.HTM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (15, 'SSOMAEDUCA-SS 2013-FORM.  AUDITORIA.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (16, 'SSOMA2. CARTA DE INGRESO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (17, 'SSOMAEDUCA-SS -  TABLA DIAS CARGO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (18, 'SEGUR2003 CIRCULAR 1974 DEL 77 BIS (2002).DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (19, 'SSOMACOLUMNA.PPS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (20, 'PROCEAPE 1.4 V 1.3 NORMA ALMACENAMIENTO MATERIAL ESTERIL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (21, 'SSOMAANEXO 5.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (22, 'SSOMAANEXOS EQUIPOS MDT NACIONAL (OCT 2014).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (23, 'SSOMA1. EMPRESA CIERRE SIO2 (MENOS 30).DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (24, 'PROCEGCL 3.2 NORMA SISTEMA VIGILANCIA IAAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (25, 'SSOMAPEC COMPETITIVA-INDUSTRIA-2013.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (26, 'SSOMAEDUCA-SS -  ACTA COMITE DIRECTIVO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (27, 'SSOMAEDUCA-SS -  FORMULARIO DE INVESTIGACION.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (28, 'SALUDFICHA TECNICA EQUIPO R12 MOD.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (29, 'SALUDORGANIGRAMA CENTRO PEECCA PUNTA ARENAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (30, 'PROCECOBRANZA LEY.HTM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (31, 'ILDANEXO 4 - GUIA PARA FORMULACION DE PREPROYECTOS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (32, 'SALUDGUIA EPT.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (33, 'SSOMAEDUCA-SS -  FORMULARIO DE INDUCCION.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (664, 'SSOMACIRC 2611.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (34, 'PROCELABORATORIO, COMPLETAR DIAGNOSTICO CON ESTUDIO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (35, 'SSOMACIR 2838 DE SUSESO 29 06 12.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (36, 'SALUDNOTA INFORMATIVA SEGURIDAD PARACETAMOL SEPT 2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (37, 'SSOMAFORMATO LISTADO DE EMPRESAS EN PVET V02.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (38, 'SSOMATRIPTICO CUIDADO DE LA VOZ_TRAZO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (39, 'PROCEN- ACETILCISTEINA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (40, 'PROCEPROCEDIMIENTO REALIZAR TRIAGE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (41, 'SSOMAPLAN DE RIESGOS PSICOSOCIALES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (42, 'ADMININSTRUCTIVO ACTIVO FIJO EN AGENCIAS 2010.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (43, 'PROCEDEFAULT.HTM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (44, 'SALUDSOLICITUD EA PEECCA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (45, 'PROCEOKGCL 3.3 NORMA PREV NEUMONIA NOSOCOMIAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (46, 'PROCEDP 1.1 NORMA DIFUSIN DERECHOS Y DEBERES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (47, 'INVALIDECESTRANSPORTES COMETA 2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (48, 'PROCEGCL 1.2 PROCEDIMIENTO ADM. DE MED. ENDOVENOSOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (49, 'SSOMAFAP ASBESTO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (50, 'SSOMACIIU CL CLASIFICADOR ACTIV ECONOM.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (51, 'SALUDMANUAL DE PROCEDIMIENTOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (52, 'SSOMA1. FAP ASBESTO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (53, 'SALUDTALLER MOTIVACIONALES (ANEXO 1).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (54, 'SSOMAMANUAL USUARIO COLUMNA OK.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (55, 'PROCEMEMANTINA CLORHIDRATO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (56, 'SSOMA11. MANUAL LIMIPIEZA DE CICLONES (V1 2013).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (57, 'SSOMAEDUCA-SS 2013-DESC. PROGRAMA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (58, 'ILDINSTRUCTIVO PARA EL LLENADO DEL FORMULRIO EVISSO 20080103.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (59, 'PROCEEMITIR FACTURA NORMAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (60, 'PROCEPROCEDIMIENTO EVALUACIONES PRE Y OCUPACIONALES EN EL CET;V1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (61, 'SSOMAFLUJOGRAMA DE ACTUACION FAP 3-09-13.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (62, 'SSOMAPROCESO ACC FATALES CIRC 2611 OCT 2014.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (63, 'PROCEPROCEDIMIENTO ENTREGAR MEDICAMENTOS A HOSPITALIZADOS V01 ANEXO 1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (64, 'PROCEPROC ASIGN Y REEMPLAZO DE VEHIC A LOS COLAB DE MUTUAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (65, 'PROCEPREPARAR PACIENTE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (66, 'SSOMAEPT_ HOMBRO_.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (68, 'PROCEGCL 1.2 V 1.1 NORMA ADM. MED. ENDOVENOSOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (69, 'LEGALINSTRUCTIVO SEGURO CESANTIA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (70, 'PROCEFORMULARIO CONSENTIMIENTO INFORMADO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (71, 'PROCEACIDO ACETIL SALICILICO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (72, 'SEGURPROCESO VIGILANCIA CASOS 104 SEM. PENSIONES TRANSITORIAS.2009.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (73, 'SALUDNOTA INFORMATIVA SEGURIDAD SOBRE KETOCONAZOL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (74, 'SSOMAANEXO II 2611 NOT PROVISORIA INMEDIATA PARA SISESAT.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (75, 'DESARTRIPTICO HORA EXAMENES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (76, 'DESARNORMATIVA DOCUMENTOS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (77, 'PROCESOLICITAR CUPO INTERNO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (78, 'SSOMAANEXO 2.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (79, 'SALUDNOTA_INFORMATIVA_PROFESIONALES_HIALURONICO_INY.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (80, 'INVALIDECESTURBUS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (81, 'SALUDINFORME CONSOLIDADO DE NO CONFORMIDADES ORIGINAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (82, 'PROCEANEXO 5 EXIGENCIAS BONOS EXTERNOS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (83, 'SSOMA4. PROTOCOLO DE VIGILANCIA TRABAJADORES EXPUESTOS-TMERT-EESS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (84, 'INVALIDECESEXPRESS STGO.1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (85, 'SALUDCONDICIONES SUJETO DE PRUEBA MDT EA 02 R8 2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (86, 'LEGALPCI_FIS_022006 (5).DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (87, 'SALUDENCUESTA SEGUIMIENTO PROGRAMA CRONICOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (88, 'SSOMALISTA CHEQUEO ABREVIADA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (89, 'ILDANEXO 5 - GUIA PARA FORMULACION DE PROYECTOS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (90, 'DESARMUT CAPITULO 0 Y 1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (91, 'PROCEANEXO 2.A REQUISITOS PARA INDEPENDIENTES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (92, 'PROCEDP 4.1 V 1.1 CONVENIO DOCENTE ASISTENCIAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (93, 'SSOMAPERDER EQUILIBRIO Y CAER DE ESCALA DE MANO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (94, 'LEGALALCALDE 01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (95, 'SALUDFICHA TECNICA EQUIPO R6 3.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (96, 'SALUDMANUALTMV4_2.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (97, 'INVALIDECESPROACTIVA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (98, 'SSOMAPROTOCOLO PEC COMPETITIVA 2013.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (99, 'PROCEPROGRAMA ASMA V 1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (100, 'INVALIDECESTURBUS2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (101, 'SSOMAPROTOCOLO EPICONDILITIS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (102, 'SSOMAPEC COMPETITIVA-DESCRIPCION DE CAMBIOS-A2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (103, 'PROCEDESPACHAR FACTURA POR MANO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (104, 'SSOMA0J. PROC. PREPARACION Y RESPUESTA ANTE EMERGENCIAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (105, 'ADMINMANUAL DE SUBSIDIOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (106, 'INVALIDECESALSACIA 2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (107, 'SSOMAPROTOCOLO EDUCA-SS.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (108, 'PROCEAPT 1. 2 NORMA UNIDAD DE TRANSPORTE DE PACIENTES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (109, 'SSOMATABLA.HTML', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (110, 'PROCEANEXO 2 - CUENTAS CENTRALIZADAS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (111, 'PROCEANEXO 3 - FORMATO CARGA CUENTAS CENTRALIZADAS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (112, 'ILDANEXO 3 - INFORME DE AVANCE.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (113, 'SALUDMIRENA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (114, 'ILDLEY SUBCONTRATACION  Y LA GESTION DE SEGURIDAD Y SALUD OCUPACIONAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (115, 'DESAREXAMEN PREOCUPACIOALES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (116, 'PROCEFONDOS FIJOS_V1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (117, 'PROCEPRO SUBSIDIOS NACIONALES_V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (118, 'INVALIDECESEXPRESS SANTIAGO UNO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (119, 'SSOMACORR ADH EMPRESA FRIO &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (120, 'DESARPROTOCOLO MUTUAL DE SEGURIDAD.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (121, 'SSOMAPROCEDIMIENTO INGRESO ESPONTANEO A PVET V_02.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (122, 'PROCEPP PROCEDIMIENTO MANEJO DE RESIDUOS 2012.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (123, 'DESARMUT CAPITULO 6.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (124, 'SSOMA09 FORM MATRIZ DE REQUISITOS LEGALES.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (125, 'SSOMAREGLA EDUCA-SS = SAP107600250.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (126, 'PROCESOLICITAR IMAGEN PACIENTE SIN CAMILLA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (127, 'SSOMAINFORME_PEC-ESTANDAR_2012.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (128, 'DESARMUT CAPITULO 8.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (129, 'INVALIDECESRENTA EQUIPOS BESALCO 1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (130, 'SSOMAEDUCA-SS -  ENTREVISTA AL ACCIDENTADO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (131, 'PROCEFORMATO LISTADO MAESTRO PROV.A EVALUAR;V02.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (132, 'SSOMAMATRIZ DE RIESGO GENERICA TMERT EESS MINSAL.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (133, 'SSOMAPROTOCOLO PEC ESTANDAR 2010.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (134, 'SALUDTALLER FENIX (ANEXO 3).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (135, 'DESARTRIPTICO SUBSIDIOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (136, 'SSOMAMANUAL DE MUESTREO MERCURIO EN AIRE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (137, 'SSOMAPEC COMPETITIVA-PRES. CAMBIOS-A2013.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (138, 'PROCEDESPACHAR FACTURA DE PACIENTES SOAP.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (139, 'SSOMACORR ADH EMPRESA MET &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (140, 'LEGALARRENDAMIENTO ESTACIONAMIENTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (142, 'SSOMAMANEJO VOCAL POR MEDICINA DEL TRABAJO AGENCIAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (143, 'SALUDSOLICITUD DE DOCUMENTACION - INSCRIPCION REGISTRO NACIONAL DE LA DISCAPACIDAD.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (144, 'PROCEGCL 1. 2  V 1.1 PROCEDIMIENTO CURACIONES EN LA RED.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (145, 'SSOMAGOLPEADO POR CAMION EN CAMARA DE COMUNICACION.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (146, 'SSOMAVALCAMIENTO HACIA COSTADO DE LA VIA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (147, 'ADMINFORMATO PEP.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (148, 'PROCEELABORAR PRESUPUESTO ANUAL_V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (149, 'PROCEANEXO 2 SOLICITUD INDEPENDIENTE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (150, 'PROCEENVIAR FACTURAS DE PACIENTES NAT-77BIS- NET.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (151, 'SSOMA05 FORM. CONTROL DE INGRESO DE COMUNICACIONES.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (152, 'PROCEAPI 12 PROCEDIMIENTO MIELOCISTERNOTAC4802344.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (153, 'PROCEANEXO 3- FORMULARIO INSCRIPCION GESCAP;V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (154, 'ADMINFORMATO IAT.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (155, 'SSOMAPROTOCOLO VIGILANCIA PLAGUICIDAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (156, 'SSOMAPROTOCOLO TENOSINOVITIS DE QUERVAIN.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (157, 'SSOMACORR ADH EMPRESA RADION &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (158, 'SSOMA6. INSTRUCTIVO PARA LA MEDICION DE RUIDO OCUPACIONAL ISP.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (159, 'PROCEPRO COBROS DE ORGANISMOS SALUD V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (160, 'SSOMACIRC 2893 MEDIDAS INMEDIATAS AMPUTACIONES.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (161, 'SSOMABROCHURE PEC= SAP 107300208-11-12.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (162, 'PROCEPRESENTACION DR. OMAR ATENAS V..PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (163, 'SSOMAFORMATO VERSION BREVE.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (164, 'SSOMA02.- ISP MANUAL DE USO DICIEMBRE 2012-FINAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (165, 'PROCESOLICITAR CUPO EXTERNO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (166, 'ADMINPROGR_ACTIVIDADES_CIERRES_MENSUALES_TARIFICACION_ABRIL_2011.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (167, 'SSOMAANEXO V 2611 INFORME DEL ACCIDENTE PARA SISESAT.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (168, 'PROCECOTROL Y PROVEEDORES .HTM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (169, 'ADMINPLAN_CUENTAS_MUTUAL.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (170, 'SSOMA9. MANUAL DE MUESTREO SIO2 Y POLVO RESPIRABLE (V2).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (171, 'SSOMACARTILLA TERRENO. ALZAMIENTO INDIVIDUAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (172, 'SSOMAAIDEP Y ACCEDER.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (173, 'SSOMAPEC EMPRESA ESTANDAR - DOC 05 FORMULARIOS DE REGISTRO E0707.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (174, 'SSOMAEDUCA-SS 2013-PRESENTACION PROGRAMA.PPTX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (175, 'SSOMA1. RESOL 1052 MINSAL NORMA TECNICA PREXOR.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (176, 'PROCEREFACTURAR.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (177, 'SSOMAPEC COMPETITIVA-REQUISITOS-2013A.PPTX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (178, 'SALUDCIRC. EBOLA PRECAUCIONES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (179, 'SALUD2 IMPEDANCIOMETRIA R 1.5.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (180, 'SSOMAEJERCICIOS DURANTE LA JORNADA LABORAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (181, 'PROCE2013 CAL 1.2 POLITICA ITEGRADA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (182, 'PROCECONTROL EXISTENCIAS NO SUJETAS A CONTROL LEGAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (183, 'SSOMARECOMENDACIONES  USO DE CAPACHOS EN AGRICULTURA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (184, 'SSOMA7. FORMATO CATASTRO PLAGUICIDAS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (185, 'SSOMA17 FORM. MATRIZ IPER.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (186, 'SEGURFORMATO PAT.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (187, 'INVALIDECESBUSES VULE 2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (188, 'PROCEANEXO 4. FORMULARIO TIPO DE RESPUESTA.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (189, 'SSOMAD.S. 101.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (190, 'SSOMA0F. PROC. INVESTIGACION DE INCIDENTES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (191, 'SSOMAVOLCAMIENTO DE VEHICULO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (192, 'SSOMAMATRIZ  DE RIESGOS MUNICIPIOS- DIRECTORA CAROLINA MERINO.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (193, 'SSOMAELECTROCUCION AL RETIRAR EXTENSION ELECTRICA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (194, 'PROCERECOMENDACIONES PARA LOS INVESTIGADORES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (195, 'SSOMAPLAN NACIONAL SILICOSIS (MINSAL-MTPS).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (196, 'LEGALPRESTACION DE SERVICIOS DE ESTERILIZACION.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (197, 'PROCEAPL 1.5 MANUAL BIOSEGURIDAD VERSION 5 DICIEMBRE 2012.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (198, 'DESARPATRON_CARATULACDINTERIOR.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (199, 'PROCEANEXO 1 SOLICITUD EMPRESA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (200, 'PROCEONABOTULINUMTOXIN A.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (201, 'SALUDNOTA INFORMATIVA_FINASTERIDA Y DUTASTERIDA DIRIGIDA A MEDICOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (202, 'SSOMADERMATITIS CONTACTO 2012.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (203, 'PROCEPROC SOLICITAR Y EFECTUAR LOS VIAJES DEL PERSONAL;V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (204, 'SSOMADECRETO 28, OFICIAL 2012 MINSAL MODIFICA DS 594.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (205, 'LEGALACTA DE ENTREGA OBRA CONSTRUIDA.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (206, 'SSOMAPEC COMPETITIVA-INSTRUMENTO AUDITORIA MINERIA-2010.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (207, 'PROCEOPTIMIZAR USO DE BIENES NO OPERACIONALES;V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (208, 'SSOMAAJUSTE SU PUESTO DE TRABAJO CON NOTEBOOKFAP 001-168.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (209, 'SSOMACIRCULAR 2893 SUSESO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (210, 'PROCEANEXO 2 - SOLICITUD DE FONDOS POR RENDIR.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (211, 'DESARLOGO MUTUAL VERSIONES.FH10', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (212, 'SALUDVARENICLINA - BUPROPION ALERTA AGOSTO 2009.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (213, 'SSOMADIPTICO EDUCA-SS = SAP107300165.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (214, 'PROCEREG 1.3 .PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (215, 'SSOMAANAMIO EN OBRA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (216, 'PROCEINGRESAR PACIENTE INDIRECTO DIFERIDO URGENTE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (217, 'SSOMAMANUAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (218, 'LEGALPRESTACION DE SERVICIOS DE SALUD.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (219, 'SSOMAEPT CODO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (220, 'SSOMAEDUCA-SS 2013-PRESENTACION CAMBIOS.PPTX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (221, 'INVALIDECESEXPRESS SANTIAGO UNO_2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (222, 'PROCEDESPACHAR FACTURA POR EMPRESA EXTERNA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (223, 'PROCEANEXO 9 RESOLUCION RECHAZO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (224, 'SALUDELABORACION Y DESPACHO EA PEECCA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (225, 'INVALIDECESBUSES VULE 1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (226, 'ILDANEXO 2 - FORMULARIO DE PRESENTACION DE PROYECTOS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (227, 'SALUDMANEJO MAL DE ALTURA 2012.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (228, 'SSOMA0G. PROC. IPER.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (229, 'ILDEVISSO21022008.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (230, 'PROCEAPI 13 NORMA REQUISITOS QUE DEBEN CUMPLIR SOLICITUDES DE EXMENES IMAGENOLGICOS1210543.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (231, 'SSOMACAIDA DE PLANCHA TRASLUCIDA TECHUMBRE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (232, 'SSOMACIRC 2893 INFORME DEL ACCIDENTE CAUSAS Y MEDIDAS AMPUTACIONES.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (233, 'SSOMA00A. DESCRIPCION PROGRAMA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (234, 'SEGURCERTIFICADO DE REMUNERACIONES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (235, 'INVALIDECESKDM.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (236, 'LEGAL004.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (237, 'DESARNORMATIVA DE COLORES INTERIORES.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (238, 'PROCERESPUESTA DE REQUERIMIENTO;V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (239, 'SSOMAEDUCA-SS -  ENTREGA EPP.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (240, 'SALUDINSCRIPCION REGISTRO NACIONAL DE LA DISCAPACIDAD.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (241, 'SSOMAEJEMPLO - CERTIFICADO PEC [COMPETITIVA].PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (242, 'SSOMAMANUAL PLAN INTEGRAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (243, 'SSOMALEY-19404.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (244, 'SSOMAMATRIZ RIESGO (ACT 06-2011).XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (245, 'SALUDMEDICAMENTO_RIESGO_EMBARAZO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (246, 'ILDDIRECTIVAS DEL  OIT.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (247, 'PROCESOLICITUD DE EVALUACION DE PROYECTOS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (248, 'SSOMAMEDIDAS DE CONTROL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (249, 'SSOMAPROTOCOLO PEC-ESTANDAR- EMP. PRINCIPAL .PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (250, 'SALUDNOTA SEGURIDAD DRONEDARONA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (251, 'SSOMAGOLPEADO POR ESCOMBROS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (252, 'ADMINPROCEDIMIENTO INCORPORACION DE SUCURSALES TEMPORALES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (253, 'SSOMAPLANTA MOVIL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (254, 'SSOMAANEXO 3 - ENCUESTA TRABAJADORES EMPRESA PRINCIPAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (255, 'SSOMAANEXO VI 2611 CUMPLIMIENTO MEDIDAS PRESCRITAS PARA SISESAT.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (256, 'SALUDACCIONES CORRECTIVAS V2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (257, 'DESARICONOPDF.JPG', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (258, 'LEGALCONTRATO LAVADO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (259, 'DESARMUT CAPITULO 2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (260, 'SSOMA0K. PROC. REQUISITOS LEGALES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (261, 'DESAREXAMENES PORTAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (262, 'SALUDPROTOCOLO DEDOS EN RESORTE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (263, 'LEGAL1-WFCLIENT(USUARIO FINAL).PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (264, 'SSOMA2. CARTILLA DE BOLSILLO RIESGOS PSICOSOCIALES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (265, 'SSOMACONFIGURE SU PUESTO DE TRABAJO FAP 006-173.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (266, 'ADMINPROCEDIMIENTO CERTIFICADO DE ADHESION A TRAVES DEL PORTAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (267, 'PROCEAPTR 1.3 APCS 1.4 APDS 1.2 TRAZABILIDAD DE LOS HEMOCOMPONENETES V 2 0 OK .PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (268, 'SALUDIND MEDICA MDT EA O4 R3 2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (269, 'ADMINPROGR_ACTIVIDADES_CIERRES_MENSUALES_LOGISTICA ABRIL_2011.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (270, 'SSOMAINSTRUCTIVO CARTILLAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (271, 'PROCEAPL 1 3 APL 1 4 PROCEDIMIENTO  Y PROTOCOLOS DE CONTROL DE CALIDAD INTERNO Y EXTERNO BANCO DE SANGRE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (272, 'PROCEDESPACHAR FACTURA POR CORREO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (273, 'ADMINAPOYO_CONTABLE-TRIBUTARIO.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (274, 'PROCERH 4.1 PROGRAMA SALUD LABORAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (275, 'SALUDCHEQUEO RUTINARIO R 5.7.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (276, 'PROCEAPE 1.5 PROCEDIMIENTO DAN.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (277, 'SSOMAMANUAL DE PROCEDIMIENTO PVA RUIDO  V2-11DIC2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (278, 'SSOMAALCANCES Y APLICACION FAP 1- 119-09-13.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (279, 'SSOMAADH  RAZON SOCIAL CENTRO TRABAJO RUI VERCUM (V2) &EXP.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (280, 'PROCEAPF 1.5 V 1.0 NORMA GESTION DE MEDICAMENTOS CONTROLADOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (281, 'INVALIDECESTRANSPORTES COMETA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (282, 'PROCENORMA RESPALDO V8 4.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (283, 'SSOMA4. EMPRESA  VERCUM SIO2 PNC &PRP.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (284, 'SALUDALERTA  PIOGLITAZONA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (285, 'INVALIDECESMEMORANDUM INTERNO MENSAJERIA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (286, 'SALUDMANEJO VOCAL POR MEDICINA DEL TRABAJO AGENCIAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (287, 'ADMINMANUAL DESARROLLO Y PROECTOS DE CONSTRUCCION .DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (288, 'SALUDFICHA TECNICA EQUIPO R11.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (289, 'PROCEAPE 1.5 NORMA DAN.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (290, 'PROCEAPL 1.2 V 3.2 MANUAL TOMA MUESTRAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (291, 'SSOMAINFORME_PEC-ESTANDAR_2012.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (292, 'LEGAL004.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (293, 'SALUDBESTPHARMA ISP JULIO 2008.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (294, 'PROCEAPI 1.2 PROCEDIMIENTO ARTORTAC ARTRORNM.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (295, 'ADMINFORMATO PAT.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (296, 'SSOMAPEC-ESTANDAR - EVALUACION DS76 - CONTRATISTA OD7600212.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (297, 'PROCEPROCESO DE CAMPO CLINICO .HTM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (298, 'SSOMACORR ADH EMPRESA ESTTER &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (299, 'SSOMABANDERERO ATROPELLADO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (300, 'INVALIDECESEXPRESS STGO 2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (301, 'PROCEHOJA DE DATOS EQUIPOS V2.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (302, 'SEGURFORMATO PEP.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (303, 'SEGURFORMATO IAT.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (304, 'SSOMAMOD 594 HIPOBARIA_08-NOV-2012.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (305, 'PROCEPROC GESTION DE SEGUROS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (306, 'PROCECERTIFICADO DR. HAYDEN  DP 1.3 INVESTIGACIONES EN SERES HUMANOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (307, 'SSOMAINFOSEGURIDAD.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (308, 'SSOMA3. EMPRESA SIO2 PNC &PRP.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (309, 'SALUDORGANIGRAMA DEL CENTRO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (310, 'PROCEANEXO 3 PLANILLA DE BONOS EXTERNOS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (311, 'ADMINMANUAL DE SEGURIDAD C.CH.C.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (312, 'SSOMAANEXO 4.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (313, 'SSOMAINSTALADOR.EXE', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (314, 'PROCEPROCEDIMIENTO RENUNCIA DE EMPRESAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (315, 'SSOMA4. GUIA SELECCION Y CONTROL DE ELEMENTOS PROTECCION AUDITIVA ISP.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (316, 'PROCEINS V 2.0 PLAN DE EMERGENCIA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (317, 'PROCEFONDOS POR RENDIR; V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (318, 'SALUDTRANSICION (ANEXO 6).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (319, 'PROCEANEXO 8 RESOLUCION ACEPTACION.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (320, 'SSOMANUEVO INSTRUCTIVO TOMA DE MUESTRAS BIOLOGICAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (321, 'SSOMAPEC COMPETITIVA-SERVICIO-2013.ZIP.IVH1ZE1.PARTIAL', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (322, 'SALUDINFORME DE ACCIONES CORRECTIVAS PREVENTIVAS ORIG.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (323, 'PROCEREG 13 ENTREGA DE INFORMES ESCRITOS AL PACIENTE PRESTACIONES REALIZADAS E INDICACIONES9679080.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (324, 'SSOMACORTES ESTRUCTURAS METALICAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (325, 'SSOMAGUIA_TECNICA 2011.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (326, 'PROCEGCL 1.3 PROTOCOLO MANEJO DEL DOLOR AGUDO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (327, 'SSOMAINHALACION DE MONOXIDO DE CARBONO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (328, 'INVALIDECESKDM S.A..PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (329, 'PROCEANEXO 4 - FORMATO PLANILLA REGISTRO ASISTENCIA_V01.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (330, 'ADMINANEXO-GLOSAS-CTAS-GASTOS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (331, 'SSOMAPROTOCOLO PEC EXCELENCIA 2014.PPTX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (332, 'SSOMA10. MANUAL DE PROCEDIMIENTO DE PVA SILICE (V1).DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (333, 'SSOMAINSTALAR_EVA_EPT.EXE', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (334, 'SSOMAMAHO VERSION PARA EMPRESAS  V2011.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (335, 'LEGAL005.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (336, 'INVALIDECESTRANSP. LASAMA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (337, 'LEGALRESCILIACION Y FINIQUITO  DE CONTRATO DE ARRENDAMIENTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (338, 'SALUDBANCHILE CONVENIO FIRMADO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (339, 'SSOMA00B. REGLAMENTO DE DISTINCION Y PREMIACION.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (340, 'SALUDPROTOCOLO EPICONDILITIS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (341, 'SSOMADESCARGA ELECTRICA .PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (342, 'PROCEPRO RECUPERO SOAP ZONAL NORTE Y CENTRO V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (343, 'SSOMAINFORME DE DESCARTE DE EXPOSICION A RUIDO SOBRE CRITERIO DE ACCION.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (344, 'INVALIDECESMEMORANDUC INERNO CCU.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (345, 'SALUDPROCEDIMIENTO CONVENIO ATENCION PRIVADA - GRUPO SANTANDER.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (346, 'ILDREGLAMENTO DS 319.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (347, 'SSOMAFAPEP OP CARNICAS 107400432.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (348, 'SSOMAFORMULARIO ANALISIS CAUSAL V3.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (349, 'SSOMAFORMATO TOMA DECLARACION.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (350, 'PROCEPRO INDEMNIZACIONES_V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (351, 'PROCEREG 12 NORMA ESTANDARIZACION REGISTROS CLNICOS941726.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (352, 'SSOMA2009.08 COMICS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (353, 'SEGUR2003 ORD DE LA SUSESO 522.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (354, 'LEGALCOMODATO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (355, 'LEGAL3-WFCLIENT(USUARIO FINAL).PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (356, 'SALUDNOTA INFORMATIVA SEGURIDAD PRODUCTOS CONTIENEN HIDROXIETILALMIDON.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (357, 'SEGURFORMATO PF.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (358, 'SALUDNOTA DE SEGURIDAD - DEXRAZOXANO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (359, 'LEGALMEMO ANEXO 1 CONTRATO2006.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (360, 'SSOMA3. MANUAL PLAN DE TRABAJO MCA - P.2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (361, 'SALUDPROTOCOLO SINDROME TUNEL CARPIANO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (362, 'SSOMAEDUCA-SS -  PROGRAMA TRABAJO CPHS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (363, 'PROCEV1.2 SISTEMA DE SEGUIMIENTO DE VIDA UTIL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (364, 'SALUDINHIBIDORES_BOMBA_PROTONES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (365, 'ADMINMUSE_FIN.CHM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (366, 'PROCEAPE 1.5 AC PROCEDIMIENTO DAN.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (367, 'SALUDZODOL GOTAS RETIRO LOTE PRECIPITADO AGOSTOS 2009.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (368, 'SSOMA3. MATRIZ PSSO PVRS MUSA MAJLUF.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (370, 'ILDREGLAMENTO INTERNO DE ORDEN IGIENE Y SEGURIDAD1 .DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (371, 'SEGURFORMATO IEP.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (372, 'ILDLEY SUBCONTRATACION DIRECTORIO NOVIEMBRE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (373, 'SSOMAFORMATO CADENA CUSTODIA CESMEC.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (374, 'SSOMAANEXO 3 - ENCUESTA EMPRESA PRINCIPAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (375, 'SSOMAANEXO 10.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (376, 'SSOMA14 FORM. LISTADO DE AUDITORES VIGENTES Y CALIFICADOS.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (377, 'SSOMA7. LEY DE SEGURIDAD NUCLEAR -18302_02-MAY-1984.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (378, 'SSOMAELECTROCUCION AL INTERVENIR EN CELDA DE ACOMATIDA EXTERNA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (379, 'SSOMAPLANTILLA BOLETIN INFORMATIVO ACCIDENTE GRAVE V.2014.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (380, 'SSOMAPIEZA DE HORMIGON.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (381, 'PROCELABETALOL CLORHIDRATO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (382, 'LEGALANEXO 2.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (383, 'PROCEANEXO 3.B EVISSO INDEPENDIENTE.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (384, 'PROCEHOJA DE VIDA EQUIPO MEDICO.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (385, 'SALUDNOTA_SEGURIDAD_AVASTIN.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (386, 'SSOMA12 FORM. INFORME DE SIMULACRO DE EMERGENCIAS.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (387, 'SSOMA5. DIAGRAMA DE FLUJO PROGRAMA VIGILANCIA ASBESTO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (388, 'SALUDARANCEL NACIONAL 2008.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (389, 'SSOMA3. CARTA RIESGOS PSICOSOCIALES2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (390, 'SSOMA3. FAP MANUAL DE SILICOSIS MINSAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (391, 'PROCEPROCESO RECUPERO.HTM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (392, 'SSOMA01 FORM. ACTA REUNION CPHS.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (393, 'ILDCIRCULAR 2345.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (394, 'PROCESOLICITUD ESTACIONAMIENTO VISITAS;V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (395, 'SSOMAANEXO 8.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (396, 'SSOMAMATRIZ DE RIESGOS  CENCOSUD - DIRECTO JORGE LAKE.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (397, 'INVALIDECESEXPRESS STGO. 3.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (398, 'SSOMAPEC COMPETITIVA-DOC 06 PRESENTACION 2013A.PPTX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (399, 'ADMINCERTIFICADO DE REMUNERACIONES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (400, 'PROCEINCORPORACION FARMACOS I SEMESTRE 2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (401, 'ILDANEXO 1 - FORMULARIO DE PRESENTACION DE PREPROYECTOS .DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (402, 'SALUDPROGRAMA PACIENTES CRONICOS E INSTITUCIONALIZADOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (403, 'PROCEPROCESO COBRANZA PRIVADO.HTM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (404, 'ADMINPROGR_ACTIVIDADES_CIERRES_MENSUALES_PROCESOS_DEL_ PERSONAL_ABRIL_2011.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (405, 'PROCEPROC MOVILIZAR A COLABORADORES MEDIANTE RADIO TAXI;V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (406, 'SSOMAGUIA DE INTERPRETACION NORMA TMERT MODIFICADA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (407, 'SSOMAMATRIZ DE RIESGOS CARTERA CORPORATIVAS2 SERVICIO-DIRECTOR DE CARTERA ALBERTO URRUTIA.XLSX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (408, 'SALUDNOTA  DE SEGURIDAD DASATINIB.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (409, 'SEGURFORMULARIO DETALLE DE PRESTACIONES.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (410, 'SSOMAPLANILLA CATASTRO RUIDO PVA PSA.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (411, 'SSOMA8. VENTILACION INDUSTRIAL ACGIH GENERALITAT VALENCIANA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (412, 'SSOMAPEC-ESTANDAR - DOC 00 BROCHURE A2012.01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (413, 'INVALIDECESTRANSFICH.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (414, 'ADMINCERTIFICADO DE TRABAJADORES OCTUBRE 2008.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (415, 'SALUDPROCEDIMIENTO SPE - INTERDICCION.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (416, 'PROCEANEXO 3 CARTA COBRANZA.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (417, 'PROCEGCL 1 7 VERSION 4 1 OCTUBRE 2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (418, 'DESARPROCEDIMIENTO SOLICITUD ELEMENTOS IMAGEN CORP.2.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (419, 'SALUDFICHA PACIENTE AUDIOMETRIA PEECCA R  2 3.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (420, 'PROCEREG 1.2 .PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (421, 'PROCEGCL 1.2 NORMA CURACIONES RED MUTUAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (422, 'SALUDPRODUCTOS CON DROGA NO DECLARADA 20101026 SIBUTRAMINA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (423, 'SSOMACORR ADH EMPRESA PLAG &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (424, 'SSOMAAPLASTADO POR UN ARBOL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (425, 'SSOMAGES. DE CASOS DE EVAL. DE INCAPACIDAD PERMAMENTE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (426, 'SALUDVERIFICACION CALIBRACION EQUIPOS  MDT EA 02.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (427, 'ADMINPROGR_ACTIVIDADES_CIERRES_MENSUALES_INFORMATICA_ABRIL_2011.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (428, 'PROCEPOLITICAINTEGRADA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (429, 'SSOMAANEXO 1.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (430, 'SSOMAFORMULARIO ANALISIS CAUSAL OCT 2010 ACC FATAL.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (431, 'LEGAL006.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (432, 'SALUDCONVENIO ISAPRE FERROSALUD.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (433, 'SSOMAINFORME DE COMPROBACION DE EXPOSICION A RUIDO BAJO CRITERIO DE ACCION.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (434, 'SALUDINSTRUMENTO DIAGNOSTICO FAMILIAR (ANEXO 4).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (435, 'SSOMADECRETO 63-2005 TRABAJO REGLAMENTO PARA LA APLICACI.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (436, 'SSOMAMANUAL PARA INTERCONSULTAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (437, 'SSOMAPENDON B=SAP107600277.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (438, 'PROCELABORATORIO, SOLICITAR ESTUDIO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (439, 'SALUDINFORME TRIMESTRAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (440, 'PROCEGCL 1.13 V 1.2 NORMA USO DE ANTICOAGULANTES ORALES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (441, 'INVALIDECESTRANSFICH 2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (442, 'SSOMA2. MANUAL PLAN DE TRABAJO MCA - P.1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (443, 'SSOMAFAPEP  SOLDADOR 107400430.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (444, 'SALUDNOTA INFORMATIVA PARACETAMOL AGOSTO 2009.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (445, 'SSOMAINGRESO DE DATOS AUDITORIA CPHS-FAENA.XLSM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (446, 'SSOMAANEXO 6.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (447, 'SSOMA01 RECOMENDACIONES PARA EL TRABAJO DE PIE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (448, 'LEGALPRESTACION DE SERVICIOS DE VIGILANCIA.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (449, 'SSOMAPEC COMPETITIVA-VIALIDAD-2013.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (450, 'DESARTRIPTICO COBERTURA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (451, 'SSOMABOLETIN_29_CAMION_ALJIBE_2012 WEB.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (452, 'PROCEAPI 13 NORMA INDICACIONES PARA EXMENES DE IMAGENOLOGA2085110.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (453, 'SALUDFORMULARIO SOLICITUD AUDIO PEECCA_R1.5.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (454, 'SSOMA0A. PROC. AUDITORIAS INTERNAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (455, 'ILDREGLAMENTO DS 76.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (456, 'SSOMADERRUMBE EN EXCAVACION.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (457, 'SSOMAEDUCA-SS -  EVALUACION DE RIESGOS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (458, 'SSOMA04 RECOMENDACIONES ERGONOMICAS PARA EL TRABAJO CON PALAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (459, 'SALUDCENTRO PEECCA PUNTA ARENAS (1).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (460, 'SSOMACORR ADH EMPRESA VERCUM &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (461, 'SALUDNOTA INFORMATIVA DOMPERIDONA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (462, 'ILDINSTRUCTIVO PARA LA CONSTITUCION Y FUNCIONAMIENTO DEL COMITE PARITARIO DE HIGIENE Y SEGURIDAD.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (463, 'SSOMANORMA TECNICA TMERT-EESS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (464, 'SSOMAMANUAL DATA MART MEDICINA DEL TRABAJO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (465, 'LEGAL2-VIEWCOLD(USUARIO FINAL).PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (466, 'SSOMAFAP PLOMO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (467, 'PROCEAPL 1.3 TIEMPOS DE ENTREGA DE RESULTADOS PACIENTES UCI PAB URG.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (468, 'PROCEREALIZAR DIAGNOSTICO SIN SERVICIO DE APOYO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (469, 'ADMINANALISIS-CONTABLE_SAP-2010.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (470, 'SSOMAR-COM-01 ACTA REUNION.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (471, 'INVALIDECESCONTROL Y EVASION.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (472, 'SEGURGESTIONAR CASO EIP POR ACCIDENTE DE TRABAJO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (473, 'LEGALARRENDMIENTO CON INVENTARIO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (474, 'PROCENORMA MANEJO RESIDUOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (475, 'DESAREPSP.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (476, 'PROCECARTACOMPROMISOADMINISTRADORES.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (477, 'SALUDRESPUESTA INTERLABORATORIO 24-07-2007.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (478, 'SSOMA2009.07 COMICS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (479, 'ADMINMANUAL DE VALIDACION TECNICA DE ANTEPROYECTOS DE  INFRAESTRUCTURA.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (480, 'SALUDNOTA  DE SEGURIDAD CHAMPIX.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (481, 'SALUDPIC REFORZAMIENTO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (482, 'INVALIDECESSTA. CRISTINA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (483, 'SSOMADIAGRAMA DE DECISION FAP 2 - 04-14.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (484, 'SSOMA4. POSTER DIAGRAMA DE FLUJO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (485, 'ADMINGLOSAS_CONTABLES.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (486, 'PROCEAOC 2.2 PROCEDIMIENTO ENTREGA DE TURNO SMQ.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (487, 'SSOMAMANUAL RELATOR COLUMNA OK.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (488, 'PROCEDP 1.3 PROCED. MEDIR LA SATISF. Y PERCEP. DEL RESP. DE LOS DERECHOS DEL PACTE. SALUD CAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (489, 'DESARPATRON_CARATULACDPORTADA2.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (490, 'DESARTRIPTICO QUE ES MUTUAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (491, 'PROCEPAUTA DE SUPERVISION CURACION DE HERIDA.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (492, 'PROCEPAGO DE OBLIGACIONES PREVISIONALES (SUBSIDIOS Y PENSIONES) V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (493, 'SSOMAEJEMPLO INFORME DE EVAL. DE LA EXPOSICION LABORAL A RUIDO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (494, 'SSOMACORR ADH EMPRESA SOLV &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (495, 'SSOMABOLETIN_30_CAMION_PLUMA_DESCARG_ELECTR_2012 WEB.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (496, 'PROCEAPK 1.3 PROTOCOLO CONTRAINDICACIONES PARA PROCEDIMIENTOS KINESIOTERAPIA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (497, 'INVALIDECESMEMORANDUM INTERNO A&E.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (498, 'SEGURFORMATO SOLICITUD PRORROGA_40 Y 92 SEM (2).XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (499, 'SALUDALERTA HEPARINA[1].PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (500, 'SSOMAPROTOCOLO DEDOS EN RESORTE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (501, 'ILDIMPORTANCIA DE LA IDENFIFICACION Y LA  EVALAC RIESGOS EN LA CONSTRUCCION.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (502, 'DESARPATRON_TRANSPARENCIA.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (503, 'SALUDEQUIPOS CRITICOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (504, 'ILDCIRCULAR 2356.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (505, 'PROCEPROCEDIMIENTO CONTABLE TARJETAS TRANSBANC (ANEXO 4).DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (506, 'ADMINCENTROS_DE_COSTO_2010.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (507, 'PROCEDESCRIPCION DE PROCESO ADHESION.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (508, 'SSOMAREGLAMENTO CERTIFICACION - ACTUALIZACION 2012.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (509, 'SSOMAPEC-ESTANDAR - DOC 01 DESCRIPCION PROGRAMA A2012.01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (510, 'SEGURPROCESO VIGILANCIA CASOS 40 Y 92 SEMANAS.NOVIEMBRE2009.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (511, 'SALUDNOTA  DE SEGURIDAD METOCLOPRAMIDA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (512, 'SALUDORGANIGRAMA PERSONAL ANTOFAGASTA EA 09 R1.2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (513, 'PROCERH 4.2.1 PLANILLA SEGUIMIENTO ACCIDENTES DEL PERSONAL.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (514, 'SSOMA16 FORM. LISTADO MAESTRO DE CONTROL DE REGISTROS.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (515, 'SSOMAPENDON A=SAP107600276.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (516, 'PROCEANEXO 5 CARTA ACEPTACION PRELIMINAR.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (517, 'SSOMAMANUAL LISTA DE CHEQUEO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (518, 'INVALIDECESVULE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (519, 'SALUDDESCRIPCION DE CARGOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (520, 'PROCERH 2.2 PROGRAMA ORIENTACION AL CARGO KINESIOLOGOS CAS ABIERTA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (521, 'SSOMAMARCO LEGAL CARGA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (522, 'LEGALINFORME DE INVEST. DE ACC..DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (524, 'PROCEAP TR 1.2 PROCEDIMIENTOS TRANSFUCIONALES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (525, 'SSOMAEPT_MANO Y DEDOS (TEN NODULAR).DOC.YMGFXHA.PARTIAL', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (526, 'PROCEREGISTRO DE PAGOS PACTADOS_V1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (527, 'SSOMATUBERIA CON TENDIDO ELECTRICO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (528, 'SSOMAEDUCA-SS -  REGISTRO-ESTADISTICA ACCIDENTADOS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (529, 'PROCEMEROPENEM.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (530, 'PROCEINS  2.1 PLAN EMERGENCIA TIPO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (531, 'PROCEANEXO 1.A.REQUISITOS PARA EMPRESAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (532, 'SSOMA7._ FORMULARIO SOLICITUD DE ANALISIS ALS GLOBAL USA.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (533, 'SSOMAEL PESO DE LA CARGA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (534, 'SSOMAEDUCA-SS -  FORMULARIO DE INSPECCION.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (535, 'PROCEANEXO 4 CARGA EVISSO (2).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (536, 'SALUDCARTA TIPO CORRES  EA PEECCA 2012.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (537, 'PROCECARTA DE DERECHOS Y DEBERES.GIF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (538, 'SSOMA9. LINKS DE INTERES HIGIENE OCUPACIONAL.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (539, 'PROCEINS 3.1 INSTRUCTIVO PROCEDIMIENTOS DE MANTENCION SGI V 1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (540, 'SSOMA0E. PROC. CONTROL DE REGISTROS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (541, 'PROCEPROGRAMA DE INDUCCION LOCAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (542, 'DESARPORTALADHERENTES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (543, 'DESARMUT CAPITULO 5.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (544, 'SALUDNOTA INFORMATIVA SOBRE ANTICONCEPTIVOS ORALES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (545, 'LEGALFORMATO CONTRATO SUMINISTRO DE INSUMOS.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (546, 'SSOMAPEC-ESTANDAR - DOC 20 DESCRIPCION DE CAMBIOS A2012.01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (547, 'PROCEAPL 1.5 V 3.0 MANUAL DE BIOSEGURIDAD 2012.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (548, 'ILDNUEVA NORMATIVA DE SEGURIDAD  Y SALUD LABORAL NOV 2006.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (549, 'SSOMACRITERIOS AUDITORIA CPHS DS54-69!!V04.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (550, 'SALUDCADENA CUSTODIA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (551, 'SALUDENCUESTA SERVICIO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (552, 'SSOMAANEXO 9.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (553, 'SSOMAINFORME_INGRESOS_FATALES PARA WEB.XLSX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (554, 'ADMINFORMATO IEP.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (555, 'SSOMAREC EMBARAZADAS P. ADMINISTRATIVOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (556, 'SSOMA4.- FORMATO LISTADO DE EMPRESAS EN PVET;V02.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (557, 'PROCEANEXO 3.A EVISSO EMPRESA.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (558, 'SSOMAINFORME INTERNO PEC-COMPETITIVA A2013.XLSX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (559, 'LEGALPRESTACION DE SERVICIOS DE ASEO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (560, 'SSOMA0D. PROC. CONTROL DE DOCUMENTOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (561, 'SSOMAPEC COMPETITIVA-DESCRIPCION DEL PROGRAMA-2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (562, 'SSOMACOMPACTACION DE TERRENO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (563, 'SALUDRETIRO DEL MERCADO CLARIMAX Y LEVOFAMIL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (564, 'PROCEAPL 1 3 APL 1 4 PROCEDIMIENTO  Y PROTOCOLOS DE CONTROL DE CALIDAD INTERNO Y EXTERNO LABORATORIO 4.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (565, 'SALUDRESOL_6165 CANCELA REGISTRO VIRACEPT 19 JULIO 2007.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (566, 'PROCECONTROL EXISTENCIA SUJETAS CONTROL LEGAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (567, 'SSOMAFAP SOLVENTES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (568, 'SALUDALERTA DE SEGURIDAD ROSIGLITAZONA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (569, 'SSOMAPROCEDIM NOTIFICACIONES AMPUTACIONES CIRC 2893 JUNIO 2013.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (570, 'INVALIDECESBUSES VULE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (571, 'INVALIDECESALSACIA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (572, 'SSOMAEPT BURSITIS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (573, 'SEGURFORMATO PS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (574, 'PROCEINSTRUCTIVO GES  DIRECCION MEDICA NACIONAL 2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (575, 'SSOMA15 FORM. LISTADO MAESTRO DE CONTROL DE DOCUMENTOS.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (576, 'SSOMA4. INTRIGA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (577, 'SALUDFICHA  SALUD AUDITIVA MDT EA 01 R3 3.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (578, 'INVALIDECESBUSES METROPOLITANA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (579, 'SSOMAVOLCAMIENTO DE TRACTOR.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (580, 'PROCEANEXO 2 - DATOS DE PROPIEDAD AFNOP.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (581, 'SSOMAMATRIZ DE RIESGO INSTITUCIONES DEL ESTADO-DIRECTORA LORETO MUNIZAGA.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (582, 'PROCEPRO RECUPERO SOAP ZONAL SUR V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (583, 'PROCEGCL 2 2  SEGUIMIENTO VIGILANCIA DE EVENTOS ADVERSOS Y CENTINELAS AA ENE 2013 .PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (584, 'SSOMAD.S. 73.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (585, 'LEGALARRENDAMIENTO BOX.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (586, 'SSOMA5. DIAGRAMA DE FLUJO PROGRAMA DE VIGILANCIA AMBIENTAL DE PLAGUICIDAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (587, 'SSOMAMODELO DE ATENCION EN HIGIENE OCUPACIONAL -  MAHO V2011.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (588, 'SALUDNOTA INFORMATIVA SEGURIDAD SOBRE VACUNAS  ROTAVIRUS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (589, 'SSOMAPROTOCOLO HOMBRO DOLOROSO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (590, 'SSOMAINFORME EDUCASS-201306.XLSM', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (591, 'INVALIDECESSTP1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (592, 'DESARMUT CAPITULO 4.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (593, 'PROCEKETOROLACO TROMETAMOL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (594, 'PROCEAPL 1.2 PROCEDIMIENTO EXAMEN DROGAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (595, 'PROCEGCL 1.8 PROCEDIMIENTO PARA ACCEDER AL COMITE ONCOLOGICO OK.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (596, 'PROCEGCL 1.2 V 2.0 PROTOCOLO DE ENF. MANEJO AVANZADO DE HERIDAS Y QUEMADURAS Y ULCERAS OCT 2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (597, 'SSOMACIRC 2893 ACCIONES ADOPTADAS AMPUTACIONES.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (598, 'LEGALGG   INSTRUCTIVO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (599, 'SALUDENCUESTA DE CALIDAD EN LA ATENCION (ANEXO 9).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (600, 'SALUDINTERVENCION CON REDES COMUNITARIAS (ANEXO 5).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (601, 'SSOMACIRC 2893 INFORME DE CUMPLIMIENTO AMPUTACIONES.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (602, 'PROCEINCORPORACION FARMACOS II SEMESTRE 2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (603, 'SSOMASEMANA DE LA SEGURIDAD.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (604, 'SSOMA2009.06 COMICS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (605, 'SSOMAFORMULARIO DE INSPECCION ESCOLAR.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (606, 'SALUDFORMATO INFORMES SUPERVIVENCIA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (607, 'LEGALALIMENTACION Y COMODATO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (608, 'SSOMAANEXO IV 2611 MEDIDAS INMEDIATAS PARA SISESAT.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (609, 'SSOMAMATRIZ DE RIESGO SALUD- DIRECTORA DE CARTERA GEORGINA OLIVA.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (610, 'INVALIDECESCOMERCIAL NUEVA MILENIO II.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (611, 'SSOMACORR ADH EMPRESA  POLMAD &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (612, 'DESARERIC.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (613, 'PROCEACTIVIDADES ADMINISTRATIVOS CAJEROS (ANEXO 7).XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (614, 'INVALIDECESELS S.A..PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (615, 'SSOMAEDUCA-SS -  ACTA COMITE PARITARIO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (616, 'PROCEDISTRIBUIR FACTURA FUERA DE SANTIAGO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (617, 'SALUDENCUESTA  DE EVALUACION PROGRAMA REINSERCION (ANEXO 8).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (618, 'SSOMACARTILLA TERRENO. ALZAMIENTO GRUPAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (619, 'LEGAL003 CONTINGENCIAS JUDICIALES .DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (620, 'SSOMAMATRIZ DE RIESGO CARTERA CORPORATIVAS 1-DIRECTOR CLAUDIO ROJAS.XLSX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (621, 'SSOMAEPT MANO_PULGAR(TEN QUERVAIN).DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (622, 'PROCEAPI 12 PROTOCOLO PREVENCIN EA ASOCIADOS A MEDIOS DE CONTRASTE7800139.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (623, 'SALUDPROTOCOLO AGENTE REHABILITADOR (ANEXO 7).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (624, 'SALUDPROGRAMA DE ATENCION PSICO-SOCIAL GRANDES SECUELADOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (625, 'SALUDENCUESTA DE CALIDAD PROGRAMA CRONICOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (627, 'SSOMALISTADECHEQUEO(9-AGO).EXE', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (628, 'PROCEPROC CONTROL DE OBLIG DE CONTRATIST PARA EL CUMPL DE LA LEY 20123.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (629, 'SALUDCLOPIDOGREL INTERACCION  INHIBIDORES BOMBA DE PROTONES JULIO 2009.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (630, 'DESARMUT CAPITULO 3B.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (631, 'SSOMAPVS EV. CUALITATIVA DHO - GERENCIA SSOMA V13 - OCTUBRE 2014.XLSB', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (632, 'SALUDPROTOCOLO TENOSINOVITIS DE QUERVAIN.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (633, 'SSOMAPEC-ESTANDAR - EVALUACION DS76 - PRINCIPAL OD7600211.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (634, 'ADMINFORMATO PS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (635, 'SALUDRETIRO ENJUAGUE BUCAL ORAL B.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (636, 'SEGURGESTIONAR CASO EIP POR ENFERMEDAD PROFESIONAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (637, 'SSOMAPROCEDIMIENTO INGRESO ACTIVIDADES 3SO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (638, 'SALUDCONDICIONES DEL  TRABAJADOR  PARA  AUDIOMETRIA PEECCA_R4.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (639, 'SSOMAPROCESO ACC AMPUTACIONES CIRC 2893 ENERO 2013.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (640, 'SSOMA0B. PROC. COMPETENCIA, ENTRENAMIENTO Y TOMA DE CONCIENCIA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (641, 'SSOMAEDUCA-SS -  GUIA PROCEDIMIENTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (642, 'PROCESOLICITAR IMAGEN PACIENTE CON CAMILLA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (643, 'SSOMAEPT COLUMNA.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (644, 'PROCEAOC 1.2  MANUAL TRIAGE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (645, 'SSOMAVALVULA REGULADORA DE PRESION DEL COMPRESOR.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (646, 'SALUDPROTOCOLO-TEMEESS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (647, 'PROCEPLANILLA VIGILANCIA EVENTOS ADVERSOS Y CENTINELAS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (648, 'PROCEINGRESAR PACIENTE DIRECTO URGENTE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (649, 'SSOMAFAPEP OP SALMON 107400433.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (650, 'SSOMA2009.09 COMICS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (651, 'SSOMAANEXO 3.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (652, 'ILDCIRCULAR 2378.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (653, 'LEGALPAGO VISTA DE REMUNERACIONES.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (654, 'PROCEINGRESAR PACIENTE DIRECTO INMEDIATO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (655, 'SALUDREGISTRO AUDIOMETRIA  R 4.6.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (656, 'ADMINPROCEDIMIENTO PARA PRESENTACION Y APROBACION DE INVERSIONES ACTIVO FIJO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (657, 'SSOMA3. FAP PLAGUICIDAS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (658, 'LEGALCONTRATO DE CONSTRUCCION DE OBRA MATERIAL.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (659, 'INVALIDECESCCU.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (660, 'PROCEPLANTILLA DE PROCEDIMIENTOS;V07.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (661, 'SSOMAERGONOMIA Y GENERO WHO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (662, 'SALUDNOTA INFORMATIVA SEGURIDAD DENOSUMAB.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (663, 'SSOMAEDUCA-SS -  FORMULARIO DE PERMISOS ESPECIALES.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (665, 'INVALIDECESEXPRESS SANTIAGO UNO_3.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (666, 'SSOMAMETRA_HELP_EJECUTIVO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (667, 'PROCEPROCEDIMIENTO PREFACTURA CET V1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (668, 'DESARTRIPTICO PSICOSENSOMETRICO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (669, 'PROCEENCUESTA AMBULATORIO FUSIONADA.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (670, 'SSOMAGUIA MANEJO PACIENTE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (671, 'ADMINPROGR_ACTIVIDADES_CIERRES_MENSUALES_HOSPITAL_CLINICO_ABRIL_2011.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (672, 'SSOMAFORMULARIO EN TERRENO CPHS-F - SAP=107400653-12-12.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (673, 'PROCEREGLAMENTO V.2 FIRMADO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (674, 'INVALIDECESRENTA EQUIPOS BESALCO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (675, 'PROCEREGISTRO DE FACTURAS_V1.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (676, 'PROCECOMPRAS CONTRATO MARCO;V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (677, 'SSOMAMATRIZ DE IDENTIFICACION DE RIESGO POR EXPOSICION A RUIDO EFECTUADO POR LA EMPRESA VERS AGO2014.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (678, 'ILDCIRCULAR 2346.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (679, 'SSOMAFORM INFORME INV ACC CALIF JURID ABRIL 2010.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (680, 'PROCEPROCEDIMIENTO EVALUAR PACIENTE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (681, 'SALUDRESOL.N_9655 RETIRO INMEDIATO DE APROTININA SOL INYECTABLE Y TRAYLOL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (682, 'SSOMACORR ADH EMPRESA ILU &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (683, 'PROCEANEXO 3 - RENDICION DE FONDOS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (684, 'SSOMAANEXO 7.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (685, 'PROCEMANUAL DE USUARIOS CLIENTE E- TRANSBANK (ANEXO 6).PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (686, 'SSOMAEDUCA-SS -  TABLA IDENTIFICACION DE PELIGROS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (687, 'SSOMAFORMULARIO DE AUDITORIA - ACTUALIZACION 2012.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (688, 'SSOMAINFORME.HTML', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (689, 'ADMINDIAGRAMA DE FLUJO PROCESO DS 67.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (690, 'PROCEINDICADOR DE REGISTRO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (691, 'INVALIDECESABASTIBLE.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (692, 'SSOMAPROCEDIMIENTO DESCENTRALIZADO CIRC 2611 - VERS OCT 2014.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (693, 'SSOMASOLICITUD ANALICIS ERGONOMICO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (694, 'INVALIDECESTRANSPORTES RIO NEGRO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (695, 'SSOMACONFIGURE SU PUESTO DE TRABAJOFAP 007-174.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (696, 'SSOMANACIONAL UNIVERSO EMPRESAS FPRS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (697, 'SSOMA2. EMPRESA CIERRE SIO2 (SIN PRESENCIA SI02).DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (698, 'PROCEAPE 1.5 AC NORMA DAN.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (699, 'SALUDFENILPROPANOLAMINA_ALERTA 2007.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (700, 'SSOMAMINSAL PROTOCOLO DE VIGILANCIA DE RIESGOS PSICOSOCIALES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (701, 'SSOMA4. LISTA DE CHEQUEO PLAN DE TRABAJO ASBESTO.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (702, 'PROCEPRO SUBSIDIOS DELEGADOS_V01.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (703, 'LEGALPRESTACION DE SERVICIOS REHABILITACION PACIENTES SECUELADOS 2012.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (704, 'SEGUR2009 NORMAS ADMINISTRATIVAS  ART 77 BIS 23-6-2009.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (705, 'SSOMACAMARA ALCANTARILLADO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (706, 'PROCETRAMADOL 50 MG - 100 MG.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (707, 'DESARLOGOPPT.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (708, 'SALUDNOTA INFORMATIVA SEGURIDAD CILOSTAZOL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (709, 'ILDCATALOGO_FINAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (710, 'DESARPATRON_VOLANTE.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (711, 'SSOMAFAPEP CAJERO SUPER 107400431.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (712, 'ADMINPOLITICA GLOBAL DE ACTIVO FIJO V F.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (713, 'SSOMACORR ADH EMPRESA  CALAIR &EXPERTO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (714, 'SSOMASIERRA HUINCHA EN UN ASERRADERO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (715, 'SSOMAARM PROCEDIMIENTO CALIFICACION (XP Y DC).DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (716, 'ADMINFORMATO PF.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (717, 'SSOMA7. PROTOCOLO DE MEDICION DE RUIDO IMPULSIVO ISP 2012.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (718, 'PROCEGCL 1.2  V 2.0 NORMA CADENA DE FRIO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (719, 'SSOMAEDUCA-SS -  FORMULARIO DE CHARLAS.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (720, 'SSOMAAUTORIZACION MINISTERIO PUBLICO.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (721, 'SSOMAMATRIZ PROGRAMA MMC.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (722, 'DESARCEIAT.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (723, 'SSOMACIRCULAR 2283 SOBRE MODIFIC DS 101 CON DS 73.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (724, 'SSOMAFAP SISMO= SAP 107400333.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (725, 'DESARMUT CAPITULO 3A.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (726, 'ILDREGLAMENTO INTERNO DE ORDEN IGIENE Y SEGURIDAD 2.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (727, 'ADMINPROGR_ACTIVIDADES_CIERRES_MENSUALES_AGENCIAS_ABRIL_2011.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (728, 'SSOMAMANUAL PASO A PASO TMERT-EESS 2014.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (729, 'SSOMACAMIO PLUMA OPERADOR ATRAPADO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (730, 'SSOMAINFORME EDUCASS-201306.DOCX', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (731, 'SSOMARECOLECTOR DE BASURA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (732, 'PROCEDP 2.1 AC V 2.3 NORMA  CONSENTIMIENTO  INFORMADO DE PACIENTES JULIO 2012.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (733, 'SSOMA130612 RE336 APRUEBA PROTOCOLO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (734, 'SSOMAENCUESTA.CSV', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (735, 'SSOMAPAUTA TECNICA DE PLOMO COMO AGENTE DE RIESGO LABORAL.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (736, 'SSOMA1. CARTA CORREO A EMPRESA PARA QUE INICIE PROCESO DE PREXOR.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (737, 'SSOMAALTERNATIVAS DEL CONTROL DE RIESGOS.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (738, 'SSOMALINEAMIENTO SOBRE FAJAS LUMBARES.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (739, 'SALUDRETIROS_MERCADO_JULIO_2008 BESTPHAMA.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (740, 'SSOMAPLANTILLA JULIO 2014 BOLETIN INFORMATIVO ACCIDENTE FATAL.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (741, 'SSOMANOCHERO SEGUNDO PISO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (742, 'INVALIDECESSTP.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (743, 'SSOMALISTA DE CHEQUEO INICIAL MMC.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (744, 'DESARPATRON_TRIPTICO.PPT', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (745, 'SEGURPROCEDIMIENTO_INTERNO_EDENUNCIA_V03.DOC', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (746, 'INVALIDECESCOMERCIAL NUEVO MILENIO.PDF', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);
INSERT INTO documento (id_documento, nombre, num_folio, num_adherente, descripcion, id_cartera, id_producto, cod_area, ruta, fec_creacion, invalideces, sami, fatales) VALUES (747, 'PROCEPAUTAS REGISTROS CLINICOS.XLS', '0', '0', 'CARGA MASIVA INICIAL', 4, 0, 'TRANS', '/home/ec2-user/DOCS/', '2015-03-29 18:21:56.286471', NULL, NULL, NULL);


--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 195
-- Name: documento_id_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('documento_id_documento_seq', 1, false);


--
-- TOC entry 3141 (class 0 OID 17721)
-- Dependencies: 206
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO empresa (id_empresa, num_adherente, nombre, cod_cartera, nom_experto, razon_social, ano_de_adhesion, segmentacion, holding, estrategica, situacion, multi_region, casa_matriz, num_centros_trabajo, masa_sum_metropilitana, masa_sum_nacional, planes_de_cuenta, planes_de_trabajo, firma_de_planes, sistema_de_gestion, etapa_sistema_gestion, firma_protocolo, num_cphs, num_cphs_certificado, num_cphs_bronce, num_cphs_plata, num_cphs_oro, prexor, prexor_etapa, prexor_texto, planesi, planesi_etapa, planesi_texto, asbesto, asbesto_etapa, asbesto_texto, hipobaria, hipobaria_etapa, hipobaria_texto, radiaciones, radiaciones_etapa, radiaciones_texto, asma, asma_etapa, asma_texto, solventes, solventes_etapa, solventes_texto, metales, metales_etapa, metales_texto, oxido, oxido_etapa, oxido_texto, plaguicida, plaguicida_etapa, plaguicida_texto, psicosociales, psicosociales_etapa, psicosociales_texto, mmc, mmc_etapa, mmc_texto, tmert, tmert_etapa, tmert_texto, radiacion_uv, radiacion_uv_etapa, radiacion_uv_texto, ultima_visita_experto, ultima_visita_director, ultima_visita_gtte, ultima_visita_alta_gerencia, reporte_visita, riesgo_de_fuga, reclamo_ultimo_periodo, participacion_mesa_trabajo) VALUES (7, '1456789', 'Turbus', '1', 'Edggar Vasquez', 'Sin Razon', '2015-03-28 00:00:00', 'Seg03', 'Si', 'No', 'soltero', 'Si', '13', '5', '500', '1000', 'Si', 'Si', NULL, 'Excelencia', 'Certificacion', '2015-03-28 00:00:00', '12', '3', '1', '1', '1', 'Si', 'No Aplica', 'sda', 'Si', 'Difusión del Protocolo', 'sadas', 'No', 'No Aplica', 'asdsadsa', 'No', 'No Aplica', 'asdasd', 'Si', 'Ingreso a Programa de Vigilancia de exposición a radiaciones', 'asdasd', 'Si', 'Evaluación Cualitativa', 'asdasdasd', 'No', 'No Aplica', 'asdasdsa', 'No', NULL, 'asdasdsa', 'No', 'No Aplica', 'asdasdasdsad', 'No', 'No Aplica', 'asdasdsa', NULL, NULL, NULL, 'Si', 'Asesoría en la construcción de la matriz  MMC', 'asdasdsad', 'Si', 'Difusión', 'asdsadsadsa', NULL, NULL, 'asdasda', '2015-03-28 00:00:00', '2015-03-28 00:00:00', '2015-03-28 00:00:00', '2015-03-28 00:00:00', 'aaaaaaa', 'Bajo', '2015-03-28 00:00:00', 'Si');
INSERT INTO empresa (id_empresa, num_adherente, nombre, cod_cartera, nom_experto, razon_social, ano_de_adhesion, segmentacion, holding, estrategica, situacion, multi_region, casa_matriz, num_centros_trabajo, masa_sum_metropilitana, masa_sum_nacional, planes_de_cuenta, planes_de_trabajo, firma_de_planes, sistema_de_gestion, etapa_sistema_gestion, firma_protocolo, num_cphs, num_cphs_certificado, num_cphs_bronce, num_cphs_plata, num_cphs_oro, prexor, prexor_etapa, prexor_texto, planesi, planesi_etapa, planesi_texto, asbesto, asbesto_etapa, asbesto_texto, hipobaria, hipobaria_etapa, hipobaria_texto, radiaciones, radiaciones_etapa, radiaciones_texto, asma, asma_etapa, asma_texto, solventes, solventes_etapa, solventes_texto, metales, metales_etapa, metales_texto, oxido, oxido_etapa, oxido_texto, plaguicida, plaguicida_etapa, plaguicida_texto, psicosociales, psicosociales_etapa, psicosociales_texto, mmc, mmc_etapa, mmc_texto, tmert, tmert_etapa, tmert_texto, radiacion_uv, radiacion_uv_etapa, radiacion_uv_texto, ultima_visita_experto, ultima_visita_director, ultima_visita_gtte, ultima_visita_alta_gerencia, reporte_visita, riesgo_de_fuga, reclamo_ultimo_periodo, participacion_mesa_trabajo) VALUES (8, '23213221', 'AMD', '3', 'Edggar Vasquez', 'Sin Razon', '2015-03-28 00:00:00', 'Seg01', 'Si', 'Si', 's', 'Si', '7', '3', '4', '5', 'Si', 'Si', NULL, 'PEC Estandar', 'Implementacion', '2015-03-28 00:00:00', '6', '7', '8', '9', '0', 'Si', 'Evaluación Cualitativa', '', 'Si', 'Evaluación Cualitativa', '', 'Si', 'Evaluación Cualitativa', '', 'Si', 'Evaluación Cualitativa', '', 'Si', 'Evaluación Cualitativa', '', 'Si', 'Evaluación Cualitativa', '', 'Si', 'Evaluación Cualitativa', '', 'Si', NULL, '', 'Si', 'Evaluación Cualitativa', '', 'Si', 'Evaluación Cualitativa', '', NULL, NULL, NULL, 'Si', 'Difusión', '', 'Si', 'Difusión', '', NULL, NULL, '', '2015-03-28 00:00:00', '2015-03-28 00:00:00', '2015-03-28 00:00:00', '2015-03-28 00:00:00', 'fdgdf', 'Bajo', '2015-03-28 00:00:00', 'Si');


--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 205
-- Name: empresa_id_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('empresa_id_empresa_seq', 8, true);


--
-- TOC entry 3119 (class 0 OID 17089)
-- Dependencies: 184
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO estado (id_estado, des_estado) VALUES (7, 'Activo');
INSERT INTO estado (id_estado, des_estado) VALUES (1, 'Inactivo');
INSERT INTO estado (id_estado, des_estado) VALUES (8, 'pendiente');


--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 183
-- Name: estado_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estado_id_estado_seq', 8, true);


--
-- TOC entry 3132 (class 0 OID 17319)
-- Dependencies: 197
-- Data for Name: link; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (15, 'asd', 'asd', 0);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (13, 'www.chilecomparte.cl', 'asd', 0);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (16, 'asd', 'asd', 0);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (17, 'asd', 'asd', 0);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (10, 'www.google.com', 'Buscador Google', 5);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (18, 'www.plp.cl', 'nope', 8);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (19, 'sdasdasd', 'asdasdasdasdasd', 7);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (8, 'www.madboxpc.com', 'Internet', 5);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (7, 'www.chilecomparte.cl', 'lalalal', 5);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (9, 'www.facebook.com', 'foros', 0);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (12, 'www.chilecomparte.cl', 'asd', 0);
INSERT INTO link (id_link, url_link, des_link, id_tipo_link) VALUES (14, 'asd', 'asd', 0);


--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 198
-- Name: link_id_link_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('link_id_link_seq', 19, true);


--
-- TOC entry 3123 (class 0 OID 17132)
-- Dependencies: 188
-- Data for Name: medios_respuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO medios_respuesta (id_medio_respuesta, des_medio_respuesta) VALUES (2, 'email');
INSERT INTO medios_respuesta (id_medio_respuesta, des_medio_respuesta) VALUES (5, 'web');
INSERT INTO medios_respuesta (id_medio_respuesta, des_medio_respuesta) VALUES (6, 'Telefono');


--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 187
-- Name: medios_respuesta_id_medio_respuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('medios_respuesta_id_medio_respuesta_seq', 6, true);


--
-- TOC entry 3121 (class 0 OID 17105)
-- Dependencies: 186
-- Data for Name: motivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO motivo (id_motivo, des_motivo) VALUES (2, 'Motivo 2');
INSERT INTO motivo (id_motivo, des_motivo) VALUES (1, 'Motivo 99');
INSERT INTO motivo (id_motivo, des_motivo) VALUES (8, 'Motivo 23');
INSERT INTO motivo (id_motivo, des_motivo) VALUES (9, 'Apocalipsis Zombie');


--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 185
-- Name: motivo_id_motivo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('motivo_id_motivo_seq', 9, true);


--
-- TOC entry 3128 (class 0 OID 17226)
-- Dependencies: 193
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO perfil (id_perfil, des_perfil) VALUES (1, 'admin');
INSERT INTO perfil (id_perfil, des_perfil) VALUES (2, 'usuario');
INSERT INTO perfil (id_perfil, des_perfil) VALUES (8, 'vicepresidente junor');


--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 192
-- Name: perfil_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('perfil_id_perfil_seq', 8, true);


--
-- TOC entry 3129 (class 0 OID 17250)
-- Dependencies: 194
-- Data for Name: perfil_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (13, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (12, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (6, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (1, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (13, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (12, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (6, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (1, 1);
INSERT INTO perfil_usuario (idusuario, id_perfil) VALUES (46, 1);


--
-- TOC entry 3125 (class 0 OID 17145)
-- Dependencies: 190
-- Data for Name: prioridad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO prioridad (id_prioridad, des_prioridad) VALUES (1, 'Baja');
INSERT INTO prioridad (id_prioridad, des_prioridad) VALUES (2, 'Media');
INSERT INTO prioridad (id_prioridad, des_prioridad) VALUES (10, 'Alta');
INSERT INTO prioridad (id_prioridad, des_prioridad) VALUES (11, 'Inmediata');


--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 189
-- Name: prioridad_id_prioridad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('prioridad_id_prioridad_seq', 11, true);


--
-- TOC entry 3113 (class 0 OID 17009)
-- Dependencies: 178
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO producto (id_producto, des_producto) VALUES (1, 'Afiches');
INSERT INTO producto (id_producto, des_producto) VALUES (6, 'Catalogos');
INSERT INTO producto (id_producto, des_producto) VALUES (12, 'Documentos de Apoyo');
INSERT INTO producto (id_producto, des_producto) VALUES (13, 'Programas de Trabajo');
INSERT INTO producto (id_producto, des_producto) VALUES (14, 'Campañas');
INSERT INTO producto (id_producto, des_producto) VALUES (15, 'Estándar');
INSERT INTO producto (id_producto, des_producto) VALUES (0, 'No definido');


--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 177
-- Name: producto_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('producto_id_producto_seq', 13, true);


--
-- TOC entry 3110 (class 0 OID 16835)
-- Dependencies: 175
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
-- TOC entry 3126 (class 0 OID 17170)
-- Dependencies: 191
-- Data for Name: reclamo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO reclamo (id_reclamo, num_adherente, nombre_solicitante, email_solicitante, fono_solicitante, region_solicitante, id_tipo, id_motivo, id_prioridad, id_cartera, fec_ingreso, glosa, adjunto, observaciones, responsable_ingreso, responsable_actual, id_medio_respuesta, fec_respuesta, id_estado, dias_bandeja, dias_sistema) VALUES (31, '838988', 'Pedro', 'pedro@pedrito.com', '223232', '10', 6, 8, 10, 3, '2015-02-19 00:00:00', ' HOlahaoalgahgoahohalhohlhoalhola', NULL, 'observaciones', 'pedro', 'pablo', 5, '2015-04-16 00:00:00', 7, '', '');
INSERT INTO reclamo (id_reclamo, num_adherente, nombre_solicitante, email_solicitante, fono_solicitante, region_solicitante, id_tipo, id_motivo, id_prioridad, id_cartera, fec_ingreso, glosa, adjunto, observaciones, responsable_ingreso, responsable_actual, id_medio_respuesta, fec_respuesta, id_estado, dias_bandeja, dias_sistema) VALUES (33, '838988', 'test', 'testemail', 'solicitante', '10', 9, 8, 11, 4, '2015-03-28 00:00:00', 'asdadsasd ', 'asd', 'asd', 'asd', 'asd', 5, '2015-03-28 00:00:00', 1, '', '');
INSERT INTO reclamo (id_reclamo, num_adherente, nombre_solicitante, email_solicitante, fono_solicitante, region_solicitante, id_tipo, id_motivo, id_prioridad, id_cartera, fec_ingreso, glosa, adjunto, observaciones, responsable_ingreso, responsable_actual, id_medio_respuesta, fec_respuesta, id_estado, dias_bandeja, dias_sistema) VALUES (34, '838988', 'asdads', 'jtoledo@interac.cl', 'asdasdasd', '10', 9, 9, 1, 3, '2015-03-28 00:00:00', 'asdasdasd ', 'asdasd', 'asdasd', 'asasdd', 'asdasdasdasd', 2, '2015-03-28 00:00:00', 7, '', '');
INSERT INTO reclamo (id_reclamo, num_adherente, nombre_solicitante, email_solicitante, fono_solicitante, region_solicitante, id_tipo, id_motivo, id_prioridad, id_cartera, fec_ingreso, glosa, adjunto, observaciones, responsable_ingreso, responsable_actual, id_medio_respuesta, fec_respuesta, id_estado, dias_bandeja, dias_sistema) VALUES (35, '838988', 'asdasd', 'jimmy.toledo.a@gmail.com', 'asasd', '1', 10, 9, 10, 3, '2015-03-28 00:00:00', ' adsasdad', 'asd', 'asd', 'dsa', 'ds', 2, '2015-03-28 00:00:00', 7, '', '');
INSERT INTO reclamo (id_reclamo, num_adherente, nombre_solicitante, email_solicitante, fono_solicitante, region_solicitante, id_tipo, id_motivo, id_prioridad, id_cartera, fec_ingreso, glosa, adjunto, observaciones, responsable_ingreso, responsable_actual, id_medio_respuesta, fec_respuesta, id_estado, dias_bandeja, dias_sistema) VALUES (36, '838988', 'asdasdsdsd', 'jimmy.toledo.a@gmail.com', 'asdsd', '11', 6, 2, 1, 1, '2015-03-28 00:00:00', 'asdasdasdasdads ', 'asdads', 'asdads', 'asdasd', 'asdasd', 6, '2015-03-28 00:00:00', 1, '', '');
INSERT INTO reclamo (id_reclamo, num_adherente, nombre_solicitante, email_solicitante, fono_solicitante, region_solicitante, id_tipo, id_motivo, id_prioridad, id_cartera, fec_ingreso, glosa, adjunto, observaciones, responsable_ingreso, responsable_actual, id_medio_respuesta, fec_respuesta, id_estado, dias_bandeja, dias_sistema) VALUES (37, '838988', 'adasd', 'jimmy.toledo.a@gmail.com', 'assad', '10', 9, 9, 10, 3, '2015-03-28 00:00:00', 'asdasdasdasd ', 'asdads', 'sadasd', 'asdasd', 'asdasd', 2, '2015-03-28 00:00:00', 7, '', '');


--
-- TOC entry 3111 (class 0 OID 16839)
-- Dependencies: 176
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
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 171
-- Name: seq_documento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_documento', 58, true);


--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 172
-- Name: seq_reclamo; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_reclamo', 37, true);


--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 169
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_usuario', 50, true);


--
-- TOC entry 3115 (class 0 OID 17050)
-- Dependencies: 180
-- Data for Name: tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo (id_tipo, des_tipo) VALUES (9, 'Tipo Reclamo 1');
INSERT INTO tipo (id_tipo, des_tipo) VALUES (6, 'Tipo Reclamo 2');
INSERT INTO tipo (id_tipo, des_tipo) VALUES (7, 'Tipo Reclamo 3');
INSERT INTO tipo (id_tipo, des_tipo) VALUES (10, 'Bono Bachelet');


--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 179
-- Name: tipo_id_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_id_tipo_seq', 10, true);


--
-- TOC entry 3134 (class 0 OID 17327)
-- Dependencies: 199
-- Data for Name: tipo_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_link (id_tipo_link, des_tipo_link) VALUES (5, 'Nueva categoría');
INSERT INTO tipo_link (id_tipo_link, des_tipo_link) VALUES (2, 'Una Categoría seria');
INSERT INTO tipo_link (id_tipo_link, des_tipo_link) VALUES (7, 'Una Categoria aun mas seria');
INSERT INTO tipo_link (id_tipo_link, des_tipo_link) VALUES (8, 'La categoría');


--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 200
-- Name: tipo_link_id_tipo_link_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_link_id_tipo_link_seq', 8, true);


--
-- TOC entry 3105 (class 0 OID 16658)
-- Dependencies: 170
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (6, '16970737', '5', 'Andrés', 'Vega', 'Yáñez', 'avy', '71E10870A1741AAD', 'M', '1988-07-09', 'mi casa', 5801, 51, 5, 'Chile', '12345678', '87654321', 'avegay@interac.cl', 1, '2015-01-26 13:44:56.141854', '2015-01-22 00:00:00', 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (12, '18299276', '3', 'Michele ', 'De Conti', 'Rivara', 'michele', '9CC3A942F54B9ED346BACBE1EE5B7FDF', NULL, '1993-01-22', NULL, NULL, NULL, NULL, NULL, '2953520', '12345678', 'mdeconti@interac.cl', NULL, NULL, NULL, NULL);
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (49, '15762923', '9', 'Joaquin Eduardo', 'Chacon', 'Araya', 'jchacon', '8D72D02FD0DC8473D17E4EE1DCAF35F6', 'M', '1984-07-21', NULL, NULL, NULL, NULL, NULL, '2722151', '64786843', 'jchacon@interac.cl', NULL, '2015-03-10 10:02:38.133853', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (46, '17354606', '8', 'Hernan', 'Hernan', 'Hernan', 'hernan', '9CC3A942F54B9ED346BACBE1EE5B7FDF', NULL, '1990-01-02', NULL, NULL, NULL, NULL, NULL, '111222333', '11122233', 'hernan@mutual.test', NULL, '2015-03-05 17:20:45.830381', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (1, '16201021', '2', 'Jorge Andrés', 'Inostroza', 'Urrutia', 'jiu', '9E02E1514729B70016A76BB942F6002C', 'M', '1986-04-04', 'Suiza 960 Casa 4 Belloto Centro', 5801, 51, 5, 'Chile', '032 2949525', '75389915', 'jinostroza@interac.cl', NULL, '2013-12-03 21:02:23.286416', NULL, 'h');
INSERT INTO usuario (idusuario, rut, dv, nombres, apepaterno, apematerno, nomusuario, contrasena, codgenero, fecnacimiento, direccion, idcomuna, idprovincia, idregion, codpais, telefono, celular, email, cantintentos, feccreacion, feccontrasena, indvigencia) VALUES (13, '17993508', '2', 'Iván Antonio', 'Zamorano', 'Cataldo', 'iza', 'F9EEDB17954E3D45', 'M', '2012-11-11', NULL, NULL, NULL, NULL, NULL, '1234567', '74086605', 'izamorano@interac.cl', NULL, '2015-01-30 10:51:46.329575', NULL, 'h');


--
-- TOC entry 2990 (class 2606 OID 17566)
-- Name: accidentabilidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY accidentabilidad
    ADD CONSTRAINT accidentabilidad_pkey PRIMARY KEY (id_accidente);


--
-- TOC entry 2960 (class 2606 OID 16665)
-- Name: area_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY area
    ADD CONSTRAINT area_pkey PRIMARY KEY (cod_area);


--
-- TOC entry 2970 (class 2606 OID 17086)
-- Name: cartera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cartera
    ADD CONSTRAINT cartera_pkey PRIMARY KEY (id_cartera);


--
-- TOC entry 2992 (class 2606 OID 17574)
-- Name: diasperdidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY diasperdidos
    ADD CONSTRAINT diasperdidos_pkey PRIMARY KEY (id_dias);


--
-- TOC entry 2984 (class 2606 OID 17298)
-- Name: documento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_pkey PRIMARY KEY (id_documento);


--
-- TOC entry 2994 (class 2606 OID 17729)
-- Name: empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (id_empresa);


--
-- TOC entry 2972 (class 2606 OID 17094)
-- Name: estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id_estado);


--
-- TOC entry 2986 (class 2606 OID 17346)
-- Name: link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY link
    ADD CONSTRAINT link_pkey PRIMARY KEY (id_link);


--
-- TOC entry 2976 (class 2606 OID 17137)
-- Name: medios_respuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY medios_respuesta
    ADD CONSTRAINT medios_respuesta_pkey PRIMARY KEY (id_medio_respuesta);


--
-- TOC entry 2974 (class 2606 OID 17110)
-- Name: motivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY motivo
    ADD CONSTRAINT motivo_pkey PRIMARY KEY (id_motivo);


--
-- TOC entry 2982 (class 2606 OID 17231)
-- Name: perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id_perfil);


--
-- TOC entry 2978 (class 2606 OID 17150)
-- Name: prioridad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prioridad
    ADD CONSTRAINT prioridad_pkey PRIMARY KEY (id_prioridad);


--
-- TOC entry 2966 (class 2606 OID 17014)
-- Name: producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 2980 (class 2606 OID 17177)
-- Name: reclamo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reclamo
    ADD CONSTRAINT reclamo_pkey PRIMARY KEY (id_reclamo);


--
-- TOC entry 2988 (class 2606 OID 17348)
-- Name: tipo_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_link
    ADD CONSTRAINT tipo_link_pkey PRIMARY KEY (id_tipo_link);


--
-- TOC entry 2968 (class 2606 OID 17055)
-- Name: tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (id_tipo);


--
-- TOC entry 2962 (class 2606 OID 16671)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (idusuario);


--
-- TOC entry 2964 (class 2606 OID 17356)
-- Name: usuario_rut_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_rut_key UNIQUE (rut);


--
-- TOC entry 2996 (class 2606 OID 17258)
-- Name: perfil_usuario_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfil_usuario
    ADD CONSTRAINT perfil_usuario_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil);


--
-- TOC entry 2995 (class 2606 OID 17253)
-- Name: perfil_usuario_idusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfil_usuario
    ADD CONSTRAINT perfil_usuario_idusuario_fkey FOREIGN KEY (idusuario) REFERENCES usuario(idusuario);


--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-03-30 11:13:52 CLST

--
-- PostgreSQL database dump complete
--


package cl.antartis.interac.beans;

import java.io.Serializable;

public class Sesion implements Serializable {

	private static final long serialVersionUID = 154542455462906393L;
	private String sesIdSesion;
	private String sesFhoLogueo;
	private String sesFhoUltimaConsulta;
	private String sesNomHost;
	private String sesCodAplicacion;
	private String sesIdUsuario;
	private String sesRutUsuario;
	private String sesNomUsuario;
	private String sesCodIdioma;
	private String sesData01;
	private String sesData02;
	private String sesData03;
	private String sesData04;
	private String sesData05;
	private String sesIndExpiraContrasena;

	public String getSesIdSesion() {
		return sesIdSesion;
	}

	public void setSesIdSesion(String sesIdSesion) {
		this.sesIdSesion = sesIdSesion;
	}

	public String getSesFhoLogueo() {
		return sesFhoLogueo;
	}

	public void setSesFhoLogueo(String sesFhoLogueo) {
		this.sesFhoLogueo = sesFhoLogueo;
	}

	public String getSesFhoUltimaConsulta() {
		return sesFhoUltimaConsulta;
	}

	public void setSesFhoUltimaConsulta(String sesFhoUltimaConsulta) {
		this.sesFhoUltimaConsulta = sesFhoUltimaConsulta;
	}

	public String getSesNomHost() {
		return sesNomHost;
	}

	public void setSesNomHost(String sesNomHost) {
		this.sesNomHost = sesNomHost;
	}

	public String getSesCodAplicacion() {
		return sesCodAplicacion;
	}

	public void setSesCodAplicacion(String sesCodAplicacion) {
		this.sesCodAplicacion = sesCodAplicacion;
	}

	public String getSesIdUsuario() {
		return sesIdUsuario;
	}

	public void setSesIdUsuario(String sesIdUsuario) {
		this.sesIdUsuario = sesIdUsuario;
	}

	public String getSesRutUsuario() {
		return sesRutUsuario;
	}

	public void setSesRutUsuario(String sesRutUsuario) {
		this.sesRutUsuario = sesRutUsuario;
	}

	public String getSesNomUsuario() {
		return sesNomUsuario;
	}

	public void setSesNomUsuario(String sesNomUsuario) {
		this.sesNomUsuario = sesNomUsuario;
	}

	public String getSesCodIdioma() {
		return sesCodIdioma;
	}

	public void setSesCodIdioma(String sesCodIdioma) {
		this.sesCodIdioma = sesCodIdioma;
	}

	public String getSesData01() {
		return sesData01;
	}

	public void setSesData01(String sesData01) {
		this.sesData01 = sesData01;
	}

	public String getSesData02() {
		return sesData02;
	}

	public void setSesData02(String sesData02) {
		this.sesData02 = sesData02;
	}

	public String getSesData03() {
		return sesData03;
	}

	public void setSesData03(String sesData03) {
		this.sesData03 = sesData03;
	}

	public String getSesData04() {
		return sesData04;
	}

	public void setSesData04(String sesData04) {
		this.sesData04 = sesData04;
	}

	public String getSesData05() {
		return sesData05;
	}

	public void setSesData05(String sesData05) {
		this.sesData05 = sesData05;
	}

	public String getSesIndExpiraContrasena() {
		return sesIndExpiraContrasena;
	}

	public void setSesIndExpiraContrasena(String sesIndExpiraContrasena) {
		this.sesIndExpiraContrasena = sesIndExpiraContrasena;
	}
	
	public String getSesion(){
		return "Datos Sesion";
	}
}
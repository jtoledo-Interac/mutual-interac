package cl.antartis.interac.beans;

import java.io.Serializable;

public class Usuario implements Serializable {

	private static final long serialVersionUID = -8969393201692586300L;
	private long nIdUsuario;
	private String sRut;
	private String sDV;
	private String sRutFormat;
	private String sNombres;
	private String sApePaterno;
	private String sApeMaterno;
	private String sNomUsuario;
	private String sContrasena;
	private String sCodGenero;
	private String sFecNacimiento;
	private String sTelefono;
	private String sCelular;
	private String sEmail;
	private int nCantIntentos;
	private String sFecCreacion;
	private String sFecContrasena;
	private String sIndVigencia;
	private String sHost;
	private String sCodIdioma="spa";

	public long getnIdUsuario() {
		return nIdUsuario;
	}

	public void setnIdUsuario(long nIdUsuario) {
		this.nIdUsuario = nIdUsuario;
	}

	public String getsRut() {
		return sRut;
	}

	public void setsRut(String sRut) {
		this.sRut = sRut;
	}

	public String getsDV() {
		return sDV;
	}

	public void setsDV(String sDV) {
		this.sDV = sDV;
	}
	
	public String getsRutFormat() {
		return sRutFormat;
	}

	public void setsRutFormat(String sRutFormat) {
		this.sRutFormat = sRutFormat;
	}

	public String getsNombres() {
		return sNombres;
	}

	public void setsNombres(String sNombres) {
		this.sNombres = sNombres;
	}

	public String getsApePaterno() {
		return sApePaterno;
	}

	public void setsApePaterno(String sApePaterno) {
		this.sApePaterno = sApePaterno;
	}

	public String getsApeMaterno() {
		return sApeMaterno;
	}

	public void setsApeMaterno(String sApeMaterno) {
		this.sApeMaterno = sApeMaterno;
	}

	public String getsNomUsuario() {
		return sNomUsuario;
	}

	public void setsNomUsuario(String sNomUsuario) {
		this.sNomUsuario = sNomUsuario;
	}

	public String getsContrasena() {
		return sContrasena;
	}

	public void setsContrasena(String sContrasena) {
		this.sContrasena = sContrasena;
	}

	public String getsCodGenero() {
		return sCodGenero;
	}

	public void setsCodGenero(String sCodGenero) {
		this.sCodGenero = sCodGenero;
	}

	public String getsFecNacimiento() {
		return sFecNacimiento;
	}

	public void setsFecNacimiento(String sFecNacimiento) {
		this.sFecNacimiento = sFecNacimiento;
	}

	public String getsTelefono() {
		return sTelefono;
	}

	public void setsTelefono(String sTelefono) {
		this.sTelefono = sTelefono;
	}

	public String getsCelular() {
		return sCelular;
	}

	public void setsCelular(String sCelular) {
		this.sCelular = sCelular;
	}

	public String getsEmail() {
		return sEmail;
	}

	public void setsEmail(String sEmail) {
		this.sEmail = sEmail;
	}

	public int getnCantIntentos() {
		return nCantIntentos;
	}

	public void setnCantIntentos(int nCantIntentos) {
		this.nCantIntentos = nCantIntentos;
	}

	public String getsFecCreacion() {
		return sFecCreacion;
	}

	public void setsFecCreacion(String sFecCreacion) {
		this.sFecCreacion = sFecCreacion;
	}

	public String getsFecContrasena() {
		return sFecContrasena;
	}

	public void setsFecContrasena(String sFecContrasena) {
		this.sFecContrasena = sFecContrasena;
	}

	public String getsIndVigencia() {
		return sIndVigencia;
	}

	public void setsIndVigencia(String sIndVigencia) {
		this.sIndVigencia = sIndVigencia;
	}

	public String getsHost() {
		return sHost;
	}

	public void setsHost(String sHost) {
		this.sHost = sHost;
	}

	public String getsCodIdioma() {
		return sCodIdioma;
	}

	public void setsCodIdioma(String sCodIdioma) {
		this.sCodIdioma = sCodIdioma;
	}

	public String getUsuario(){
		String usuario = "\nDATOS DE USUARIO:";
		usuario += "\nnIdUsuario: "+this.nIdUsuario;  
		usuario += "\nsRut: "+this.sRut;
		usuario += "\nsDV: "+this.sDV;
		usuario += "\nsRutFormat: "+this.sRutFormat;
		usuario += "\nsNombres: "+this.sNombres;
		usuario += "\nsApePaterno: "+this.sApePaterno;
		usuario += "\nsApeMaterno: "+this.sApeMaterno;
		usuario += "\nsNomUsuario: "+this.sNomUsuario;
		usuario += "\nsContrasena: "+this.sContrasena;
		usuario += "\nsCodGenero: "+this.sCodGenero;
		usuario += "\nsFecNacimiento: "+this.sFecNacimiento;
		usuario += "\nsTelefono: "+this.sTelefono;
		usuario += "\nsCelular: "+this.sCelular;
		usuario += "\nsMail: "+this.sEmail;
		usuario += "\nnCantIntentos: "+this.nCantIntentos;
		usuario += "\nsFecCreacion: "+this.sFecCreacion;
		usuario += "\nsFecContrasena: "+this.sFecContrasena;
		usuario += "\nsIndVigencia: "+this.sIndVigencia;
		usuario += "\nsHost: "+this.sHost;
		usuario += "\nsCodIdioma: "+this.sCodIdioma;
		
		return usuario;
	}
}
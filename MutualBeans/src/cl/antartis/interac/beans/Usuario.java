package cl.antartis.interac.beans;

import java.io.Serializable;
import java.util.HashMap;

import cl.antartis.interac.funciones.Utils;

public class Usuario implements Serializable {

	private static final long serialVersionUID = -8969393201692586300L;
	private long idUsuario;
	private String rut;
	private String dv;
	private String rutFormat;
	private String nombres;
	private String apePaterno;
	private String apeMaterno;
	private String nomUsuario;
	private String contrasena1;
	private String contrasena2;
	private String codGenero;
	private String fecNacimiento;
	private String telefono;
	private String celular;
	private String email;
	private int cantIntentos;
	private String fecCreacion;
	private String fecContrasena;
	private String indVigencia;
	private String host;

	
	public Usuario(HashMap map){
		if(map.containsKey("nIdUsuario")) idUsuario = Utils.stringToNum((String)map.get("idUsuario"));
		if(map.containsKey("sRut")) rut = (String)map.get("sRut") ;
		if(map.containsKey("sDV")) dv  = (String)map.get("sDV") ;
		if(map.containsKey("sNombres")) nombres = (String)map.get("sNombres") ;
		if(map.containsKey("sApePaterno")) apePaterno = (String)map.get("sApePaterno") ;
		if(map.containsKey("sApeMaterno")) apeMaterno = (String)map.get("sApeMaterno") ;
		if(map.containsKey("sNomUsuario")) nomUsuario = (String)map.get("sNomUsuario") ;
		if(map.containsKey("sContrasena1")) contrasena1 = ((String)map.get("sContrasena1"));
		if(map.containsKey("sContrasena2")) contrasena2 = (String)map.get("sContrasena2") ;
		if(map.containsKey("sCodGenero")) codGenero = (String)map.get("codGenero");
		if(map.containsKey("sFecNacimiento")) fecNacimiento = (String)map.get("sFecNacimiento") ;
		if(map.containsKey("sTelefono")) telefono = (String)map.get("sTelefono") ;
		if(map.containsKey("sCelular")) celular = (String)map.get("sCelular") ;
		if(map.containsKey("sEmail")) email = (String)map.get("sEmail") ;
		if(map.containsKey("sTelefono")) telefono = (String)map.get("sTelefono") ;
	}
	
	public Usuario(){
		
	}
	
	public long getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(long idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getRut() {
		return rut;
	}

	public void setRut(String rut) {
		this.rut = rut;
	}

	public String getDv() {
		return dv;
	}

	public void setDv(String dv) {
		this.dv = dv;
	}

	public String getRutFormat() {
		return rutFormat;
	}

	public void setRutFormat(String rutFormat) {
		this.rutFormat = rutFormat;
	}

	public String getNombres() {
		return nombres;
	}

	public void setNombres(String nombres) {
		this.nombres = nombres;
	}

	public String getApePaterno() {
		return apePaterno;
	}

	public void setApePaterno(String apePaterno) {
		this.apePaterno = apePaterno;
	}

	public String getApeMaterno() {
		return apeMaterno;
	}

	public void setApeMaterno(String apeMaterno) {
		this.apeMaterno = apeMaterno;
	}

	public String getNomUsuario() {
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}

	public String getContrasena1() {
		return contrasena1;
	}

	public void setContrasena1(String contrasena1) {
		this.contrasena1 = contrasena1;
	}

	public String getContrasena2() {
		return contrasena2;
	}

	public void setContrasena2(String contrasena2) {
		this.contrasena2 = contrasena2;
	}

	public String getCodGenero() {
		return codGenero;
	}

	public void setCodGenero(String codGenero) {
		this.codGenero = codGenero;
	}

	public String getFecNacimiento() {
		return fecNacimiento;
	}

	public void setFecNacimiento(String fecNacimiento) {
		this.fecNacimiento = fecNacimiento;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getCelular() {
		return celular;
	}

	public void setCelular(String celular) {
		this.celular = celular;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getCantIntentos() {
		return cantIntentos;
	}

	public void setCantIntentos(int cantIntentos) {
		this.cantIntentos = cantIntentos;
	}

	public String getFecCreacion() {
		return fecCreacion;
	}

	public void setFecCreacion(String fecCreacion) {
		this.fecCreacion = fecCreacion;
	}

	public String getFecContrasena() {
		return fecContrasena;
	}

	public void setFecContrasena(String fecContrasena) {
		this.fecContrasena = fecContrasena;
	}

	public String getIndVigencia() {
		return indVigencia;
	}

	public void setIndVigencia(String indVigencia) {
		this.indVigencia = indVigencia;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getUsuario() {
		String usuario = "\nDATOS DE USUARIO:";
		usuario += "\nidUsuario: " + this.idUsuario;
		usuario += "\nrut: " + this.rut;
		usuario += "\ndv: " + this.dv;
		usuario += "\nrutFormat: " + this.rutFormat;
		usuario += "\nnombres: " + this.nombres;
		usuario += "\napePaterno: " + this.apePaterno;
		usuario += "\napeMaterno: " + this.apeMaterno;
		usuario += "\nnomUsuario: " + this.nomUsuario;
		usuario += "\ncontrasena1: " + this.contrasena1;
		usuario += "\ncontrasena2: " + this.contrasena2;
		usuario += "\ncodGenero: " + this.codGenero;
		usuario += "\nfecNacimiento: " + this.fecNacimiento;
		usuario += "\ntelefono: " + this.telefono;
		usuario += "\ncelular: " + this.celular;
		usuario += "\nemail: " + this.email;
		usuario += "\ncantIntentos: " + this.cantIntentos;
		usuario += "\nfecCreacion: " + this.fecCreacion;
		usuario += "\nfecContrasena: " + this.fecContrasena;
		usuario += "\nindVigencia: " + this.indVigencia;
		usuario += "\nhost: " + this.host;

		return usuario;
	}
}
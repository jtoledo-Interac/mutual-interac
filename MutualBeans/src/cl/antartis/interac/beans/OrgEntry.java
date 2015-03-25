package cl.antartis.interac.beans;

import java.io.Serializable;

public class OrgEntry implements Serializable {

	private static final long serialVersionUID = 5722839945964495910L;

	String Nombre;
	String Cargo;
	String Supervisor;
	
	public String getNombre() {
		return Nombre;
	}
	public String getCargo() {
		return Cargo;
	}
	public String getSupervisor() {
		return Supervisor;
	}
	public void setNombre(String Nombre) {
		this.Nombre = Nombre;
	}
	public void setCargo(String Cargo) {
		this.Cargo = Cargo;
	}
	public void setSupervisor(String Supervisor) {
		this.Supervisor = Supervisor;
	}
}

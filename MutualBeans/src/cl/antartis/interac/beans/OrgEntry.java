package cl.antartis.interac.beans;

import java.io.Serializable;

public class OrgEntry implements Serializable {

	private static final long serialVersionUID = 5722839945964495910L;

	private String nombre;
	private String cargo;
	private String supervisor;
	
	public String getNombre() {
		return nombre;
	}
	public String getCargo() {
		return cargo;
	}
	public String getSupervisor() {
		return supervisor;
	}
	public void setNombre(String _Nombre) {
		this.nombre = _Nombre;
	}
	public void setCargo(String _Cargo) {
		this.cargo = _Cargo;
	}
	public void setSupervisor(String _Supervisor) {
		this.supervisor = _Supervisor;
	}
}

package cl.antartis.interac.beans;

import java.io.Serializable;

public class Perfil implements Serializable {

	private static final long serialVersionUID = 3218925635001770144L;
	private Long idPerfil;
	private String desPerfil;
	
	public Long getIdPerfil() {
		return idPerfil;
	}
	public void setIdPerfil(Long idPerfil) {
		this.idPerfil = idPerfil;
	}
	public String getDesPerfil() {
		return desPerfil;
	}
	public void setDesPerfil(String desPerfil) {
		this.desPerfil = desPerfil;
	}
	
}

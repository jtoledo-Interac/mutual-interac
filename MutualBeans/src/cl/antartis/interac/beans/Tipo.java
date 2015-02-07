package cl.antartis.interac.beans;

import java.io.Serializable;

public class Tipo implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private Long idTipo;
	private String desTipo;

	public Long getIdTipo() {
		return idTipo;
	}

	public void setIdTipo(Long codTipo) {
		this.idTipo = codTipo;
	}

	public String getDesTipo() {
		return desTipo;
	}

	public void setDesTipo(String desTipo) {
		this.desTipo = desTipo;
	}
	public String getTipo() {
		String tipo = "\nDATOS DE Tipo:";
		
		tipo += "\ncodcodTipo: "+this.idTipo;  
		tipo += "\ndesTipo: "+this.desTipo;

		return tipo;
	}
}
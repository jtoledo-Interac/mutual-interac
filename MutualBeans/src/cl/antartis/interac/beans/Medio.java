package cl.antartis.interac.beans;

import java.io.Serializable;

public class Medio implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private String desMedio;
	private Long idMedio;
	
	public Long getIdMedio() {
		return idMedio;
	}

	public void setIdMedio(Long idMedio) {
		this.idMedio = idMedio;
	}

	public String getDesMedio() {
		return desMedio;
	}

	public void setDesMedio(String desMedio) {
		this.desMedio = desMedio;
	}

	public String getMedio() {
		String medio = "\nDATOS DE Medio:";
		
		medio += "\nidMedio: "+this.idMedio;  
		medio += "\ndesMedio: "+this.desMedio;

		return medio;
	}
}
package cl.antartis.interac.beans;

import java.io.Serializable;

public class Prioridad implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private Long idPrioridad;
	
	public Long getIdPrioridad() {
		return idPrioridad;
	}

	public void setIdPrioridad(Long idPrioridad) {
		this.idPrioridad = idPrioridad;
	}

	private String desPrioridad;

	
	public String getDesPrioridad() {
		return desPrioridad;
	}

	public void setDesPrioridad(String desPrioridad) {
		this.desPrioridad = desPrioridad;
	}
	
	public String getPrioridad() {
		String prioridad = "\nDATOS DE Prioridad:";
		
		prioridad += "\nidPrioridad: "+this.idPrioridad;  
		prioridad += "\ndesPrioridad: "+this.desPrioridad;

		return prioridad;
	}

}
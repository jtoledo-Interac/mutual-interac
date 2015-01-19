package cl.antartis.interac.beans;

import java.io.Serializable;

public class Prioridad implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private String codPrioridad;
	private String desPrioridad;

	public String getCodPrioridad() {
		return codPrioridad;
	}

	public void setCodPrioridad(String codPrioridad) {
		this.codPrioridad = codPrioridad;
	}

	public String getDesPrioridad() {
		return desPrioridad;
	}

	public void setDesPrioridad(String desPrioridad) {
		this.desPrioridad = desPrioridad;
	}

}
package cl.antartis.interac.beans;

import java.io.Serializable;

public class Tipo implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private String codTipo;
	private String desTipo;

	public String getCodTipo() {
		return codTipo;
	}

	public void setCodTipo(String codTipo) {
		this.codTipo = codTipo;
	}

	public String getDesTipo() {
		return desTipo;
	}

	public void setDesTipo(String desTipo) {
		this.desTipo = desTipo;
	}

}
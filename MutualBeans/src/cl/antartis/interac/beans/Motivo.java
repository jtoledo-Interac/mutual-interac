package cl.antartis.interac.beans;

import java.io.Serializable;

public class Motivo implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private String codMotivo;
	private String desMotivo;

	public String getCodMotivo() {
		return codMotivo;
	}

	public void setCodMotivo(String codMotivo) {
		this.codMotivo = codMotivo;
	}

	public String getDesMotivo() {
		return desMotivo;
	}

	public void setDesMotivo(String desMotivo) {
		this.desMotivo = desMotivo;
	}

}
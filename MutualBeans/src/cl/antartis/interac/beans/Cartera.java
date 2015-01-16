package cl.antartis.interac.beans;

import java.io.Serializable;

public class Cartera implements Serializable {

	private static final long serialVersionUID = 5013610931946807970L;
	private String codCartera;
	private String desCartera;

	public String getCodCartera() {
		return codCartera;
	}

	public void setCodCartera(String codCartera) {
		this.codCartera = codCartera;
	}

	public String getDesCartera() {
		return desCartera;
	}

	public void setDesCartera(String desCartera) {
		this.desCartera = desCartera;
	}

	public String getCartera() {
		String cartera = "\nDATOS DE Cartera:";
		cartera += "\ncodCartera: " + this.codCartera;
		cartera += "\ndesCartera: " + this.desCartera;
		return cartera;
	}
}
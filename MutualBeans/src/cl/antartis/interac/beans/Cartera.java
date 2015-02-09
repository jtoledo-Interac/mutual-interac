package cl.antartis.interac.beans;

import java.io.Serializable;

public class Cartera implements Serializable {

	private static final long serialVersionUID = 5013610931946807970L;
	private Long idCartera;
	private String desCartera;


	public String getDesCartera() {
		return desCartera;
	}

	public void setDesCartera(String desCartera) {
		this.desCartera = desCartera;
	}

	public String getCartera() {
		String cartera = "\nDATOS DE Cartera:";
		cartera += "\nidCartera: " + this.idCartera;
		cartera += "\ndesCartera: " + this.desCartera;
		return cartera;
	}

	public Long getIdCartera() {
		return idCartera;
	}

	public void setIdCartera(Long idCartera) {
		this.idCartera = idCartera;
	}
}
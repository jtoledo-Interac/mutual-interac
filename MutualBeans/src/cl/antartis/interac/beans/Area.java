package cl.antartis.interac.beans;

import java.io.Serializable;

public class Area implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private String codArea;
	private String desArea;

	public String getCodArea() {
		return codArea;
	}

	public void setCodArea(String codArea) {
		this.codArea = codArea;
	}

	public String getDesArea() {
		return desArea;
	}

	public void setDesArea(String desArea) {
		this.desArea = desArea;
	}

	public String getProducto() {
		String area = "\nDATOS DE Area:";
		area += "\ncodArea: " + this.codArea;
		area += "\ndesArea: " + this.desArea;
		return area;
	}
}
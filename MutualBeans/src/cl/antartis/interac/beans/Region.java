package cl.antartis.interac.beans;

import java.io.Serializable;

public class Region implements Serializable {

	private static final long serialVersionUID = 3688818935371562150L;
	private String codRegion;
	private String desRegion;

	public String getRegion() {
		String region = "\nDATOS DE Region:";
		
		region += "\ncodRegion: " + this.codRegion;  
		region += "\nmdesMotivo: " + this.desRegion;

		return region;
	}

	public String getCodRegion() {
		return codRegion;
	}

	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}

	public String getDesRegion() {
		return desRegion;
	}

	public void setDesRegion(String desRegion) {
		this.desRegion = desRegion;
	}
	
}

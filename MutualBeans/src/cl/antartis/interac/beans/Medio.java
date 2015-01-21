package cl.antartis.interac.beans;

import java.io.Serializable;

public class Medio implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private String codMedio;
	private String desMedio;

	public String getCodMedio() {
		return codMedio;
	}

	public void setCodMedio(String codMedio) {
		this.codMedio = codMedio;
	}

	public String getDesMedio() {
		return desMedio;
	}

	public void setDesMedio(String desMedio) {
		this.desMedio = desMedio;
	}

	public String getProducto() {
		String medio = "\nDATOS DE Medio:";
		
		medio += "\ntipoLogueo: "+this.codMedio;  
		medio += "\nmid: "+this.desMedio;
	

		return medio;
	}
}
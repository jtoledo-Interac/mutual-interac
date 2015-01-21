package cl.antartis.interac.beans;

import java.io.Serializable;

public class Estado implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private String codEstado;
	private String desEstado;

	public String getCodEstado() {
		return codEstado;
	}

	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}

	public String getDesEstado() {
		return desEstado;
	}

	public void setDesEstado(String desEstado) {
		this.desEstado = desEstado;
	}
	public String getEstado(){
		String estado = "\nDATOS DE Estado:";
		estado += "\ncodEstado: "+this.codEstado;  
		estado += "\ndesEstado: "+this.desEstado;
		
		return estado;
	}
	
	
		
	

}
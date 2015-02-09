package cl.antartis.interac.beans;

import java.io.Serializable;

public class Estado implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private Long idEstado;
	private String desEstado;

	public String getDesEstado() {
		return desEstado;
	}

	public Long getIdEstado() {
		return idEstado;
	}

	public void setIdEstado(Long idEstado) {
		this.idEstado = idEstado;
	}

	public void setDesEstado(String desEstado) {
		this.desEstado = desEstado;
	}
	public String getEstado(){
		String estado = "\nDATOS DE Estado:";
		estado += "\nidEstado: "+this.idEstado;  
		estado += "\ndesEstado: "+this.desEstado;
		
		return estado;
	}	

}
package cl.antartis.interac.beans;

import java.io.Serializable;

public class Motivo implements Serializable {

	private static final long serialVersionUID = 2036592118735551615L;
	private Long idMotivo;
	private String desMotivo;
	
	public Long getIdMotivo() {
		return idMotivo;
	}

	public void setIdMotivo(Long idMotivo) {
		this.idMotivo = idMotivo;
	}

	public String getDesMotivo() {
		return desMotivo;
	}

	public void setDesMotivo(String desMotivo) {
		this.desMotivo = desMotivo;
	}
	
	public String getMotivo() {
		String motivo = "\nDATOS DE Motivo:";
		
		motivo += "\ncodMotivo: "+this.idMotivo;  
		motivo += "\nmdesMotivo: "+this.desMotivo;

		return motivo;
	}

}
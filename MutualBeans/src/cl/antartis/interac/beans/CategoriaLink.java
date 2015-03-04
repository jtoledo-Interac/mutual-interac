package cl.antartis.interac.beans;

import java.io.Serializable;

public class CategoriaLink implements Serializable {

	private static final long serialVersionUID = 4699641704357902050L;

	private String idTipoLink;
	private String desTipoLink;
	
	public String getIdTipoLink() {
		return idTipoLink;
	}
	public void setIdTipoLink(String idTipoLink) {
		this.idTipoLink = idTipoLink;
	}
	public String getDesTipoLink() {
		return desTipoLink;
	}
	public void setDesTipoLink(String desTipoLink) {
		this.desTipoLink = desTipoLink;
	}
}

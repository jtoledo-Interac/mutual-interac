package cl.antartis.interac.beans;

import java.io.Serializable;

public class CategoriaLink implements Serializable {

	private static final long serialVersionUID = 4699641704357902050L;

	private Long idCategoriaLink;
	private String desCategoriaLink;
	
	public Long getIdCategoriaLink() {
		return idCategoriaLink;
	}
	public void setIdCategoriaLink(Long idCategoriaLink) {
		this.idCategoriaLink = idCategoriaLink;
	}
	public String getDesCategoriaLink() {
		return desCategoriaLink;
	}
	public void setDesCategoriaLink(String desCategoriaLink) {
		this.desCategoriaLink = desCategoriaLink;
	}
	
}

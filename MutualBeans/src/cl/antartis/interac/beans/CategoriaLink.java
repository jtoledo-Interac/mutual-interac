package cl.antartis.interac.beans;

import java.io.Serializable;

public class CategoriaLink implements Serializable {

	private static final long serialVersionUID = 4699641704357902050L;

	private String idCategoriaLink;
	private String desCategoriaoLink;
	
	public String getIdCategoriaLink() {
		return idCategoriaLink;
	}
	public void setIdCategoriaLink(String idCategoriaLink) {
		this.idCategoriaLink = idCategoriaLink;
	}
	public String getDesCategoriaoLink() {
		return desCategoriaoLink;
	}
	public void setDesCategoriaoLink(String desCategoriaoLink) {
		this.desCategoriaoLink = desCategoriaoLink;
	}
	
	
}

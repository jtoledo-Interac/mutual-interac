package cl.antartis.interac.beans;

import java.io.Serializable;

public class Link implements Serializable {

	private static final long serialVersionUID = -6446179858112814345L;

	private String idLink;
	private String urlLink;
	private String desLink;
	private String idCategoriaLink;
	private String desCategoriaLink;
	public String getIdLink() {
		return idLink;
	}
	public void setIdLink(String idLink) {
		this.idLink = idLink;
	}
	public String getUrlLink() {
		return urlLink;
	}
	public void setUrlLink(String urlLink) {
		this.urlLink = urlLink;
	}
	public String getDesLink() {
		return desLink;
	}
	public void setDesLink(String desLink) {
		this.desLink = desLink;
	}
	public String getIdCategoriaLink() {
		return idCategoriaLink;
	}
	public void setIdCategoriaLink(String idCategoriaLink) {
		this.idCategoriaLink = idCategoriaLink;
	}
	public String getDesCategoriaLink() {
		return desCategoriaLink;
	}
	public void setDesCategoriaLink(String desCategoriaLink) {
		this.desCategoriaLink = desCategoriaLink;
	}
	
	
}
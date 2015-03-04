package cl.antartis.interac.beans;

import java.io.Serializable;

public class Link implements Serializable {

	private static final long serialVersionUID = -6446179858112814345L;

	private String idLinks;
	private String url;
	private String des;
	public String getIdLinks() {
		return idLinks;
	}
	public void setIdLinks(String idLinks) {
		this.idLinks = idLinks;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
}
package cl.antartis.interac.beans;

import java.io.Serializable;

public class Producto implements Serializable {

	private static final long serialVersionUID = 2650105806288959430L;
	private String codProducto;
	private String desProducto;

	public String getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}

	public String getDesProducto() {
		return desProducto;
	}

	public void setDesProducto(String desProducto) {
		this.desProducto = desProducto;
	}

	public String getProducto() {
		String producto = "\nDATOS DE Producto:";
		producto += "\ncodProducto: " + this.codProducto;
		producto += "\ndesProducto: " + this.desProducto;
		return producto;
	}
}
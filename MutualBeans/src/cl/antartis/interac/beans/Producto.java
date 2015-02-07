package cl.antartis.interac.beans;

import java.io.Serializable;

public class Producto implements Serializable {

	private static final long serialVersionUID = 2650105806288959430L;
	private long  idProducto;
	private String desProducto;
	
	public long getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(long idProducto) {
		this.idProducto = idProducto;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getDesProducto() {
		return desProducto;
	}

	public void setDesProducto(String desProducto) {
		this.desProducto = desProducto;
	}

	public String getProducto() {
		String producto = "\nDATOS DE Producto:";
		producto += "\nidProducto: " + this.idProducto;
		producto += "\ndesProducto: " + this.desProducto;
		return producto;
	}
}
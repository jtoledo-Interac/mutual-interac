package cl.antartis.interac.beans;

import java.io.Serializable;

public class Documento implements Serializable {

	private static final long serialVersionUID = 3764757332350720257L;
	private long idDocumento;
	private String nombre;
	private String numFolio;
	private String numAdherente;
	private String descripcion;
	private String codArea;
	private String desArea;
	private String codCartera;
	private String desCartera;
	private String codProducto;
	private String desProducto;
	private String fecCreacion;

	
	public String getDesArea() {
		return desArea;
	}

	public void setDesArea(String desArea) {
		this.desArea = desArea;
	}

	public String getDesCartera() {
		return desCartera;
	}

	public void setDesCartera(String desCartera) {
		this.desCartera = desCartera;
	}

	public String getDesProducto() {
		return desProducto;
	}

	public void setDesProducto(String desProducto) {
		this.desProducto = desProducto;
	}

	public long getIdDocumento() {
		return idDocumento;
	}

	public void setIdDocumento(long idDocumento) {
		this.idDocumento = idDocumento;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getNumFolio() {
		return numFolio;
	}

	public void setNumFolio(String numFolio) {
		this.numFolio = numFolio;
	}

	public String getNumAdherente() {
		return numAdherente;
	}

	public void setNumAdherente(String numAdherente) {
		this.numAdherente = numAdherente;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getCodCartera() {
		return codCartera;
	}

	public String getCodArea() {
		return codArea;
	}

	public void setCodArea(String codArea) {
		this.codArea = codArea;
	}

	public void setCodCartera(String codCartera) {
		this.codCartera = codCartera;
	}

	public String getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}

	public String getFecCreacion() {
		return fecCreacion;
	}

	public void setFecCreacion(String fecCreacion) {
		this.fecCreacion = fecCreacion;
	}

	public String getDocumento() {
		String documento = "\nDATOS DE Documento:";
		documento += "\nidDocumento" + this.idDocumento; 
		documento += "\nnombre" + this.nombre;
		documento += "\nnumFolio" + this.numFolio;
		documento += "\nnumAdherente" + this.numAdherente;
		documento += "\ndescripcion" + this.descripcion;
		documento += "\ncodArea" + this.codArea;
		documento += "\ndesArea" + this.desArea;
		documento += "\ncodCartera" + this.codCartera;
		documento += "\ndesCartera" + this.desCartera;
		documento += "\ncodProducto" + this.codProducto;
		documento += "\ndesProducto" + this.desProducto;
		documento += "\nfecCreacion" + this.fecCreacion;

		return documento;
	}
}
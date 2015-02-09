package cl.antartis.interac.beans;

import java.io.Serializable;
import java.util.HashMap;

import cl.antartis.interac.funciones.Utils;

public class Documento implements Serializable {

	private static final long serialVersionUID = 3764757332350720257L;
	private long idDocumento;
	private String nombre;
	private String numFolio;
	private String numAdherente;
	private String descripcion;
	private String codArea;
	private String desArea;
	private Long idCartera;
	public Long getIdCartera() {
		return idCartera;
	}

	public void setIdCartera(Long idCartera) {
		this.idCartera = idCartera;
	}

	private String desCartera;
	
	public Long getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(Long idProducto) {
		this.idProducto = idProducto;
	}

	private Long idProducto;
	private String desProducto;
	private String fecCreacion;

	
	public Documento(){}
	
	public Documento(HashMap map){
		if(map.containsKey("nombre")) nombre = (String)map.get("nombre") ;
		if(map.containsKey("numFolio")) numFolio = (String)map.get("numFolio") ;
		if(map.containsKey("numAdherente")) numAdherente = (String)map.get("numAdherente") ;
		if(map.containsKey("descripcion")) descripcion = (String)map.get("descripcion") ;
		if(map.containsKey("codArea")) codArea = (String)map.get("codArea") ;
		if(map.containsKey("desArea")) desArea = (String)map.get("desArea") ;
		if(map.containsKey("idCartera")) idCartera = Utils.stringToNum((String)map.get("idCartera"));
		if(map.containsKey("desCartera")) desCartera = (String)map.get("desCartera") ;
		if(map.containsKey("idProducto")) idProducto = Utils.stringToNum((String)map.get("idProducto"));
		if(map.containsKey("desProducto")) desProducto = (String)map.get("desProducto") ;
		if(map.containsKey("fecCreacion")) fecCreacion = (String)map.get("fecCreacion") ;
	}
	
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

	public String getCodArea() {
		return codArea;
	}

	public void setCodArea(String codArea) {
		this.codArea = codArea;
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
		documento += "\nidCartera" + this.idCartera;
		documento += "\ndesCartera" + this.desCartera;
		documento += "\ncodProducto" + this.idProducto;
		documento += "\ndesProducto" + this.desProducto;
		documento += "\nfecCreacion" + this.fecCreacion;

		return documento;
	}
}
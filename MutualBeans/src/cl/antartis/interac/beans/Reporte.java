package cl.antartis.interac.beans;

import java.io.Serializable;

public class Reporte implements Serializable {
	
	private static final long serialVersionUID = 6579351231046520207L;

	private long idReporte;
	private long idEmpresa;
	private String nombreEmpresa;
	private float diasPerdidos;
	private float accidentabilidad;
	private String inicioPeriodo;
	private String finPeriodo;
	private String ingresoDato;
	
	public Reporte(){}
	
	public Reporte(long idReporte, long idEmpresa, String nombreEmpresa, float diasPerdidos,
			float accidentabilidad, String inicioPeriodo, String finPeriodo, String ingresoDato){
		super();
		this.idReporte = idReporte;
		this.idEmpresa = idEmpresa;
		this.nombreEmpresa = nombreEmpresa;
		this.diasPerdidos = diasPerdidos;
		this.accidentabilidad = accidentabilidad;
		this.inicioPeriodo = inicioPeriodo;
		this.finPeriodo = finPeriodo;
		this.ingresoDato = ingresoDato;
	}
	
	public void setIdEmpresa(long idEmpresa){
		this.idEmpresa = idEmpresa;
	}
	
	public long getIdEmpresa(){
		return idEmpresa;
	}
	
	public void setNombreEmpresa(String nombreEmpresa){
		this.nombreEmpresa = nombreEmpresa;
	}
	
	public void setIdReporte(long idReporte){
		this.idReporte = idReporte;
	}
	
	public long getIdReporte(){
		return idReporte;
	}
	
	public String getNombreEmpresa(){
		return nombreEmpresa;
	}
	
	public float getDiasAccidentabilidad(){
		return accidentabilidad;
	}
	
	public float getDiasPerdidos(){
		return diasPerdidos;
	}
	
	public String getInicioPeriodo(){
		return inicioPeriodo;
	}
	
	public String getFinPeriodo(){
		return finPeriodo;
	}
	
	public String getIngresoDato(){
		return ingresoDato;
	}
	
	public void setDiasPerdidos(float diasPerdidos){
		this.diasPerdidos = diasPerdidos;
	}
	
	public void setDiasAccidentabilidad(float accidentabilidad){
		this.accidentabilidad = accidentabilidad;
	}
	
	public void setInicioPeriodo(String inicioPeriodo){
		this.inicioPeriodo = inicioPeriodo;
	}
	
	public void setFinPeriodo(String finPeriodo){
		this.finPeriodo = finPeriodo;
	}
	
	public void setIngresoDato(String ingresoDato){
		this.ingresoDato = ingresoDato;
	}
}

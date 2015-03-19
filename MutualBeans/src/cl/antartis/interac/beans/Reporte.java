package cl.antartis.interac.beans;

import java.io.Serializable;

public class Reporte {

	private long idReporte;
	private String nombreEmpresa;
	private long diasPerdidos;
	private long accidentabilidad;
	private String inicioPeriodo;
	private String finPeriodo;
	private String ingresoDato;
	
	public Reporte(){
		
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
	
	public void setDiasPerdidos(long diasPerdidos){
		this.diasPerdidos = diasPerdidos;
	}
	
	public void setDiasAccidentabilidad(long accidentabilidad){
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

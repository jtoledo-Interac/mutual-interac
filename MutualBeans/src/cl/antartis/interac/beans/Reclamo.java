package cl.antartis.interac.beans;

import java.io.Serializable;

public class Reclamo implements Serializable {

	private static final long serialVersionUID = -4275537097136536953L;

	private long idReclamo;
	private String numAdherente;
	private String nombreSolicitante;
	private String emailSolicitante;
	private String fonoSolicitante;
	private String regionSolicitante;
	private String codTipo;
	private String codMotivo;
	private String codPrioridad;
	private String codCartera;
	private String fecIngreso;
	private String glosa;
	private String adjunto;
	private String observaciones;
	private String codEstado;
	private String responsableIngreso;
	private String responsableActual;
	private String diasBandeja;
	private String diasSistema;
	private String codMedioRespuesta;
	private String fecRespuesta;

	public long getIdReclamo() {
		return idReclamo;
	}

	public void setIdReclamo(long idReclamo) {
		this.idReclamo = idReclamo;
	}

	public String getNumAdherente() {
		return numAdherente;
	}

	public void setNumAdherente(String numAdherente) {
		this.numAdherente = numAdherente;
	}

	public String getNombreSolicitante() {
		return nombreSolicitante;
	}

	public void setNombreSolicitante(String nombreSolicitante) {
		this.nombreSolicitante = nombreSolicitante;
	}

	public String getEmailSolicitante() {
		return emailSolicitante;
	}

	public void setEmailSolicitante(String emailSolicitante) {
		this.emailSolicitante = emailSolicitante;
	}

	public String getFonoSolicitante() {
		return fonoSolicitante;
	}

	public void setFonoSolicitante(String fonoSolicitante) {
		this.fonoSolicitante = fonoSolicitante;
	}

	public String getRegionSolicitante() {
		return regionSolicitante;
	}

	public void setRegionSolicitante(String regionSolicitante) {
		this.regionSolicitante = regionSolicitante;
	}

	public String getCodTipo() {
		return codTipo;
	}

	public void setCodTipo(String codTipo) {
		this.codTipo = codTipo;
	}

	public String getCodMotivo() {
		return codMotivo;
	}

	public void setCodMotivo(String codMotivo) {
		this.codMotivo = codMotivo;
	}

	public String getCodPrioridad() {
		return codPrioridad;
	}

	public void setCodPrioridad(String codPrioridad) {
		this.codPrioridad = codPrioridad;
	}

	public String getCodCartera() {
		return codCartera;
	}

	public void setCodCartera(String codCartera) {
		this.codCartera = codCartera;
	}

	public String getFecIngreso() {
		return fecIngreso;
	}

	public void setFecIngreso(String fecIngreso) {
		this.fecIngreso = fecIngreso;
	}

	public String getGlosa() {
		return glosa;
	}

	public void setGlosa(String glosa) {
		this.glosa = glosa;
	}

	public String getAdjunto() {
		return adjunto;
	}

	public void setAdjunto(String adjunto) {
		this.adjunto = adjunto;
	}

	public String getObservaciones() {
		return observaciones;
	}

	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}

	public String getCodEstado() {
		return codEstado;
	}

	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}

	public String getResponsableIngreso() {
		return responsableIngreso;
	}

	public void setResponsableIngreso(String responsableIngreso) {
		this.responsableIngreso = responsableIngreso;
	}

	public String getResponsableActual() {
		return responsableActual;
	}

	public void setResponsableActual(String responsableActual) {
		this.responsableActual = responsableActual;
	}

	public String getDiasBandeja() {
		return diasBandeja;
	}

	public void setDiasBandeja(String diasBandeja) {
		this.diasBandeja = diasBandeja;
	}

	public String getDiasSistema() {
		return diasSistema;
	}

	public void setDiasSistema(String diasSistema) {
		this.diasSistema = diasSistema;
	}

	public String getCodMedioRespuesta() {
		return codMedioRespuesta;
	}

	public void setCodMedioRespuesta(String codMedioRespuesta) {
		this.codMedioRespuesta = codMedioRespuesta;
	}

	public String getFecRespuesta() {
		return fecRespuesta;
	}

	public void setFecRespuesta(String fecRespuesta) {
		this.fecRespuesta = fecRespuesta;
	}

	public String getReclamo() {
		String reclamo = "\nDATOS DE Reclamo:";
		reclamo += "\nglosa: " + this.glosa;
		reclamo += "\nidReclamo: " + this.idReclamo;
		return reclamo;
	}
}
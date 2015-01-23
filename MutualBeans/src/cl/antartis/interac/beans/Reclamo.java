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
	private String codMedio;
	private String fecRespuesta;

	public Reclamo(){}
	
	public Reclamo(long idReclamo, String numAdherente,
			String nombreSolicitante, String emailSolicitante,
			String fonoSolicitante, String regionSolicitante, String codTipo,
			String codMotivo, String codPrioridad, String codCartera,
			String fecIngreso, String glosa, String adjunto,
			String observaciones, String codEstado, String responsableIngreso,
			String responsableActual, String diasBandeja, String diasSistema,
			String codMedio, String fecRespuesta) {
		super();
		this.idReclamo = idReclamo;
		this.numAdherente = numAdherente;
		this.nombreSolicitante = nombreSolicitante;
		this.emailSolicitante = emailSolicitante;
		this.fonoSolicitante = fonoSolicitante;
		this.regionSolicitante = regionSolicitante;
		this.codTipo = codTipo;
		this.codMotivo = codMotivo;
		this.codPrioridad = codPrioridad;
		this.codCartera = codCartera;
		this.fecIngreso = fecIngreso;
		this.glosa = glosa;
		this.adjunto = adjunto;
		this.observaciones = observaciones;
		this.codEstado = codEstado;
		this.responsableIngreso = responsableIngreso;
		this.responsableActual = responsableActual;
		this.diasBandeja = diasBandeja;
		this.diasSistema = diasSistema;
		this.codMedio = codMedio;
		this.fecRespuesta = fecRespuesta;
	}

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

	public String getCodMedio() {
		return codMedio;
	}

	public void setCodMedio(String codMedio) {
		this.codMedio = codMedio;
	}

	public String getFecRespuesta() {
		return fecRespuesta;
	}

	public void setFecRespuesta(String fecRespuesta) {
		this.fecRespuesta = fecRespuesta;
	}

	public String getReclamo() {
		String reclamo = "\nDATOS DE Reclamo:";
		reclamo += "\nidReclamo: " + this.idReclamo;
		reclamo += "\nnumAdherente" +this.numAdherente;
		reclamo += "\nnombreSolicitante" +this.nombreSolicitante; 												
		reclamo += "\nemailSolicitante" +this.emailSolicitante;
		reclamo += "\nfonoSolicitante" +this.fonoSolicitante;
		reclamo += "\nregionSolicitante" +this.regionSolicitante;
		reclamo += "\ncodTipo" +this.codTipo;
		reclamo += "\ncodMotivo" +this.codMotivo;
		reclamo += "\ncodPrioridad" +this.codPrioridad;
		reclamo += "\ncodCartera" +this.codCartera;
		reclamo += "\nfecIngreso" +this.fecIngreso;
		reclamo += "\nglosa" +this.glosa;
		reclamo += "\nadjunto" +this.adjunto;
		reclamo += "\nobservaciones" +this.observaciones;
		reclamo += "\ncodEstado" +this.codEstado;
		reclamo += "\nresponsableIngreso" +this.responsableIngreso;
		reclamo += "\nresponsableActual" +this.responsableActual;
		reclamo += "\ndiasBandeja" +this.diasBandeja;
		reclamo += "\ndiasSistema" +this.diasSistema;
		reclamo += "\ncodMedio" +this.codMedio;
		reclamo += "\nfecRespuesta" +this.fecRespuesta;	
		return reclamo;
	}
	
	public String getEmailBody(){
		String body = "Ha ingresado un nuevo reclamo (codigo de reclamo: "+this.getIdReclamo()+
			") detallado a continuación:\n"+
			"Número adherente: "+ this.numAdherente+"\n"+
			"Nombre solicitante: "+ this.nombreSolicitante+"\n"+
			"Email solicitante: "+ this.emailSolicitante+"\n"+
			"Fono solicitante: "+ this.fonoSolicitante+"\n"+
			"Region solicitante: "+ this.regionSolicitante+"\n"+
			"Código tipo: "+ this.codTipo+"\n"+
			"Código motivo: "+ this.codMotivo+"\n"+
			"Código prioridad: "+ this.codPrioridad+"\n"+
			"Código cartera: "+ this.codCartera+"\n"+
			"Fecha ingreso: "+ this.fecIngreso+"\n"+
			"Glosa: "+ this.glosa+"\n"+
			"Adjunto: "+ this.adjunto+"\n"+
			"Observaciones: "+ this.observaciones+"\n"+
			"Código estado: "+ this.codEstado+"\n"+
			"Responsable ingreso: "+ this.responsableIngreso+"\n"+
			"Responsable actual: "+ this.responsableActual+"\n"+
			"Días bandeja: "+ this.diasBandeja+"\n"+
			"Días sistema: "+ this.diasSistema+"\n"+
			"Código medio respuesta: "+ this.codMedio+"\n"+
			"Fecha respuesta: "+ this.fecRespuesta+"\n\n";
		return body;
	}
}
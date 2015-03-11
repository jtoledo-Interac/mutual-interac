package cl.antartis.interac.beans;

import java.io.Serializable;

public class Empresa implements Serializable {

	private static final long serialVersionUID = 6582859321072220207L;
	private long idEmpresa;
	private String nombre;
	private String codCartera;
	private String nomExperto;
	private String numAdherente;
	private String razonSocial;
	private String direccion;
	private String representante;
	private String contactoRepresentante;
	private String nombrePrevencionista;
	private String contactoPrevencionista;
	private String masaSum;
	private String segmentacion;
	private String multiregional;
	private String numCentros;
	private String holding;
	private String numCHPS;
	private String nomPresidente;
	private String nomSecretario;
	private String saami;
	private String amputaciones;
	private String fatales;
	private String proyectosDesarrollados;
	// CERTIFICACIONES
	// CPHS
	private String numCPHSCertificados;
	private String tipoCertificacion;
	private String fechaCertificacion;
	private String fechaCaducidad;
	// PEC ESTANDAR
	private String fechaCertificacionPECE;
	private String fechaCaducidadPECE;
	private String nivelLogroPECE;
	private String fechaProxAuditoriaPECE;
	// PEC COMPETITIVA
	private String fechaCertificacionPECC;
	private String fechaCaducidadPECC;
	private String nivelLogroPECC;
	private String fechaProxAuditoriaPECC;
	// PEC EXCELENCIA
	private String fechaCertificacionPECEX;
	private String fechaCaducidadPECEX;
	private String nivelLogroPECEX;
	private String fechaProxAuditoriaPECEX;
	// Accidentabilidad
	private String tasaAccidentabilidad;
	private String siniestralidad;
	private String fatalesAcc;
	private String invalidez;
	// Protocolos
	// PREXOR
	private String adherenciaPREX;
	private String fechaAdherenciaPREX;
	private String fechaVencimientoPREX;
	private String indemnizacionesPREX;
	private String numCasosIndemnizacionesPREX;
	private String pensionesPREX;
	private String numCasosPensionesPREX;
	private String actasDifusionPREX;
	private String nivelExposicionPREX;
	// PLANESI
	private String adherenciaPLAN;
	private String fechaAdherenciaPLAN;
	private String fechaVencimientoPLAN;
	private String indemnizacionesPLAN;
	private String numCasosIndemnizacionesPLAN;
	private String pensionesPLAN;
	private String numCasosPensionesPLAN;
	private String actasDifusionPLAN;
	private String nivelExposicionPLAN;
	// PSICOSOCIAL
	private String adherenciaPSICO;
	// TMERS
	private String difusionProtocolo;

	public long getIdEmpresa() {
		return idEmpresa;
	}

	public void setIdEmpresa(long idEmpresa) {
		this.idEmpresa = idEmpresa;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getCodCartera() {
		return codCartera;
	}

	public void setCodCartera(String codCartera) {
		this.codCartera = codCartera;
	}

	public String getNomExperto() {
		return nomExperto;
	}

	public void setNomExperto(String nomExperto) {
		this.nomExperto = nomExperto;
	}

	public String getNumAdherente() {
		return numAdherente;
	}

	public void setNumAdherente(String numAdherente) {
		this.numAdherente = numAdherente;
	}

	public String getRazonSocial() {
		return razonSocial;
	}

	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}

	public String getDireccion() {
		return direccion;
	}
	
	

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getRepresentante() {
		return representante;
	}

	public void setRepresentante(String representante) {
		this.representante = representante;
	}

	public String getContactoRepresentante() {
		return contactoRepresentante;
	}

	public void setContactoRepresentante(String contactoRepresentante) {
		this.contactoRepresentante = contactoRepresentante;
	}

	public String getNombrePrevencionista() {
		return nombrePrevencionista;
	}

	public void setNombrePrevencionista(String nombrePrevencionista) {
		this.nombrePrevencionista = nombrePrevencionista;
	}

	public String getContactoPrevencionista() {
		return contactoPrevencionista;
	}

	public void setContactoPrevencionista(String contactoPrevencionista) {
		this.contactoPrevencionista = contactoPrevencionista;
	}

	public String getMasaSum() {
		return masaSum;
	}

	public void setMasaSum(String masaSum) {
		this.masaSum = masaSum;
	}

	public String getSegmentacion() {
		return segmentacion;
	}

	public void setSegmentacion(String segmentacion) {
		this.segmentacion = segmentacion;
	}

	public String getMultiregional() {
		return multiregional;
	}

	public void setMultiregional(String multiregional) {
		this.multiregional = multiregional;
	}

	public String getNumCentros() {
		return numCentros;
	}

	public void setNumCentros(String numCentros) {
		this.numCentros = numCentros;
	}

	public String getHolding() {
		return holding;
	}

	public void setHolding(String holding) {
		this.holding = holding;
	}

	public String getNumCHPS() {
		return numCHPS;
	}

	public void setNumCHPS(String numCHPS) {
		this.numCHPS = numCHPS;
	}

	public String getNomPresidente() {
		return nomPresidente;
	}

	public void setNomPresidente(String nomPresidente) {
		this.nomPresidente = nomPresidente;
	}

	public String getNomSecretario() {
		return nomSecretario;
	}

	public void setNomSecretario(String nomSecretario) {
		this.nomSecretario = nomSecretario;
	}

	public String getSaami() {
		return saami;
	}

	public void setSaami(String saami) {
		this.saami = saami;
	}

	public String getAmputaciones() {
		return amputaciones;
	}

	public void setAmputaciones(String amputaciones) {
		this.amputaciones = amputaciones;
	}

	public String getFatales() {
		return fatales;
	}

	public void setFatales(String fatales) {
		this.fatales = fatales;
	}

	public String getProyectosDesarrollados() {
		return proyectosDesarrollados;
	}

	public void setProyectosDesarrollados(String proyectosDesarrollados) {
		this.proyectosDesarrollados = proyectosDesarrollados;
	}

	public String getNumCPHSCertificados() {
		return numCPHSCertificados;
	}

	public void setNumCPHSCertificados(String numCPHSCertificados) {
		this.numCPHSCertificados = numCPHSCertificados;
	}

	public String getTipoCertificacion() {
		return tipoCertificacion;
	}

	public void setTipoCertificacion(String tipoCertificacion) {
		this.tipoCertificacion = tipoCertificacion;
	}

	public String getFechaCertificacion() {
		return fechaCertificacion;
	}

	public void setFechaCertificacion(String fechaCertificacion) {
		this.fechaCertificacion = fechaCertificacion;
	}

	public String getFechaCaducidad() {
		return fechaCaducidad;
	}

	public void setFechaCaducidad(String fechaCaducidad) {
		this.fechaCaducidad = fechaCaducidad;
	}

	public String getFechaCertificacionPECE() {
		return fechaCertificacionPECE;
	}

	public void setFechaCertificacionPECE(String fechaCertificacionPECE) {
		this.fechaCertificacionPECE = fechaCertificacionPECE;
	}

	public String getFechaCaducidadPECE() {
		return fechaCaducidadPECE;
	}

	public void setFechaCaducidadPECE(String fechaCaducidadPECE) {
		this.fechaCaducidadPECE = fechaCaducidadPECE;
	}

	public String getNivelLogroPECE() {
		return nivelLogroPECE;
	}

	public void setNivelLogroPECE(String nivelLogroPECE) {
		this.nivelLogroPECE = nivelLogroPECE;
	}

	public String getFechaProxAuditoriaPECE() {
		return fechaProxAuditoriaPECE;
	}

	public void setFechaProxAuditoriaPECE(String fechaProxAuditoriaPECE) {
		this.fechaProxAuditoriaPECE = fechaProxAuditoriaPECE;
	}

	public String getFechaCertificacionPECC() {
		return fechaCertificacionPECC;
	}

	public void setFechaCertificacionPECC(String fechaCertificacionPECC) {
		this.fechaCertificacionPECC = fechaCertificacionPECC;
	}

	public String getFechaCaducidadPECC() {
		return fechaCaducidadPECC;
	}

	public void setFechaCaducidadPECC(String fechaCaducidadPECC) {
		this.fechaCaducidadPECC = fechaCaducidadPECC;
	}

	public String getNivelLogroPECC() {
		return nivelLogroPECC;
	}

	public void setNivelLogroPECC(String nivelLogroPECC) {
		this.nivelLogroPECC = nivelLogroPECC;
	}

	public String getFechaProxAuditoriaPECC() {
		return fechaProxAuditoriaPECC;
	}

	public void setFechaProxAuditoriaPECC(String fechaProxAuditoriaPECC) {
		this.fechaProxAuditoriaPECC = fechaProxAuditoriaPECC;
	}

	public String getFechaCertificacionPECEX() {
		return fechaCertificacionPECEX;
	}

	public void setFechaCertificacionPECEX(String fechaCertificacionPECEX) {
		this.fechaCertificacionPECEX = fechaCertificacionPECEX;
	}

	public String getFechaCaducidadPECEX() {
		return fechaCaducidadPECEX;
	}

	public void setFechaCaducidadPECEX(String fechaCaducidadPECEX) {
		this.fechaCaducidadPECEX = fechaCaducidadPECEX;
	}

	public String getNivelLogroPECEX() {
		return nivelLogroPECEX;
	}

	public void setNivelLogroPECEX(String nivelLogroPECEX) {
		this.nivelLogroPECEX = nivelLogroPECEX;
	}

	public String getFechaProxAuditoriaPECEX() {
		return fechaProxAuditoriaPECEX;
	}

	public void setFechaProxAuditoriaPECEX(String fechaProxAuditoriaPECEX) {
		this.fechaProxAuditoriaPECEX = fechaProxAuditoriaPECEX;
	}

	public String getTasaAccidentabilidad() {
		return tasaAccidentabilidad;
	}

	public void setTasaAccidentabilidad(String tasaAccidentabilidad) {
		this.tasaAccidentabilidad = tasaAccidentabilidad;
	}

	public String getSiniestralidad() {
		return siniestralidad;
	}

	public void setSiniestralidad(String siniestralidad) {
		this.siniestralidad = siniestralidad;
	}

	public String getFatalesAcc() {
		return fatalesAcc;
	}

	public void setFatalesAcc(String fatalesAcc) {
		this.fatalesAcc = fatalesAcc;
	}

	public String getInvalidez() {
		return invalidez;
	}

	public void setInvalidez(String invalidez) {
		this.invalidez = invalidez;
	}

	public String getAdherenciaPREX() {
		return adherenciaPREX;
	}

	public void setAdherenciaPREX(String adherenciaPREX) {
		this.adherenciaPREX = adherenciaPREX;
	}

	public String getFechaAdherenciaPREX() {
		return fechaAdherenciaPREX;
	}

	public void setFechaAdherenciaPREX(String fechaAdherenciaPREX) {
		this.fechaAdherenciaPREX = fechaAdherenciaPREX;
	}

	public String getFechaVencimientoPREX() {
		return fechaVencimientoPREX;
	}

	public void setFechaVencimientoPREX(String fechaVencimientoPREX) {
		this.fechaVencimientoPREX = fechaVencimientoPREX;
	}

	public String getIndemnizacionesPREX() {
		return indemnizacionesPREX;
	}

	public void setIndemnizacionesPREX(String indemnizacionesPREX) {
		this.indemnizacionesPREX = indemnizacionesPREX;
	}

	public String getNumCasosIndemnizacionesPREX() {
		return numCasosIndemnizacionesPREX;
	}

	public void setNumCasosIndemnizacionesPREX(
			String numCasosIndemnizacionesPREX) {
		this.numCasosIndemnizacionesPREX = numCasosIndemnizacionesPREX;
	}

	public String getPensionesPREX() {
		return pensionesPREX;
	}

	public void setPensionesPREX(String pensionesPREX) {
		this.pensionesPREX = pensionesPREX;
	}

	public String getNumCasosPensionesPREX() {
		return numCasosPensionesPREX;
	}

	public void setNumCasosPensionesPREX(String numCasosPensionesPREX) {
		this.numCasosPensionesPREX = numCasosPensionesPREX;
	}

	public String getActasDifusionPREX() {
		return actasDifusionPREX;
	}

	public void setActasDifusionPREX(String actasDifusionPREX) {
		this.actasDifusionPREX = actasDifusionPREX;
	}

	public String getNivelExposicionPREX() {
		return nivelExposicionPREX;
	}

	public void setNivelExposicionPREX(String nivelExposicionPREX) {
		this.nivelExposicionPREX = nivelExposicionPREX;
	}

	public String getAdherenciaPLAN() {
		return adherenciaPLAN;
	}

	public void setAdherenciaPLAN(String adherenciaPLAN) {
		this.adherenciaPLAN = adherenciaPLAN;
	}

	public String getFechaAdherenciaPLAN() {
		return fechaAdherenciaPLAN;
	}

	public void setFechaAdherenciaPLAN(String fechaAdherenciaPLAN) {
		this.fechaAdherenciaPLAN = fechaAdherenciaPLAN;
	}

	public String getFechaVencimientoPLAN() {
		return fechaVencimientoPLAN;
	}

	public void setFechaVencimientoPLAN(String fechaVencimientoPLAN) {
		this.fechaVencimientoPLAN = fechaVencimientoPLAN;
	}

	public String getIndemnizacionesPLAN() {
		return indemnizacionesPLAN;
	}

	public void setIndemnizacionesPLAN(String indemnizacionesPLAN) {
		this.indemnizacionesPLAN = indemnizacionesPLAN;
	}

	public String getNumCasosIndemnizacionesPLAN() {
		return numCasosIndemnizacionesPLAN;
	}

	public void setNumCasosIndemnizacionesPLAN(
			String numCasosIndemnizacionesPLAN) {
		this.numCasosIndemnizacionesPLAN = numCasosIndemnizacionesPLAN;
	}

	public String getPensionesPLAN() {
		return pensionesPLAN;
	}

	public void setPensionesPLAN(String pensionesPLAN) {
		this.pensionesPLAN = pensionesPLAN;
	}

	public String getNumCasosPensionesPLAN() {
		return numCasosPensionesPLAN;
	}

	public void setNumCasosPensionesPLAN(String numCasosPensionesPLAN) {
		this.numCasosPensionesPLAN = numCasosPensionesPLAN;
	}

	public String getActasDifusionPLAN() {
		return actasDifusionPLAN;
	}

	public void setActasDifusionPLAN(String actasDifusionPLAN) {
		this.actasDifusionPLAN = actasDifusionPLAN;
	}

	public String getNivelExposicionPLAN() {
		return nivelExposicionPLAN;
	}

	public void setNivelExposicionPLAN(String nivelExposicionPLAN) {
		this.nivelExposicionPLAN = nivelExposicionPLAN;
	}

	public String getAdherenciaPSICO() {
		return adherenciaPSICO;
	}

	public void setAdherenciaPSICO(String adherenciaPSICO) {
		this.adherenciaPSICO = adherenciaPSICO;
	}

	public String getDifusionProtocolo() {
		return difusionProtocolo;
	}

	public void setDifusionProtocolo(String difusionProtocolo) {
		this.difusionProtocolo = difusionProtocolo;
	}

	public String getEmpresa() {
		String empresa = "\nDATOS DE Empresa:";
		empresa += "\nidEmpresa: " + this.idEmpresa;
		empresa += "\nnombre: " + this.nombre;
		empresa += "\ncodCartera: " + this.codCartera;
		empresa += "\nnomExperto: "+ this.nomExperto;
		empresa += "\nnumAdherente: " + this.numAdherente;
		empresa += "\nrazonSocial: " + this.razonSocial;
		empresa += "\ndireccion: " + this.direccion;
		empresa += "\nrepresentante: " + this.representante;
		empresa += "\ncontactoRepresentante: " + this.contactoRepresentante;
	/*
	empresa += "\nnombrePrevencionista;
	empresa += "\ncontactoPrevencionista;
	empresa += "\nmasaSum;
	empresa += "\nsegmentacion;
	empresa += "\nmultiregional;
	empresa += "\nnumCentros;
	empresa += "\nholding;
	empresa += "\nnumCHPS;
	empresa += "\nnomPresidente;
	empresa += "\nnomSecretario;
	empresa += "\nsaami;
	empresa += "\namputaciones;
	empresa += "\nfatales;
	empresa += "\nproyectosDesarrollados;
	// CERTIFICACONES
	// CPHS
	empresa += "\nnumCPHSCertificados;
	empresa += "\ntipoCertificacion;
	empresa += "\nfechaCertificacion;
	empresa += "\nfechaCaducidad;
	// PEC ESTANDAR
	empresa += "\nfechaCertificacionPECE;
	empresa += "\nfechaCaducidadPECE;
	empresa += "\nnivelLogroPECE;
	empresa += "\nfechaProxAuditoriaPECE;
	// PEC COMPETITIVA
	empresa += "\nfechaCertificacionPECC;
	empresa += "\nfechaCaducidadPECC;
	empresa += "\nnivelLogroPECC;
	empresa += "\nfechaProxAuditoriaPECC;
	// PEC EXCELENCIA
	empresa += "\nfechaCertificacionPECEX;
	empresa += "\nfechaCaducidadPECEX;
	empresa += "\nnivelLogroPECEX;
	empresa += "\nfechaProxAuditoriaPECEX;
	// Accidentabilidad
	empresa += "\ntasaAccidentabilidad;
	empresa += "\nsiniestralidad;
	empresa += "\nfatalesAcc;
	empresa += "\ninvalidez;
	// Protocolo
	// PREXOR
	empresa += "\nadherenciaPREX;
	empresa += "\nfechaAdherenciaPREX;
	empresa += "\nfechaVencimientoPREX;
	empresa += "\nindemnizacionesPREX;
	empresa += "\nnumCasosIndemnizacionesPREX;
	empresa += "\npensionesPREX;
	empresa += "\nnumCasosPensionesPREX;
	empresa += "\nactasDifusionPREX;
	empresa += "\nnivelExposicionPREX;
	// PLANESI
	empresa += "\nadherenciaPLAN;
	empresa += "\nfechaAdherenciaPLAN;
	empresa += "\nfechaVencimientoPLAN;
	empresa += "\nindemnizacionesPLAN;
	empresa += "\nnumCasosIndemnizacionesPLAN;
	empresa += "\npensionesPLAN;
	empresa += "\nnumCasosPensionesPLAN;
	empresa += "\nactasDifusionPLAN;
	empresa += "\nnivelExposicionPLAN;
	// PSICOSOCIAL
	empresa += "\nadherenciaPSICO;
	// TMERS
	empresa += "\ndifusionProtocolo;*/
		
		return empresa;
	}
}
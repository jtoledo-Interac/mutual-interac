<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript"> 	
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>
	
<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarEmpresa">		
	<table class="centrado">
		<tr>
			<td>Nombre</td><td> : </td>
			<td><input type="text" 	id="nombre"	name="nombre"	value="${empresa.nombre}"	placeholder="Nombre Empresa"></td>
		</tr>
		<tr>
			<td>Código Cartera</td><td> : </td>
			<td><input type="text" 		id="codCartera" 	name="codCartera" value="${empresa.codCartera}"	placeholder="Código Cartera" required></td>
		</tr>
		<tr>
			<td>Nombre Experto</td><td> : </td>
			<td><input type="text" 		id="nomExperto" 	name="nomExperto" value="${empresa.nomExperto}"	placeholder="Nombre Experto" required></td>
		</tr>
		<tr>
			<td>Número Adherente</td><td> : </td>
			<td><input type="text" 		id="numAdherente" 	name="numAdherente"	value="${empresa.numAdherente}" placeholder="Nº Adherente"></td>
		</tr>
		<tr>
			<td>Razón Social</td><td> : </td>
			<td><input type="text" 		id="razonSocial" 	name="razonSocial" value="${empresa.razonSocial}"	placeholder="Razón Social" required></td>
		</tr>
		<tr>
			<td>Dirección</td><td> : </td>
			<td><input type="text" 		id="direccion" 	name="direccion" value="${empresa.direccion}"	placeholder="Dirección" required></td>
		</tr>
		<tr>
			<td>Representante</td><td> : </td>
			<td><input type="text" 		id="representante" 	name="representante" value="${empresa.representante}"	placeholder="Representante" required></td>
		</tr>
		<tr>
			<td>Contacto Representante</td><td> : </td>
			<td><input type="text" 		id="contactoRepresentante" 	name="contactoRepresentante" value="${empresa.contactoRepresentante}"	placeholder="Contacto Rerpresentante" required></td>
		</tr>
		<tr>
			<td>Nombre Prevencionista</td><td> : </td>
			<td><input type="text" 		id="nombrePrevencionista" 	name="nombrePrevencionista"	placeholder="Nombre Prevencionista" value="${empresa.nombrePrevencionista}" required></td>
		</tr>
		<tr>
			<td>Contacto Prevencionista</td><td> : </td>
			<td><input type="text" 		id="contactoPrevencionista" 	name="contactoPrevencionista" value="${empresa.contactoPrevencionista}"	placeholder="Contacto Prevencionista" required></td>
		</tr>
		<tr>
			<td>Masa Sum</td><td> : </td>
			<td><input type="text" 		id="masaSum" 	name="masaSum" value="${empresa.masaSum}"	placeholder="Masa Sum" required></td>
		</tr>
		<tr>
			<td>Segmentación</td><td> : </td>
			<td><input type="text" 		id="segmentacion" 	name="segmentacion" value="${empresa.segmentacion}"	placeholder="Segmentación" required></td>
		</tr>
		<tr>
			<td>Multi Regional</td><td> : </td>
			<td><input type="text" 		id="multiregional" 	name="multiregional" value="${empresa.multiregional}"	placeholder="Multi Regional" required></td>
		</tr>
		<tr>
			<td>Número de Centros</td><td> : </td>
			<td><input type="text" 		id="numCentros" 	name="numCentros" value="${empresa.numCentros}"	placeholder="Número de Centros" required></td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td><input type="text" 		id="holding" 	name="holding" value="${empresa.holding}"	placeholder="Holding" required></td>
		</tr>
		<tr>
			<td>Número CHPS</td><td> : </td>
			<td><input type="text" 		id="numCHPS" 	name="numCHPS" value="${empresa.numCHPS}"	placeholder="Númer CHPS" required></td>
		</tr>
		<tr>
			<td>Nombre Presidente</td><td> : </td>
			<td><input type="text" 		id="nomPresidente" 	name="nomPresidente" value="${empresa.nomPresidente}"	placeholder="Nombre Presidente" required></td>
		</tr>
		<tr>
			<td>Nombre Secretario</td><td> : </td>
			<td><input type="text" 		id="nomSecretario" 	name="nomSecretario" value="${empresa.nomSecretario}"	placeholder="Nombre Secretario" required></td>
		</tr>
		<tr>
			<td>Saami</td><td> : </td>
			<td><input type="text" 		id="saami" 	name="saami" value="${empresa.saami}"	placeholder="Saami" required></td>
		</tr>
		<tr>
			<td>Amputaciones</td><td> : </td>
			<td><input type="text" 		id="amputaciones" 	name="amputaciones" value="${empresa.amputaciones}"	placeholder="Amputaciones" required></td>
		</tr>
		<tr>
			<td>Fatales</td><td> : </td>
			<td><input type="text" 		id="fatales" 	name="fatales" value="${empresa.fatales}"	placeholder="Fatales" required></td>
		</tr>
		<tr>
			<td>Proyectos Desarrollados</td><td> : </td>
			<td><input type="text" 		id="proyectosDesarrollados" 	name="proyectoDesarrollados" value="${empresa.proyectosDesarrollados}"	placeholder="Proyecto Desarrollados" required></td>
		</tr>
		<!-- Certificaciones CHPS -->
		<tr>
			<td>Número Certificacion CHPS</td><td> : </td>
			<td> <input type="text"		id="numCPHSCertificados" value="${empresa.numCPHSCertificados}"	name="numCPHSCertificados" 		placeholder="N° Certificación CHPS" ></td>
		</tr>
		<tr>
			<td>Tipo Certificación CHPS</td><td> : </td>
			<td><input type="text" 		id="tipoCertificacion" 	name="tipoCertificacion" value="${empresa.tipoCertificacion}"	placeholder="Tipo Certificación" ></td>
		</tr>
		<tr>
			<td>Fecha Certificación CHPS</td><td> : </td>
			<td><input type="text" 		id="fechaCertificacion" 	name="fechaCertificacion" value="${empresa.fechaCertificacion}"	placeholder="Fecha Certificación" ></td>
		</tr>
		<tr>
			<td>Fecha Caducidad Certificado</td><td> : </td>
			<td><input type="text" 		id="fechaCaducidad" 	name="fechaCaducidad" value="${empresa.fechaCaducidad}"	placeholder="Fecha Caducidad" ></td>
		</tr>
		<!-- PEC Estandar -->
		<tr>
			<td>Fecha Certificación PEC Estandar</td><td> : </td>
			<td> <input type="text"		id="fechaCertificacionPECE" 		name="fechaCertificacionPECE" 	value="${empresa.fechaCertificacionPECE}"	placeholder="Fecha Certificacion PEC Estandar" ></td>
		</tr>
		<tr>
			<td>Fecha Caducidad PEC Estandar</td><td> : </td>
			<td> <input type="text"		id="fechaCaducidadPECE" 		name="fechaCaducidadPECE" 	value="${empresa.fechaCaducidadPECE}"	placeholder="Fecha Caducidad PEC Estandar" ></td>
		</tr>
		<tr>
			<td>Nivel Logro PEC Estandar</td><td> : </td>
			<td> <input type="text"		id="nivelLogroPECE" 		name="nivelLogroPECE" 	value="${empresa.nivelLogroPECE}"	placeholder="Nivel Logro PEC Estandar" ></td>
		</tr>
		<tr>
			<td>Fecha Proxima Auditoria PEC Estandar</td><td> : </td>
			<td> <input type="text"		id="fechaProxAuditoriaPECE" 		name="fechaProxAuditoriaPECE" 	value="${empresa.fechaProxAuditoriaPECE}"	placeholder="Fecha Proxima Auditoria PEC Estandar" ></td>
		</tr>
		<!-- PEC Competitiva -->
		<tr>
			<td>Fecha Certificación PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="fechaCertificacionPECC" 		name="fechaCertificacionPECC" 	value="${empresa.fechaCertificacionPECC}"	placeholder="Fecha Certificacion PEC Competitivo" ></td>
		</tr>
		<tr>
			<td>Fecha Caducidad PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="fechaCaducidadPECC" 		name="fechaCaducidadPECE" 	value="${empresa.fechaCaducidadPECE}"	placeholder="Fecha Caducidad PEC Competitivo" ></td>
		</tr>
		<tr>
			<td>Nivel Logro PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="nivelLogroPECC" 		name="nivelLogroPECC" 	value="${empresa.nivelLogroPECC}"	placeholder="Nivel Logro PEC Competitivo" ></td>
		</tr>
		<tr>
			<td>Fecha Proxima Auditoria PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="fechaProxAuditoriaPECC" 		name="fechaProxAuditoriaPECC" 	value="${empresa.fechaProxAuditoriaPECC}"	placeholder="Fecha Proxima Auditoria PEC Competitivo" ></td>
		</tr>
		<!-- PEC Excelencia -->
		<tr>
			<td>Fecha Certificación PEC Excelencia</td><td> : </td>
			<td> <input type="text"		id="fechaCertificacionPECEX" 		name="fechaCertificacionPECEX" 	value="${empresa.fechaCertificacionPECEX}"	placeholder="Fecha Certificacion PEC Excelencia" ></td>
		</tr>
		<tr>
			<td>Fecha Caducidad PEC Excelencia</td><td> : </td>
			<td> <input type="text"		id="fechaCaducidadPECEX" 		name="fechaCaducidadPECEX" 	value="${empresa.fechaCaducidadPECEX}"	placeholder="Fecha Caducidad PEC Excelencia" ></td>
		</tr>
		<tr>
			<td>Nivel Logro PEC Excelencia</td><td> : </td>
			<td> <input type="text"		id="nivelLogroPECEX" 		name="nivelLogroPECEX" 	value="${empresa.nivelLogroPECEX}"	placeholder="Nivel Logro PECEX" ></td>
		</tr>
		<tr>
			<td>Fecha Proxima Auditoria PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="fechaProxAuditoriaPECEX" 		name="fechaProxAuditoriaPECEX" 	value="${empresa.fechaProxAuditoriaPECEX}"	placeholder="Fecha Proxima Auditoria PEC Excelencia" ></td>
		</tr>
		<!-- Accidentabilidad -->
		<tr>
			<td>Tasa Accidentabilidad</td><td> : </td>
			<td> <input type="text"		id="tasaAccidentabilidad" 		name="tasaAccidentabilidad" 	value="${empresa.tasaAccidentabilidad}"	placeholder="Tasa Accidentabilidad" ></td>
		</tr>
		<tr>
			<td>Siniestabilidad</td><td> : </td>
			<td> <input type="text"		id="siniestralidad" 		name="siniestralidad" 	value="${empresa.siniestralidad}"	placeholder="Siniestabilidad" ></td>
		</tr>
		<tr>
			<td>Cantidad Accidentes Fatales</td><td> : </td>
			<td> <input type="text"		id="fatalesAcc" 		name="fatalesAcc" 	value="${empresa.fatalesAcc}"	placeholder="Cantidad Accidentes Fatales" ></td>
		</tr>
		<tr>
			<td>Invalidez</td><td> : </td>
			<td> <input type="text"		id="invalidez" 		name="invalidez" 	value="${empresa.invalidez}"	placeholder="Invalidez" ></td>
		</tr>
		<!-- Protocolo PREXOR -->
		<tr>
			<td>adherenciaPREX</td><td> : </td>
			<td> <input type="text"		id="adherenciaPREX" 		name="adherenciaPREX" 	value="${empresa.adherenciaPREX}"	placeholder="adherenciaPREX" ></td>
		</tr>
		<tr>
			<td>fechaAdherenciaPREX</td><td> : </td>
			<td> <input type="text"		id="fechaAdherenciaPREX" 		name="fechaAdherenciaPREX" 	value="${empresa.fechaAdherenciaPREX}"	placeholder="fechaAdherenciaPREX" ></td>
		</tr>
		<tr>
			<td>fechaVencimientoPREX</td><td> : </td>
			<td> <input type="text"		id="fechaVencimientoPREX" 		name="fechaVencimientoPREX" 	value="${empresa.fechaVencimientoPREX}"	placeholder="fechaVencimientoPREX" ></td>
		</tr>
		<tr>
			<td>indemnizacionesPREX</td><td> : </td>
			<td> <input type="text"		id="indemnizacionesPREX" 		name="indemnizacionesPREX" 	value="${empresa.indemnizacionesPREX}"	placeholder="indemnizacionesPREX" ></td>
		</tr>
		<tr>
			<td>numCasosIndemnizacionesPREX</td><td> : </td>
			<td> <input type="text"		id="numCasosIndemnizacionesPREX" 		name="numCasosIndemnizacionesPREX" 	value="${empresa.numCasosIndemnizacionesPREX}"	placeholder="numCasosIndemnizacionesPREX" ></td>
		</tr>
		<tr>
			<td>pensionesPREX</td><td> : </td>
			<td> <input type="text"		id="pensionesPREX" 		name="pensionesPREX" 	value="${empresa.pensionesPREX}"	placeholder="pensionesPREX" ></td>
		</tr>
		<tr>
			<td>numCasosPensionesPREX</td><td> : </td>
			<td> <input type="text"		id="numCasosPensionesPREX" 		name="numCasosPensionesPREX" 	value="${empresa.numCasosPensionesPREX}"	placeholder="numCasosPensionesPREX" ></td>
		</tr>
		<tr>
			<td>actasDifusionPREX</td><td> : </td>
			<td> <input type="text"		id="actasDifusionPREX" 		name="actasDifusionPREX" 	value="${empresa.actasDifusionPREX}"	placeholder="actasDifusionPREX" ></td>
		</tr>
		<tr>
			<td>nivelExposicionPREX</td><td> : </td>
			<td> <input type="text"		id="nivelExposicionPREX" 		name="nivelExposicionPREX" 	value="${empresa.nivelExposicionPREX}"	placeholder="nivelExposicionPREX" ></td>
		</tr>
		<!-- PLANESI -->
		<tr>
			<td>adherenciaPLAN</td><td> : </td>
			<td> <input type="text"		id="adherenciaPLAN" 		name="adherenciaPLAN" 	value="${empresa.adherenciaPLAN}"	placeholder="adherenciaPLAN" ></td>
		</tr>
		<tr>
			<td>fechaAdherenciaPLAN</td><td> : </td>
			<td> <input type="text"		id="fechaAdherenciaPLAN" 		name="fechaAdherenciaPLAN" 	value="${empresa.fechaAdherenciaPLAN}"	placeholder="fechaAdherenciaPLAN" ></td>
		</tr>
		<tr>
			<td>fechaVencimientoPLAN</td><td> : </td>
			<td> <input type="text"		id="fechaVencimientoPLAN" 		name="fechaVencimientoPLAN" 	value="${empresa.fechaVencimientoPLAN}"	placeholder="fechaVencimientoPLAN" ></td>
		</tr>
		<tr>
			<td>indemnizacionesPLAN</td><td> : </td>
			<td> <input type="text"		id="indemnizacionesPLAN" 		name="indemnizacionesPLAN" 	value="${empresa.indemnizacionesPLAN}"	placeholder="indemnizacionesPLAN" ></td>
		</tr>
		<tr>
			<td>numCasosIndemnizacionesPLAN</td><td> : </td>
			<td> <input type="text"		id="numCasosIndemnizacionesPLAN" 		name="numCasosIndemnizacionesPLAN" 	value="${empresa.numCasosIndemnizacionesPLAN}"	placeholder="numCasosIndemnizacionesPLAN" ></td>
		</tr>
		<tr>
			<td>pensionesPLAN</td><td> : </td>
			<td> <input type="text"		id="pensionesPLAN" 		name="pensionesPLAN" 	value="${empresa.pensionesPLAN}"	placeholder="pensionesPLAN" ></td>
		</tr>
		<tr>
			<td>numCasosPensionesPLAN</td><td> : </td>
			<td> <input type="text"		id="numCasosPensionesPLAN" 		name="numCasosPensionesPLAN" 	value="${empresa.numCasosPensionesPLAN}"	placeholder="numCasosPensionesPLAN" ></td>
		</tr>
		<tr>
			<td>actasDifusionPLAN</td><td> : </td>
			<td> <input type="text"		id="actasDifusionPLAN" 		name="actasDifusionPLAN" 	value="${empresa.actasDifusionPLAN}"	placeholder="actasDifusionPLAN" ></td>
		</tr>
		<tr>
			<td>nivelExposicionPLAN</td><td> : </td>
			<td> <input type="text"		id="nivelExposicionPLAN" 		name="nivelExposicionPLAN" 	value="${empresa.nivelExposicionPLAN}"	placeholder="nivelExposicionPLAN" ></td>
		</tr>
		<!-- Psicosocial -->
		<tr>
			<td>adherenciaPSICO</td><td> : </td>
			<td> <input type="text"		id="adherenciaPSICO" 		name="adherenciaPSICO" 	value="${empresa.adherenciaPSICO}"	placeholder="adherenciaPSICO" ></td>
		</tr>
		<!-- TMERS -->
		<tr>
			<td>difusionProtocolo</td><td> : </td>
			<td> <input type="text"		id="difusionProtocolo" 		name="difusionProtocolo" 	value="${empresa.difusionProtocolo}"	placeholder="difusionProtocolo" ></td>
		</tr>
		</table>
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idEmpresa" name="idEmpresa" value="${empresa.idEmpresa}">
</form>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  //$('select').select2();
</script>
<script type="text/javascript"> 
$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarEmpresa">
	<input type="submit" class="submit" style="display:none;">
	<table>
		<tr>
			<td>Nombre</td><td> : </td>
			<td> <input type="text"		id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" required></td>
		</tr>
		<tr>
			<td>Código Cartera</td><td> : </td>
			<td><input type="text" 		id="codCartera" 	name="codCartera"	placeholder="Código Cartera" required></td>
		</tr>
		<tr>
			<td>Nombre Experto</td><td> : </td>
			<td><input type="text" 		id="nomExperto" 	name="nomExperto"	placeholder="Nombre Experto" required></td>
		</tr>
		<tr>
			<td>Número Adherente</td><td> : </td>
			<td><input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" required></td>
		</tr>
		<tr>
			<td>Razón Social</td><td> : </td>
			<td><input type="text" 		id="razonSocial" 	name="razonSocial"	placeholder="Razón Social" required></td>
		</tr>
		<tr>
			<td>Dirección</td><td> : </td>
			<td><input type="text" 		id="direccion" 	name="direccion"	placeholder="Dirección" required></td>
		</tr>
		<tr>
			<td>Representante</td><td> : </td>
			<td><input type="text" 		id="representante" 	name="representante"	placeholder="Representante" required ></td>
		</tr>
		<tr>
			<td>Contacto Representante</td><td> : </td>
			<td><input type="text" 		id="contactoRepresentante" 	name="contactoRepresentante"	placeholder="Contacto Rerpresentante" required ></td>
		</tr>
		<tr>
			<td>Nombre Prevencionista</td><td> : </td>
			<td><input type="text" 		id="nombrePrevencionista" 	name="nombrePrevencionista"	placeholder="Nombre Prevencionista" required></td>
		</tr>
		<tr>
			<td>Contacto Prevencionista</td><td> : </td>
			<td><input type="text" 		id="contactoPrevencionista" 	name="contactoPrevencionista"	placeholder="Contacto Prevencionista" required></td>
		</tr>
		<tr>
			<td>Masa Sum</td><td> : </td>
			<td><input type="text" 		id="masaSum" 	name="masaSum"	placeholder="Masa Sum" required></td>
		</tr>
		<tr>
			<td>Segmentación</td><td> : </td>
			<td><input type="text" 		id="segmentacion" 	name="segmentacion"	placeholder="Segmentación" required></td>
		</tr>
		<tr>
			<td>Multi Regional</td><td> : </td>
			<td><input type="text" 		id="multiregional" 	name="multiregional"	placeholder="Multi Regional" required></td>
		</tr>
		<tr>
			<td>Número de Centros</td><td> : </td>
			<td><input type="text" 		id="numCentros" 	name="numCentros"	placeholder="Número de Centros" required></td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td><input type="text" 		id="holding" 	name="holding"	placeholder="Holding" required></td>
		</tr>
		<tr>
			<td>Número CHPS</td><td> : </td>
			<td><input type="text" 		id="numCHPS" 	name="numCHPS"	placeholder="Númer CHPS" required></td>
		</tr>
		<tr>
			<td>Nombre Presidente</td><td> : </td>
			<td><input type="text" 		id="nomPresidente" 	name="nomPresidente"	placeholder="Nombre Presidente" required></td>
		</tr>
		<tr>
			<td>Nombre Secretario</td><td> : </td>
			<td><input type="text" 		id="nomSecretario" 	name="nomSecretario"	placeholder="Nombre Secretario" required></td>
		</tr>
		<tr>
			<td>Saami</td><td> : </td>
			<td><input type="text" 		id="saami" 	name="saami"	placeholder="Saami" required></td>
		</tr>
		<tr>
			<td>Amputaciones</td><td> : </td>
			<td><input type="text" 		id="amputaciones" 	name="amputaciones"	placeholder="Amputaciones" required></td>
		</tr>
		<tr>
			<td>Fatales</td><td> : </td>
			<td><input type="text" 		id="fatales" 	name="fatales"	placeholder="Fatales" required></td>
		</tr>
		<tr>
			<td>Proyectos Desarrollados</td><td> : </td>
			<td><input type="text" 		id="proyectosDesarrollados" 	name="proyectoDesarrollados"	placeholder="Proyecto Desarrollados" required></td>
		</tr>
		<!-- Certificaciones CHPS -->
		<tr>
			<td>Número Certificacion CHPS</td><td> : </td>
			<td> <input type="text"		id="numCPHSCertificados" 		name="numCPHSCertificados" 		placeholder="N° Certificación CHPS" required></td>
		</tr>
		<tr>
			<td>Tipo Certificación CHPS</td><td> : </td>
			<td><input type="text" 		id="tipoCertificacion" 	name="tipoCertificacion"	placeholder="Tipo Certificación" required></td>
		</tr>
		<tr>
			<td>Fecha Certificación CHPS</td><td> : </td>
			<td><input type="text" 		id="fechaCertificacion" 	name="fechaCertificacion"	placeholder="Fecha Certificación" required></td>
		</tr>
		<tr>
			<td>Fecha Caducidad Certificado</td><td> : </td>
			<td><input type="text" 		id="fechaCaducidad" 	name="fechaCaducidad"	placeholder="Fecha Caducidad" required></td>
		</tr>
		<!-- PEC Estandar -->
		<tr>
			<td>Fecha Certificación PEC Estandar</td><td> : </td>
			<td> <input type="text"		id="fechaCertificacionPECE" 		name="fechaCertificacionPECE" 		placeholder="Fecha Certificacion PEC Estandar" required></td>
		</tr>
		<tr>
			<td>Fecha Caducidad PEC Estandar</td><td> : </td>
			<td> <input type="text"		id="fechaCaducidadPECE" 		name="fechaCaducidadPECE" 		placeholder="Fecha Caducidad PEC Estandar" required></td>
		</tr>
		<tr>
			<td>Nivel Logro PEC Estandar</td><td> : </td>
			<td> <input type="text"		id="nivelLogroPECE" 		name="nivelLogroPECE" 		placeholder="Nivel Logro PEC Estandar" required></td>
		</tr>
		<tr>
			<td>Fecha Proxima Auditoria PEC Estandar</td><td> : </td>
			<td> <input type="text"		id="fechaProxAuditoriaPECE" 		name="fechaProxAuditoriaPECE" 		placeholder="Fecha Proxima Auditoria PEC Estandar" required></td>
		</tr>
		<!-- PEC Competitiva -->
		<tr>
			<td>Fecha Certificación PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="fechaCertificacionPECC" 		name="fechaCertificacionPECC" 		placeholder="Fecha Certificacion PEC Competitivo" required></td>
		</tr>
		<tr>
			<td>Fecha Caducidad PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="fechaCaducidadPECC" 		name="fechaCaducidadPECE" 		placeholder="Fecha Caducidad PEC Competitivo" required></td>
		</tr>
		<tr>
			<td>Nivel Logro PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="nivelLogroPECC" 		name="nivelLogroPECC" 		placeholder="Nivel Logro PEC Competitivo" required></td>
		</tr>
		<tr>
			<td>Fecha Proxima Auditoria PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="fechaProxAuditoriaPECC" 		name="fechaProxAuditoriaPECC" 		placeholder="Fecha Proxima Auditoria PEC Competitivo" required></td>
		</tr>
		<!-- PEC Excelencia -->
		<tr>
			<td>Fecha Certificación PEC Excelencia</td><td> : </td>
			<td> <input type="text"		id="fechaCertificacionPECEX" 		name="fechaCertificacionPECEX" 		placeholder="Fecha Certificacion PEC Excelencia" required></td>
		</tr>
		<tr>
			<td>Fecha Caducidad PEC Excelencia</td><td> : </td>
			<td> <input type="text"		id="fechaCaducidadPECEX" 		name="fechaCaducidadPECEX" 		placeholder="Fecha Caducidad PEC Excelencia" required></td>
		</tr>
		<tr>
			<td>Nivel Logro PEC Excelencia</td><td> : </td>
			<td> <input type="text"		id="nivelLogroPECEX" 		name="nivelLogroPECEX" 		placeholder="Nivel Logro PECEX" required></td>
		</tr>
		<tr>
			<td>Fecha Proxima Auditoria PEC Competitiva</td><td> : </td>
			<td> <input type="text"		id="fechaProxAuditoriaPECEX" 		name="fechaProxAuditoriaPECEX" 		placeholder="Fecha Proxima Auditoria PEC Excelencia" required></td>
		</tr>
		<!-- Accidentabilidad -->
		<tr>
			<td>Tasa Accidentabilidad</td><td> : </td>
			<td> <input type="text"		id="tasaAccidentabilidad" 		name="tasaAccidentabilidad" 		placeholder="Tasa Accidentabilidad" required></td>
		</tr>
		<tr>
			<td>Siniestabilidad</td><td> : </td>
			<td> <input type="text"		id="siniestralidad" 		name="siniestralidad" 		placeholder="Siniestabilidad" required></td>
		</tr>
		<tr>
			<td>Cantidad Accidentes Fatales</td><td> : </td>
			<td> <input type="text"		id="fatalesAcc" 		name="fatalesAcc" 		placeholder="Cantidad Accidentes Fatales" required></td>
		</tr>
		<tr>
			<td>Invalidez</td><td> : </td>
			<td> <input type="text"		id="invalidez" 		name="invalidez" 		placeholder="Invalidez" required></td>
		</tr>
		<!-- Protocolo PREXOR -->
		<tr>
			<td>adherenciaPREX</td><td> : </td>
			<td> <input type="text"		id="adherenciaPREX" 		name="adherenciaPREX" 		placeholder="adherenciaPREX" required></td>
		</tr>
		<tr>
			<td>fechaAdherenciaPREX</td><td> : </td>
			<td> <input type="text"		id="fechaAdherenciaPREX" 		name="fechaAdherenciaPREX" 		placeholder="fechaAdherenciaPREX" required></td>
		</tr>
		<tr>
			<td>fechaVencimientoPREX</td><td> : </td>
			<td> <input type="text"		id="fechaVencimientoPREX" 		name="fechaVencimientoPREX" 		placeholder="fechaVencimientoPREX" required></td>
		</tr>
		<tr>
			<td>indemnizacionesPREX</td><td> : </td>
			<td> <input type="text"		id="indemnizacionesPREX" 		name="indemnizacionesPREX" 		placeholder="indemnizacionesPREX" required></td>
		</tr>
		<tr>
			<td>numCasosIndemnizacionesPREX</td><td> : </td>
			<td> <input type="text"		id="numCasosIndemnizacionesPREX" 		name="numCasosIndemnizacionesPREX" 		placeholder="numCasosIndemnizacionesPREX" required></td>
		</tr>
		<tr>
			<td>pensionesPREX</td><td> : </td>
			<td> <input type="text"		id="pensionesPREX" 		name="pensionesPREX" 		placeholder="pensionesPREX" required></td>
		</tr>
		<tr>
			<td>numCasosPensionesPREX</td><td> : </td>
			<td> <input type="text"		id="numCasosPensionesPREX" 		name="numCasosPensionesPREX" 		placeholder="numCasosPensionesPREX" required></td>
		</tr>
		<tr>
			<td>actasDifusionPREX</td><td> : </td>
			<td> <input type="text"		id="actasDifusionPREX" 		name="actasDifusionPREX" 		placeholder="actasDifusionPREX" required></td>
		</tr>
		<tr>
			<td>nivelExposicionPREX</td><td> : </td>
			<td> <input type="text"		id="nivelExposicionPREX" 		name="nivelExposicionPREX" 		placeholder="nivelExposicionPREX" required></td>
		</tr>
		<!-- PLANESI -->
		<tr>
			<td>adherenciaPLAN</td><td> : </td>
			<td> <input type="text"		id="adherenciaPLAN" 		name="adherenciaPLAN" 		placeholder="adherenciaPLAN" required></td>
		</tr>
		<tr>
			<td>fechaAdherenciaPLAN</td><td> : </td>
			<td> <input type="text"		id="fechaAdherenciaPLAN" 		name="fechaAdherenciaPLAN" 		placeholder="fechaAdherenciaPLAN" required></td>
		</tr>
		<tr>
			<td>fechaVencimientoPLAN</td><td> : </td>
			<td> <input type="text"		id="fechaVencimientoPLAN" 		name="fechaVencimientoPLAN" 		placeholder="fechaVencimientoPLAN" required></td>
		</tr>
		<tr>
			<td>indemnizacionesPLAN</td><td> : </td>
			<td> <input type="text"		id="indemnizacionesPLAN" 		name="indemnizacionesPLAN" 		placeholder="indemnizacionesPLAN" required></td>
		</tr>
		<tr>
			<td>numCasosIndemnizacionesPLAN</td><td> : </td>
			<td> <input type="text"		id="numCasosIndemnizacionesPLAN" 		name="numCasosIndemnizacionesPLAN" 		placeholder="numCasosIndemnizacionesPLAN" required></td>
		</tr>
		<tr>
			<td>pensionesPLAN</td><td> : </td>
			<td> <input type="text"		id="pensionesPLAN" 		name="pensionesPLAN" 		placeholder="pensionesPLAN" required></td>
		</tr>
		<tr>
			<td>numCasosPensionesPLAN</td><td> : </td>
			<td> <input type="text"		id="numCasosPensionesPLAN" 		name="numCasosPensionesPLAN" 		placeholder="numCasosPensionesPLAN" required></td>
		</tr>
		<tr>
			<td>actasDifusionPLAN</td><td> : </td>
			<td> <input type="text"		id="actasDifusionPLAN" 		name="actasDifusionPLAN" 		placeholder="actasDifusionPLAN" required></td>
		</tr>
		<tr>
			<td>nivelExposicionPLAN</td><td> : </td>
			<td> <input type="text"		id="nivelExposicionPLAN" 		name="nivelExposicionPLAN" 		placeholder="nivelExposicionPLAN" required></td>
		</tr>
		<!-- Psicosocial -->
		<tr>
			<td>adherenciaPSICO</td><td> : </td>
			<td> <input type="text"		id="adherenciaPSICO" 		name="adherenciaPSICO" 		placeholder="adherenciaPSICO" required></td>
		</tr>
		<!-- TMERS -->
		<tr>
			<td>difusionProtocolo</td><td> : </td>
			<td> <input type="text"		id="difusionProtocolo" 		name="difusionProtocolo" 		placeholder="difusionProtocolo" required></td>
		</tr>
	</table>
</form>
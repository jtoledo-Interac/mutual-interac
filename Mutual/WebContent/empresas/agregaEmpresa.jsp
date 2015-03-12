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
			<td> <input required type="text" 		id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" ></td>
		</tr>
		<tr>
			<td>Código Cartera</td><td> : </td>
			<td><input required type="text"  		id="codCartera" 	name="codCartera"	placeholder="Código Cartera" ></td>
		</tr>
		<tr>
			<td>Nombre Experto</td><td> : </td>
			<td><input required type="text"  		id="nomExperto" 	name="nomExperto"	placeholder="Nombre Experto" ></td>
		</tr>
		<tr>
			<td>Número Adherente</td><td> : </td>
			<td><input required type="text"  		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" ></td>
		</tr>
		<tr>
			<td>Razón Social</td><td> : </td>
			<td><input required type="text"  		id="razonSocial" 	name="razonSocial"	placeholder="Razón Social" ></td>
		</tr>
		<tr>
			<td>Dirección</td><td> : </td>
			<td><input required type="text"  		id="direccion" 	name="direccion"	placeholder="Dirección" ></td>
		</tr>
		<tr>
			<td>Representante</td><td> : </td>
			<td><input required type="text"  		id="representante" 	name="representante"	placeholder="Representante"  ></td>
		</tr>
		<tr>
			<td>Contacto Representante</td><td> : </td>
			<td><input required type="text"  		id="contactoRepresentante" 	name="contactoRepresentante"	placeholder="Contacto Rerpresentante"  ></td>
		</tr>
		<tr>
			<td>Nombre Prevencionista</td><td> : </td>
			<td><input required type="text"  		id="nombrePrevencionista" 	name="nombrePrevencionista"	placeholder="Nombre Prevencionista" ></td>
		</tr>
		<tr>
			<td>Contacto Prevencionista</td><td> : </td>
			<td><input required type="text"  		id="contactoPrevencionista" 	name="contactoPrevencionista"	placeholder="Contacto Prevencionista" ></td>
		</tr>
		<tr>
			<td>Masa Sum</td><td> : </td>
			<td><input required type="text"  		id="masaSum" 	name="masaSum"	placeholder="Masa Sum" ></td>
		</tr>
		<tr>
			<td>Segmentación</td><td> : </td>
			<td><input required type="text"  		id="segmentacion" 	name="segmentacion"	placeholder="Segmentación" ></td>
		</tr>
		<tr>
			<td>Multi Regional</td><td> : </td>
			<td><input required type="text"  		id="multiregional" 	name="multiregional"	placeholder="Multi Regional" ></td>
		</tr>
		<tr>
			<td>Número de Centros</td><td> : </td>
			<td><input required type="text"  		id="numCentros" 	name="numCentros"	placeholder="Número de Centros" ></td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td><input required type="text"  		id="holding" 	name="holding"	placeholder="Holding" ></td>
		</tr>
		<tr>
			<td>Número CHPS</td><td> : </td>
			<td><input required type="text"  		id="numCHPS" 	name="numCHPS"	placeholder="Númer CHPS" ></td>
		</tr>
		<tr>
			<td>Nombre Presidente</td><td> : </td>
			<td><input required type="text"  		id="nomPresidente" 	name="nomPresidente"	placeholder="Nombre Presidente" ></td>
		</tr>
		<tr>
			<td>Nombre Secretario</td><td> : </td>
			<td><input required type="text"  		id="nomSecretario" 	name="nomSecretario"	placeholder="Nombre Secretario" ></td>
		</tr>
		<tr>
			<td>Saami</td><td> : </td>
			<td><input required type="text"  		id="saami" 	name="saami"	placeholder="Saami" ></td>
		</tr>
		<tr>
			<td>Amputaciones</td><td> : </td>
			<td><input required type="text"  		id="amputaciones" 	name="amputaciones"	placeholder="Amputaciones" ></td>
		</tr>
		<tr>
			<td>Fatales</td><td> : </td>
			<td><input required type="text"  		id="fatales" 	name="fatales"	placeholder="Fatales" ></td>
		</tr>
		<tr>
			<td>Proyectos Desarrollados</td><td> : </td>
			<td><input required type="text"  		id="proyectosDesarrollados" 	name="proyectoDesarrollados"	placeholder="Proyecto Desarrollados" ></td>
		</tr>
		<!-- Certificaciones CHPS -->
		<tr>
			<td>Número Certificacion CHPS</td><td> : </td>
			<td> <input required type="text" 		id="numCPHSCertificados" 		name="numCPHSCertificados" 		placeholder="N° Certificación CHPS" ></td>
		</tr>
		<tr>
			<td>Tipo Certificación CHPS</td><td> : </td>
			<td><input required type="text"  		id="tipoCertificacion" 	name="tipoCertificacion"	placeholder="Tipo Certificación" ></td>
		</tr>
		<tr>
			<td>Fecha Certificación CHPS</td><td> : </td>
			<td><input required type="text"  		id="fechaCertificacion" 	name="fechaCertificacion"	placeholder="Fecha Certificación" ></td>
		</tr>
		<tr>
			<td>Fecha Caducidad Certificado</td><td> : </td>
			<td><input required type="text"  		id="fechaCaducidad" 	name="fechaCaducidad"	placeholder="Fecha Caducidad" ></td>
		</tr>
		<!-- PEC Estandar -->
		<tr>
			<td>Fecha Certificación PEC Estandar</td><td> : </td>
			<td> <input required type="text" 		id="fechaCertificacionPECE" 		name="fechaCertificacionPECE" 		placeholder="Fecha Certificacion PEC Estandar" ></td>
		</tr>
		<tr>
			<td>Fecha Caducidad PEC Estandar</td><td> : </td>
			<td> <input required type="text" 		id="fechaCaducidadPECE" 		name="fechaCaducidadPECE" 		placeholder="Fecha Caducidad PEC Estandar" ></td>
		</tr>
		<tr>
			<td>Nivel Logro PEC Estandar</td><td> : </td>
			<td> <input required type="text" 		id="nivelLogroPECE" 		name="nivelLogroPECE" 		placeholder="Nivel Logro PEC Estandar" ></td>
		</tr>
		<tr>
			<td>Fecha Proxima Auditoria PEC Estandar</td><td> : </td>
			<td> <input required type="text" 		id="fechaProxAuditoriaPECE" 		name="fechaProxAuditoriaPECE" 		placeholder="Fecha Proxima Auditoria PEC Estandar" ></td>
		</tr>
		<!-- PEC Competitiva -->
		<tr>
			<td>Fecha Certificación PEC Competitiva</td><td> : </td>
			<td> <input required type="text" 		id="fechaCertificacionPECC" 		name="fechaCertificacionPECC" 		placeholder="Fecha Certificacion PEC Competitivo" ></td>
		</tr>
		<tr>
			<td>Fecha Caducidad PEC Competitiva</td><td> : </td>
			<td> <input required type="text" 		id="fechaCaducidadPECC" 		name="fechaCaducidadPECE" 		placeholder="Fecha Caducidad PEC Competitivo" ></td>
		</tr>
		<tr>
			<td>Nivel Logro PEC Competitiva</td><td> : </td>
			<td> <input required type="text" 		id="nivelLogroPECC" 		name="nivelLogroPECC" 		placeholder="Nivel Logro PEC Competitivo" ></td>
		</tr>
		<tr>
			<td>Fecha Proxima Auditoria PEC Competitiva</td><td> : </td>
			<td> <input required type="text" 		id="fechaProxAuditoriaPECC" 		name="fechaProxAuditoriaPECC" 		placeholder="Fecha Proxima Auditoria PEC Competitivo" ></td>
		</tr>
		<!-- PEC Excelencia -->
		<tr>
			<td>Fecha Certificación PEC Excelencia</td><td> : </td>
			<td> <input required type="text" 		id="fechaCertificacionPECEX" 		name="fechaCertificacionPECEX" 		placeholder="Fecha Certificacion PEC Excelencia" ></td>
		</tr>
		<tr>
			<td>Fecha Caducidad PEC Excelencia</td><td> : </td>
			<td> <input required type="text" 		id="fechaCaducidadPECEX" 		name="fechaCaducidadPECEX" 		placeholder="Fecha Caducidad PEC Excelencia" ></td>
		</tr>
		<tr>
			<td>Nivel Logro PEC Excelencia</td><td> : </td>
			<td> <input required type="text" 		id="nivelLogroPECEX" 		name="nivelLogroPECEX" 		placeholder="Nivel Logro PECEX" ></td>
		</tr>
		<tr>
			<td>Fecha Proxima Auditoria PEC Competitiva</td><td> : </td>
			<td> <input required type="text" 		id="fechaProxAuditoriaPECEX" 		name="fechaProxAuditoriaPECEX" 		placeholder="Fecha Proxima Auditoria PEC Excelencia" ></td>
		</tr>
		<!-- Accidentabilidad -->
		<tr>
			<td>Tasa Accidentabilidad</td><td> : </td>
			<td> <input required type="text" 		id="tasaAccidentabilidad" 		name="tasaAccidentabilidad" 		placeholder="Tasa Accidentabilidad" ></td>
		</tr>
		<tr>
			<td>Siniestabilidad</td><td> : </td>
			<td> <input required type="text" 		id="siniestralidad" 		name="siniestralidad" 		placeholder="Siniestabilidad" ></td>
		</tr>
		<tr>
			<td>Cantidad Accidentes Fatales</td><td> : </td>
			<td> <input required type="text" 		id="fatalesAcc" 		name="fatalesAcc" 		placeholder="Cantidad Accidentes Fatales" ></td>
		</tr>
		<tr>
			<td>Invalidez</td><td> : </td>
			<td> <input required type="text" 		id="invalidez" 		name="invalidez" 		placeholder="Invalidez" ></td>
		</tr>
		<!-- Protocolo PREXOR -->
		<tr>
			<td>adherenciaPREX</td><td> : </td>
			<td> <input required type="text" 		id="adherenciaPREX" 		name="adherenciaPREX" 		placeholder="adherenciaPREX" ></td>
		</tr>
		<tr>
			<td>fechaAdherenciaPREX</td><td> : </td>
			<td> <input required type="text" 		id="fechaAdherenciaPREX" 		name="fechaAdherenciaPREX" 		placeholder="fechaAdherenciaPREX" ></td>
		</tr>
		<tr>
			<td>fechaVencimientoPREX</td><td> : </td>
			<td> <input required type="text" 		id="fechaVencimientoPREX" 		name="fechaVencimientoPREX" 		placeholder="fechaVencimientoPREX" ></td>
		</tr>
		<tr>
			<td>indemnizacionesPREX</td><td> : </td>
			<td> <input required type="text" 		id="indemnizacionesPREX" 		name="indemnizacionesPREX" 		placeholder="indemnizacionesPREX" ></td>
		</tr>
		<tr>
			<td>numCasosIndemnizacionesPREX</td><td> : </td>
			<td> <input required type="text" 		id="numCasosIndemnizacionesPREX" 		name="numCasosIndemnizacionesPREX" 		placeholder="numCasosIndemnizacionesPREX" ></td>
		</tr>
		<tr>
			<td>pensionesPREX</td><td> : </td>
			<td> <input required type="text" 		id="pensionesPREX" 		name="pensionesPREX" 		placeholder="pensionesPREX" ></td>
		</tr>
		<tr>
			<td>numCasosPensionesPREX</td><td> : </td>
			<td> <input required type="text" 		id="numCasosPensionesPREX" 		name="numCasosPensionesPREX" 		placeholder="numCasosPensionesPREX" ></td>
		</tr>
		<tr>
			<td>actasDifusionPREX</td><td> : </td>
			<td> <input required type="text" 		id="actasDifusionPREX" 		name="actasDifusionPREX" 		placeholder="actasDifusionPREX" ></td>
		</tr>
		<tr>
			<td>nivelExposicionPREX</td><td> : </td>
			<td> <input required type="text" 		id="nivelExposicionPREX" 		name="nivelExposicionPREX" 		placeholder="nivelExposicionPREX" ></td>
		</tr>
		<!-- PLANESI -->
		<tr>
			<td>adherenciaPLAN</td><td> : </td>
			<td> <input required type="text" 		id="adherenciaPLAN" 		name="adherenciaPLAN" 		placeholder="adherenciaPLAN" ></td>
		</tr>
		<tr>
			<td>fechaAdherenciaPLAN</td><td> : </td>
			<td> <input required type="text" 		id="fechaAdherenciaPLAN" 		name="fechaAdherenciaPLAN" 		placeholder="fechaAdherenciaPLAN" ></td>
		</tr>
		<tr>
			<td>fechaVencimientoPLAN</td><td> : </td>
			<td> <input required type="text" 		id="fechaVencimientoPLAN" 		name="fechaVencimientoPLAN" 		placeholder="fechaVencimientoPLAN" ></td>
		</tr>
		<tr>
			<td>indemnizacionesPLAN</td><td> : </td>
			<td> <input required type="text" 		id="indemnizacionesPLAN" 		name="indemnizacionesPLAN" 		placeholder="indemnizacionesPLAN" ></td>
		</tr>
		<tr>
			<td>numCasosIndemnizacionesPLAN</td><td> : </td>
			<td> <input required type="text" 		id="numCasosIndemnizacionesPLAN" 		name="numCasosIndemnizacionesPLAN" 		placeholder="numCasosIndemnizacionesPLAN" ></td>
		</tr>
		<tr>
			<td>pensionesPLAN</td><td> : </td>
			<td> <input required type="text" 		id="pensionesPLAN" 		name="pensionesPLAN" 		placeholder="pensionesPLAN" ></td>
		</tr>
		<tr>
			<td>numCasosPensionesPLAN</td><td> : </td>
			<td> <input required type="text" 		id="numCasosPensionesPLAN" 		name="numCasosPensionesPLAN" 		placeholder="numCasosPensionesPLAN" ></td>
		</tr>
		<tr>
			<td>actasDifusionPLAN</td><td> : </td>
			<td> <input required type="text" 		id="actasDifusionPLAN" 		name="actasDifusionPLAN" 		placeholder="actasDifusionPLAN" ></td>
		</tr>
		<tr>
			<td>nivelExposicionPLAN</td><td> : </td>
			<td> <input required type="text" 		id="nivelExposicionPLAN" 		name="nivelExposicionPLAN" 		placeholder="nivelExposicionPLAN" ></td>
		</tr>
		<!-- Psicosocial -->
		<tr>
			<td>adherenciaPSICO</td><td> : </td>
			<td> <input required type="text" 		id="adherenciaPSICO" 		name="adherenciaPSICO" 		placeholder="adherenciaPSICO" ></td>
		</tr>
		<!-- TMERS -->
		<tr>
			<td>difusionProtocolo</td><td> : </td>
			<td> <input required type="text" 		id="difusionProtocolo" 		name="difusionProtocolo" 		placeholder="difusionProtocolo" ></td>
		</tr>
	</table>
</form>
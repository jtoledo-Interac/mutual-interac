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
			<td> <input required type="text" 	value="${empresa.nombre}"	id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" ></td>
		</tr>
		<tr>
			<td>C�digo Cartera</td><td> : </td>
			<td><input required type="text"  value="${empresa.codCartera}"		id="codCartera" 	name="codCartera"	placeholder="C�digo Cartera" ></td>
		</tr>
		<tr>
			<td>Nombre Experto</td><td> : </td>
			<td><input required type="text"  	value="${empresa.nomExperto}"	id="nomExperto" 	name="nomExperto"	placeholder="Nombre Experto" ></td>
		</tr>
		<tr>
			<td>N�mero Adherente</td><td> : </td>
			<td><input required type="text"  value="${empresa.numAdherente}"		id="numAdherente" 	name="numAdherente"	placeholder="N� Adherente" ></td>
		</tr>
		<tr>
			<td>Raz�n Social</td><td> : </td>
			<td><input required type="text"   value="${empresa.razonSocial}" id="razonSocial"	name="razonSocial"	placeholder="Raz�n Social" ></td>
		</tr>
		<tr>
			<td>A�o de adhesi�n</td><td> : </td>
			<td><input required type="text" class="fecha"  		id="anoDeAdhesion" 	name="anoDeAdhesion" value="${empresa.anoDeAdhesion}"	placeholder="A�o de Adhesi�n" ></td>
		</tr>
		<tr>
			<td>Segmentaci�n</td><td> : </td>
			<td><input required type="text"  value="${empresa.segmentacion}" 		id="segmentacion" 	name="segmentacion"	placeholder="Segmentaci�n"  ></td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td><input required type="text"  value="${empresa.holding}"		id="holding" 	name="holding"	placeholder="Holding"  ></td>
		</tr>
		<tr>
			<td>Situaci�n</td><td> : </td>
			<td><input required type="text" value="${empresa.situacion}" 		id="situacion" 	name="situacion"	placeholder="Situaci�n"  ></td>
		</tr>
		<tr>
			<td>Multi Region</td><td> : </td>
			<td><input required type="text"  value="${empresa.multiRegion}"		id="multiRegion" 	name="multiRegion"	placeholder="Multi Region" ></td>
		</tr>
		<tr>
			<td>Casa Matriz</td><td> : </td>
			<td><input required type="text"  value="${empresa.casaMatriz}"		id="casaMatriz" 	name="casaMatriz"	placeholder="Casa Matriz" ></td>
		</tr>
		<tr>
			<td>Region Casa Matriz</td><td> : </td>
			<td><input required type="text"  value="${empresa.regionCasaMatriz}"		id="regionCasaMatriz" 	name="regionCasaMatriz"	placeholder="Region Casa Matriz" ></td>
		</tr>
		<tr>
			<td>Masa Sum</td><td> : </td>
			<td><input required type="text" value="${empresa.masaSum}" 		id="masaSum" 	name="masaSum"	placeholder="Masa Sum" ></td>
		</tr>
		<tr>
			<td>Planes de Cuenta</td><td> : </td>
			<td><input required type="text" value="${empresa.planesDeCuenta}" 		id="planesDeCuenta" 	name="planesDeCuenta"	placeholder="Planes De Cuenta" ></td>
		</tr>
		<tr>
			<td>Planes de Trabajo</td><td> : </td>
			<td><input required type="text" value="${empresa.planesDeTrabajo}" 		id="planesDeTrabajo" 	name="planesDeTrabajo"	placeholder="Planes de Trabajo" ></td>
		</tr>
		<tr>
			<td>Firma de Planes</td><td> : </td>
			<td><input required type="text"  value="${empresa.firmaDePlanes}"		id="firmaDePlanes" 	name="firmaDePlanes"	placeholder="Firma De Planes" ></td>
		</tr>
		<tr>
			<td>Sistema de Gesti�n</td><td> : </td>
			<td><input required type="text"  	value="${empresa.sistemaDeGestion}"	id="sistemaDeGestion" 	name="sistemaDeGestion"	placeholder="Sistema de Gesti�n" ></td>
		</tr>
		<tr>
			<td>Constituci�n Cphs</td><td> : </td>
			<td><input required type="text"  	value="${empresa.constitucionCphs}"	id="constitucionCphs" 	name="constitucionCphs"	placeholder="Planes de CConstituci�n Cphs" ></td>
		</tr>
		<tr>
			<td>Certificaci�n Cphs</td><td> : </td>
			<td><input required type="text"  	value="${empresa.certificacionCphs}"	id="certificacionCphs" 	name="certificacionCphs"	placeholder="Certificaci�n Cphs" ></td>
		</tr>
		<tr>
			<td>MMC</td><td> : </td>
			<td><input required type="text"  	value="${empresa.mmc}"	id="mmc" 	name="mmc"	placeholder="MMC" ></td>
		</tr>
		<tr>
			<td>TMERT</td><td> : </td>
			<td><input required type="text"  	value="${empresa.tmert}"	id="tmert" 	name="tmert"	placeholder="TMERT" ></td>
		</tr>
		<tr>
			<td>Planesi</td><td> : </td>
			<td><input required type="text"  	value="${empresa.planesi}"	id="planesi" 	name="planesi"	placeholder="Planesi" ></td>
		</tr>
		<tr>
			<td>Plaguicida</td><td> : </td>
			<td><input required type="text"  	value="${empresa.plaguicida}"	id="plaguicida" 	name="plaguicida"	placeholder="Plaguicida" ></td>
		</tr>
		<tr>
			<td>Radiaci�n UV</td><td> : </td>
			<td> <input required type="text" 	value="${empresa.radiacionUv}"	id="radiacionUv" 		name="radiacionUv" 		placeholder="Radiaci�n UV" ></td>
		</tr>
		<tr>
			<td>Hipobaria</td><td> : </td>
			<td><input required type="text"  	value="${empresa.hipobaria}"	id="hipobaria" 	name="hipobaria"	placeholder="Hipobaria" ></td>
		</tr>
		<tr>
			<td>PREXOR</td><td> : </td>
			<td><input required type="text"  	value="${empresa.prexor}"	id="prexor" 	name="prexor"	placeholder="PREXOR" ></td>
		</tr>
		<tr>
			<td>Psicosociales</td><td> : </td>
			<td><input required type="text"  	value="${empresa.psicosociales}"	id="psicosociales" 	name="psicosociales"	placeholder="Psicosociales" ></td>
		</tr>
		<tr>
			<td>Proyecto Investigaci�n</td><td> : </td>
			<td> <input required type="text" 	value="${empresa.proyectoInvestigacion}"	id="proyectoInvestigacion" 		name="proyectoInvestigacion" 		placeholder="Proyecto Investigaci�n" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Experto</td><td> : </td>
			<td> <input required type="text" class="fecha" value="${empresa.ultimaVisitaExperto}"		id="ultimaVisitaExperto" 		name="ultimaVisitaExperto" 		placeholder="Ultima Visita Experto" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Director</td><td> : </td>
			<td> <input required type="text" class="fecha" 	value="${empresa.ultimaVisitaDirector}"	id="ultimaVisitaDirector" 		name="ultimaVisitaDirector" 		placeholder="Ultima Visita Director" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Gerente</td><td> : </td>
			<td> <input required type="text" class="fecha" value="${empresa.ultimaVisitaGtte}"		id="ultimaVisitaGtte" 		name="ultimaVisitaGtte" 		placeholder="Ultima Visita Gerente" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Alta Gerencia</td><td> : </td>
			<td> <input required type="text" class="fecha" 	value="${empresa.ultimaVisitaAltaGerencia}"	id="ultimaVisitaAltaGerencia" 		name="ultimaVisitaAltaGerencia" 		placeholder="Ultima Visita Alta Gerencia" ></td>
		</tr>
		<tr>
			<td>Reporte Visita</td><td> : </td>
			<td> <input required type="text" 	value="${empresa.reporteVisita}"	id="reporteVisita" 		name="reporteVisita" 		placeholder="Reporte Visita" ></td>
		</tr>
		<tr>
			<td>Riesgo de Fuga</td><td> : </td>
			<td> <input required type="text" 	value="${empresa.riesgoDeFuga}"	id="riesgoDeFuga" 		name="riesgoDeFuga" 		placeholder="Riesgo de Fuga" ></td>
		</tr>
		<tr>
			<td>Reclamo Ultimo Periodo</td><td> : </td>
			<td> <input required type="text" class="fecha" 	value="${empresa.reclamoUltimoPeriodo}"	id="reclamoUltimoPeriodo" 		name="reclamoUltimoPeriodo" 		placeholder="Reclamo Ultimo Periodo" ></td>
		</tr>
		<tr>
			<td>Participa Mesa Trabajo</td><td> : </td>
			<td> <input required type="text" 	value="${empresa.participaMesaTrabajo}"	id="participaMesaTrabajo" 		name="participaMesaTrabajo" 		placeholder="Participa Mesa Trabajo" ></td>
		</tr>
	</table>
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idEmpresa" name="idEmpresa" value="${empresa.idEmpresa}">
</form>
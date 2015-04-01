<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript"> 	
	$(function() {
		setDatePicker();
		formatRut();
		$("#tabs").tabs();
	});
</script>
	
<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarEmpresa">
	<div id="tabs">
		<ul>
			<li><a href="#tabs-general">General</a></li>
			<li><a href="#tabs-salud_ocupacional">Salud Ocupacional</a></li>
			<li><a href="#tabs-accidentabilidad">Accidentabilidad</a></li>
			<li><a href="#tabs-dias_perdidos">D�as Perdidos</a></li>
		</ul>
		<div id="tabs-general">
	<table>
		<tr>
			<td>Nombre</td><td> : </td>
			<td> <input required value="${empresa.nombre}" type="text" 		id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" ></td>
		</tr>
		<tr>
			<td>Nombre Experto</td><td> : </td>
			<td><input required type="text"  value="${empresa.nomExperto}"		id="nomExperto" 	name="nomExperto"	placeholder="Nombre Experto" ></td>
		</tr>
		<tr>
			<td>C�digo Cartera</td><td> : </td>
			<td>
				<select id="codCartera" name="codCartera" required>
					<option value="" selected>Seleccione una cartera</option>
						<c:forEach items="${requestScope.listaCarteras}" var="cartera">
							<option value="${cartera.idCartera}" <c:if test='${empresa.codCartera == cartera.idCartera}'> selected</c:if>>${cartera.desCartera}</option>
						</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>N�mero Adherente</td><td> : </td>
			<td><input required type="text"  value="${empresa.numAdherente}"		id="numAdherente" 	name="numAdherente"	placeholder="N� Adherente" ></td>
		</tr>
		<tr>
			<td>Raz�n Social</td><td> : </td>
			<td><input required type="text" value="${empresa.razonSocial}" 		id="razonSocial" 	name="razonSocial"	placeholder="Raz�n Social" ></td>
		</tr>
		<tr>
			<td>A�o de adhesi�n</td><td> : </td>
			<td><input required type="text" class="fecha" value="${empresa.anoDeAdhesion}"		id="anoDeAdhesion" 	name="anoDeAdhesion"	placeholder="A�o de Adhesi�n" ></td>
		</tr>
		<tr>
			<td>Segmentaci�n</td><td> : </td>
			<td>
			<select id="segmentacion" 	name="segmentacion" required>
					<option value="Grandes cuentas"<c:if test='${empresa.segmentacion == "Grandes cuentas"}'> selected</c:if>>Grandes cuentas</option>
					<option value="Estrategicas"<c:if test='${empresa.segmentacion == "Estrategicas"}'> selected</c:if>>Estrategicas</option>
					<option value="Corporativas"<c:if test='${empresa.segmentacion == "Corporativas"}'> selected</c:if>>Corporativas</option>
					
				</select>
			</td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td>
				<select id="holding" 	name="holding" required>
					<option value="Si"<c:if test='${empresa.holding == "Si"}'> selected</c:if>>Si</option>
					<option value="No"<c:if test='${empresa.holding == "No"}'> selected</c:if>>No</option>
				</select>
			</td>	
		</tr>
		<tr>
			<td>Estrategicas</td><td> : </td>
			<td>
			<select id="estrategica" 	name="estrategia" required>
					<option value="Si"<c:if test='${empresa.estrategica == "Si"}'> selected</c:if>>Si</option>
					<option value="No"<c:if test='${empresa.estrategica == "No"}'> selected</c:if>>No</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Casa Matriz </td><td>:</td>
			<td>
				<select id="casaMatriz" 	name="casaMatriz"  required>
					<option value="">Seleccione una regi�n</option>
					<c:forEach items="${requestScope.listaRegiones}" var="region">
						<option value="${region.codRegion}"<c:if test='${empresa.casaMatriz == region.codRegion}'> selected</c:if>>${region.desRegion}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>Multi Region</td><td> : </td>
			<td>
			<select id="multiregion" 	name="multiregion" required>
				<option value="Si"<c:if test='${empresa.multiregion == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.multiregion == "No"}'> selected</c:if>>No</option>
				<option value="NoAplica"<c:if test='${empresa.multiregion == "NoAplica"}'> selected</c:if>>No Aplica</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Numero Centros de Trabajo</td><td> : </td>
			<td><input required type="text" value="${empresa.numCentrosTrabajo}" 		id="numCentrosTrabajo" 	name="numCentrosTrabajo"	placeholder="Numeros Centros de Trabajo" ></td>
		</tr>
		<tr>
			<td>Masa Sum Metropolitana</td><td> : </td>
			<td><input required type="text"  value="${empresa.masaSumMetropolitana}" 		id="masaSumMetropolitana" 	name="masaSumMetropolitana"	placeholder="Masa Sum Metropolitana" ></td>
		</tr>
		<tr>
			<td>Masa Sum Nacional</td><td> : </td>
			<td><input required type="text"  value="${empresa.masaSumNacional}"		id="masaSumNacional" 	name="masaSumNacional"	placeholder="Masa Sum Nacional" ></td>
		</tr>
		<tr>
			<td>Planes de Cuenta</td><td> : </td>
			<td>
			<select id="planesDeCuenta" 	name="planesDeCuenta" required>
				<option value="Si"<c:if test='${empresa.planesDeCuenta == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.planesDeCuenta == "No"}'> selected</c:if>>No</option>
				<option value="NoAplica"<c:if test='${empresa.planesDeCuenta == "NoAplica"}'> selected</c:if>>No Aplica</option>
			</select>
			</td>
			</tr>
		<tr>
			<td>Planes de Trabajo</td><td> : </td>
			<td>
			<select id="planesDeTrabajo" 	name="planesDeTrabajo" required>
					<option value="Si"<c:if test='${empresa.planesDeTrabajo == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.planesDeTrabajo == "No"}'> selected</c:if>>No</option>
				<option value="NoAplica"<c:if test='${empresa.planesDeTrabajo == "NoAplica"}'> selected</c:if>>No Aplica</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Firma de planes</td><td> : </td>
			<td>
			<select id="firmaDePlanes" 	name="firmaDePlanes" required>
				<option value="Si"<c:if test='${empresa.firmaDePlanes == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.firmaDePlanes == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Sistema de Gesti�n</td><td> : </td>
			<td>
			<select id="sistemaDeGestion" 	name="sistemaDeGestion" required>
				<option value="PEC Estandar"<c:if test='${empresa.sistemaDeGestion == "PEC Estandar"}'> selected</c:if>>PEC Estandar</option>
				<option value="PEC Competitividad"<c:if test='${empresa.sistemaDeGestion == "PEC Competitividad"}'> selected</c:if>>PEC Competitividad</option>
				<option value="Excelencia"<c:if test='${empresa.sistemaDeGestion == "Excelencia"}'> selected</c:if>>Excelencia</option>
				<option value="Autogestion"<c:if test='${empresa.sistemaDeGestion == "Autogestion"}'> selected</c:if>>Autogestion</option>
				<option value="No Tiene"<c:if test='${empresa.sistemaDeGestion == "No Tiene"}'> selected</c:if>>No Tiene</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Firma del protocolo</td><td> : </td>
			<td><input required type="text" class="fecha" 	value="${empresa.firmaProtocolo}"	id="fechaFirmaProtocolo" 	name="fechaFirmaProtocolo"	placeholder="Firma del Protocolo" ></td>
		</tr>
		<tr>
			<td>Etapa Sistema de Gesti�n</td><td> : </td>
			<td>
			<select id="etapaSistemaGestion" 	name="etapaSistemaGestion" required>
				<option value="Implementaci�n"<c:if test='${empresa.etapaSistemaGestion == "Implementaci�n"}'> selected</c:if>>Implementaci�n</option>
				<option value="Auditor�a"<c:if test='${empresa.etapaSistemaGestion == "Auditor�a"}'> selected</c:if>>Auditor�a</option>
				<option value="Certificaci�n"<c:if test='${empresa.etapaSistemaGestion == "Certificaci�n"}'> selected</c:if>>Certificaci�n</option>
				<option value="No Aplica"<c:if test='${empresa.etapaSistemaGestion == "No Aplica"}'> selected</c:if>>No Aplica</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>N�mero CPHS</td><td> : </td>
			<td><input required type="text"  value="${empresa.numCphs}"		id="numCPHS" 	name="numCPHS"	placeholder="N�mero CPHS" ></td>
		</tr>
		<tr>
			<td>N�mero CPHS Certificados</td><td> : </td>
			<td><input required type="text"  	value="${empresa.numCphsCertificado}"	id="numCPHSCertificados" 	name="numCPHSCertificados"	placeholder="N�mero CPHS Certificados"></td>
		</tr>
		<tr>
			<td>N�mero CPHS Bronce</td><td> : </td>
			<td><input required type="text"  	value="${empresa.numCphsBronce}"	id="numCPHSBronce" 	name="numCPHSBronce"	placeholder="N�mero CPHS Bronce" ></td>
		</tr>
		<tr>
			<td>N�mero CPHS Plata</td><td> : </td>
			<td><input required type="text"  value="${empresa.numCphsPlata}"		id="numCPHSPlata" 	name="numCPHSPlata"	placeholder="N�mero CPHS Plata" ></td>
		</tr>
		<tr>
			<td>N�mero CPHS Oro</td><td> : </td>
			<td><input required type="text"  value="${empresa.numCphsOro}"		id="numCPHSOro" 	name="numCPHSOro"	placeholder="N�mero CPHS Oro" ></td>
		</tr>
		</table>
		</div>
		<div id="tabs-salud_ocupacional">
		<table>
		<tr>
			<td>PREXOR</td><td> : </td>
			<td>
			<select id="prexor" name="prexor" required>
				<option value="Si"<c:if test='${empresa.prexor == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.prexor == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>PREXOR Etapa</td><td> : </td>
			<td>
			<select id="prexorEtapa" name="prexorEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.prexorEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.prexorEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Difusi�n del Protocolo"<c:if test='${empresa.prexorEtapa == "Difusi�n del Protocolo"}'> selected</c:if>>Difusi�n del Protocolo</option>
				<option value="Asesor�a en la Construcci�n de la matriz de riesgo de ruido"<c:if test='${empresa.prexorEtapa == "Asesor�a en la Construcci�n de la matriz de riesgo de ruido"}'> selected</c:if>>Asesor�a en la Construcci�n de la matriz de riesgo de ruido</option>
				<option value="Evaluaci�n Cualitativa del GES"<c:if test='${empresa.prexorEtapa == "Evaluaci�n Cualitativa del GES"}'> selected</c:if>>Evaluaci�n Cualitativa del GES</option>
				<option value="Ingreso a programa vigente de conservaci�n auditiva"<c:if test='${empresa.prexorEtapa == "Ingreso a programa vigente de conservaci�n auditiva"}'> selected</c:if>>Ingreso a programa vigente de conservaci�n auditiva</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.prexorEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>PREXOR Observaciones</td><td> : </td>
			<td><input  type="text"  	value="${empresa.prexorTexto}"	id="prexorTexto" 	name="prexorTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>PLANESI</td><td> : </td>
			<td>
			<select id="planesi" 	name="planesi" required>
				<option value="Si"<c:if test='${empresa.planesi == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.planesi == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>PLANESI Etapa</td><td> : </td>
			<td>
			<select id="planesiEtapa" name="planesiEtapa" >
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.planesiEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.planesiEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Difusi�n del Protocolo"<c:if test='${empresa.planesiEtapa == "Difusi�n del Protocolo"}'> selected</c:if>>Difusi�n del Protocolo</option>
				<option value="Asesor�a en la Construcci�n de la matriz de riesgo S�lice"<c:if test='${empresa.planesiEtapa == "Asesor�a en la Construcci�n de la matriz de riesgo S�lice"}'> selected</c:if>>Asesor�a en la Construcci�n de la matriz de riesgo S�lice</option>
				<option value="Evaluaci�n Cualitativa del GES"<c:if test='${empresa.planesiEtapa == "Evaluaci�n Cualitativa del GES"}'> selected</c:if>>Evaluaci�n Cualitativa del GES</option>
				<option value="Ingreso a programa vigente Neumoconiogeno"<c:if test='${empresa.planesiEtapa == "Ingreso a programa vigente Neumoconiogeno"}'> selected</c:if>>Ingreso a programa vigente Neumoconiogeno</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.planesiEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>PLANESI Observaciones</td><td> : </td>
			<td><input  type="text"  value="${empresa.planesiTexto}"		id="planesiTexto" 	name="planesiTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Asbesto</td><td> : </td>
			<td>
			<select id="asbesto" 	name="asbesto" required>
				<option value="Si"<c:if test='${empresa.asbesto == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.asbesto == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Asbesto Etapa</td><td> : </td>
			<td>
			<select id="asbestoEtapa" 	name="asbestoEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.asbestoEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.asbestoEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Ingreso a programa vigente Neumoconiogeno"<c:if test='${empresa.asbestoEtapa == "Ingreso a programa vigente Neumoconiogeno"}'> selected</c:if>>Ingreso a programa vigente Neumoconiogeno</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.asbestoEtapa == "Seg04"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Asbesto Observaciones</td><td> : </td>
			<td><input  type="text"  value="${empresa.asbestoTexto}"		id="asbestoTexto" 	name="asbestoTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Hipobaria</td><td> : </td>
			<td>
			<select id="hipobaria" 	name="hipobaria" required>
				<option value="Si"<c:if test='${empresa.hipobaria == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.hipobaria == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Hipobaria Etapa</td><td> : </td>
			<td>
			<select id="hipobariaEtapa" 	name="hipobariaEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.hipobariaEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.hipobariaEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Estudio Diagnostico"<c:if test='${empresa.hipobariaEtapa == "Estudio Diagnostico"}'> selected</c:if>>Estudio Diagnostico</option>
				<option value="Ingreso a Programa de Vigilancia"<c:if test='${empresa.hipobariaEtapa == "Seg04"}'> selected</c:if>>Ingreso a Programa de Vigilancia</option>
				<option value="Ingreso a programa vigente Neumoconiogeno"<c:if test='${empresa.hipobariaEtapa == "Seg05"}'> selected</c:if>>Ingreso a programa vigente Neumoconiogeno</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Hipobaria Observaciones</td><td> : </td>
			<td><input  type="text"  value="${empresa.hipobariaTexto}"		id="hipobariaTexto" 	name="hipobariaTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Radiaci�n Ionizante</td><td> : </td>
			<td>
			<select id="radiaciones" 	name="radiaciones" required>
				<option value="Si"<c:if test='${empresa.radiaciones == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.radiaciones == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiaci�n Ionizante Etapa</td><td> : </td>
			<td>
			<select id="radiacionesEtapa" 	name="radiacionesEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.radiacionesEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.radiacionesEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluaci�n Cuantitativa"<c:if test='${empresa.radiacionesEtapa == "Evaluaci�n Cuantitativa"}'> selected</c:if>>Evaluaci�n Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de exposici�n a radiaciones"<c:if test='${empresa.radiacionesEtapa == "Seg04"}'> selected</c:if>>Ingreso a Programa de Vigilancia de exposici�n a radiaciones</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.radiacionesEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiaci�n Observaciones</td><td> : </td>
			<td><input  type="text"  value="${empresa.radiacionesTexto}"		id="radiacionesTexto" 	name="radiacionesTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Asma</td><td> : </td>
			<td>
			<select id="asma" 	name="asma" required>
				<option value="Si"<c:if test='${empresa.asma == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.asma == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Asma Etapa</td><td> : </td>
			<td>
			<select id="asmaEtapa" 	name="asmaEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.asmaEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.asmaEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluaci�n Cuantitativa"<c:if test='${empresa.asmaEtapa == "Evaluaci�n Cuantitativa"}'> selected</c:if>>Evaluaci�n Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Asma"<c:if test='${empresa.asmaEtapa == "Ingreso a Programa de Vigilancia de Asma"}'> selected</c:if>>Ingreso a Programa de Vigilancia de Asma</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.asmaEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Asma Observaciones</td><td> : </td>
			<td><input  type="text"  	value="${empresa.asmaTexto}"	id="asmaTexto" 	name="asmaTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Solventes</td><td> : </td>
			<td>
			<select id="solventes" 	name="solventes" required>
				<option value="Si"<c:if test='${empresa.solventes == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.solventes == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Solventes Etapa</td><td> : </td>
			<td>
			<select id="solventesEtapa" 	name="solventesEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.solventesEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.solventesEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluaci�n Cuantitativa"<c:if test='${empresa.solventesEtapa == "Evaluaci�n Cuantitativa"}'> selected</c:if>>Evaluaci�n Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Solventes"<c:if test='${empresa.solventesEtapa == "Ingreso a Programa de Vigilancia de Solventes"}'> selected</c:if>>Ingreso a Programa de Vigilancia de Solventes</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.solventesEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Solventes Observaciones</td><td> : </td>
			<td><input  type="text"  	value="${empresa.solventesTexto}"	id="solventesTexto" 	name="solventesTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Metales</td><td> : </td>
			<td>
			<select id="metales" 	name="metales" required>
				<option value="Si"<c:if test='${empresa.metales == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.metales == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Metales Etapa</td><td> : </td>
			<td>
			<select id="metalesEtapa" 	name="metalesEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.metalesEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.metalesEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluaci�n Cuantitativa"<c:if test='${empresa.metalesEtapa == "Evaluaci�n Cuantitativa"}'> selected</c:if>>Evaluaci�n Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Metales"<c:if test='${empresa.metalesEtapa == "Ingreso a Programa de Vigilancia de Metales"}'> selected</c:if>>Ingreso a Programa de Vigilancia de Metales</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.metalesEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Metales Observaciones</td><td> : </td>
			<td><input  type="text"  	value="${empresa.metalesTexto}"	id="metalesTexto" 	name="metalesTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>�xido de Etileno</td><td> : </td>
			<td>
			<select id="oxido" 	name="oxido" required>
				<option value="Si"<c:if test='${empresa.oxido == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.oxido == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>�xido de Etileno Etapa</td><td> : </td>
			<td>
			<select id="oxidoEtapa" 	name="oxidoEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.oxidoEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.oxidoEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluaci�n Cuantitativa"<c:if test='${empresa.oxidoEtapa == "Evaluaci�n Cuantitativa"}'> selected</c:if>>Evaluaci�n Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Oxido"<c:if test='${empresa.oxidoEtapa == "Ingreso a Programa de Vigilancia de Oxido"}'> selected</c:if>>Ingreso a Programa de Vigilancia de Oxido</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.oxidoEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>�xido de Etileno Observaciones</td><td> : </td>
			<td><input  type="text"  	value="${empresa.oxidoTexto}"	id="oxidoTexto" 	name="oxidoTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Plaguicida</td><td> : </td>
			<td>
			<select id="plaguicida" 	name="plaguicida" required>
				<option value="Si"<c:if test='${empresa.plaguicida == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.plaguicida == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Plaguicida Etapa</td><td> : </td>
			<td>
			<select id="plaguicidaEtapa" 	name="plaguicidaEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.plaguicidaEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.plaguicidaEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluaci�n Cuantitativa"<c:if test='${empresa.plaguicidaEtapa == "Seg03"}'> selected</c:if>>Evaluaci�n Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Plaguicida"<c:if test='${empresa.plaguicidaEtapa == "Ingreso a Programa de Vigilancia de Plaguicida"}'> selected</c:if>>Ingreso a Programa de Vigilancia de Plaguicida</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.plaguicidaEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Plaguicida Observaciones</td><td> : </td>
			<td><input  type="text"  value="${empresa.plaguicidaTexto}"		id="plaguicidaTexto" 	name="plaguicidaTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>MMC</td><td> : </td>
			<td>
			<select id="mmc" 	name="mmc" required>
				<option value="Si"<c:if test='${empresa.mmc == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.mmc == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>MMC Etapa</td><td> : </td>
			<td>
			<select id="mmcEtapa" 	name="mmcEtapa">
				<option value="Difusi�n"<c:if test='${empresa.mmcEtapa == "Difusi�n"}'> selected</c:if>>Difusi�n</option>
				<option value="Asesor�a en la construcci�n de la matriz� MMC"<c:if test='${empresa.mmcEtapa == "Asesor�a en la construcci�n de la matriz� MMC"}'> selected</c:if>>Asesor�a en la construcci�n de la matriz� MMC</option>
				<option value="Reuni�n de presentaci�n resultados de la Matriz MMC"<c:if test='${empresa.mmcEtapa == "Reuni�n de presentaci�n resultados de la Matriz MMC"}'> selected</c:if>>Reuni�n de presentaci�n resultados de la Matriz MMC</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.mmcEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>MMC Observaciones</td><td> : </td>
			<td><input  type="text"  	value="${empresa.mmcTexto}"	id="mmcTexto" 	name="mmcTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>TMERT</td><td> : </td>
			<td>
			<select id="tmert" 	name="tmert" required>
				<option value="Si"<c:if test='${empresa.tmert == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.tmert == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>TMERT Etapa</td><td> : </td>
			<td>
			<select id="tmertEtapa" 	name="tmertEtapa">
				<option value="Difusi�n"<c:if test='${empresa.tmertEtapa == "Difusi�n"}'> selected</c:if>>Difusi�n</option>
				<option value="Asesor�a en la aplicaci�n de listas de chequeo"<c:if test='${empresa.tmertEtapa == "Asesor�a en la aplicaci�n de listas de chequeo"}'> selected</c:if>>Asesor�a en la aplicaci�n de listas de chequeo</option>
				<option value="Reuni�n de presentaci�n resultados de la Matriz MMC"<c:if test='${empresa.tmertEtapa == "Reuni�n de presentaci�n resultados de la Matriz MMC"}'> selected</c:if>>Reuni�n de presentaci�n resultados de la Matriz MMC</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.tmertEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>TMERT Observaciones</td><td> : </td>
			<td><input  type="text"  value="${empresa.tmertTexto}"		id="tmertTexto" 	name="tmertTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Radiaci�n UV</td><td> : </td>
			<td>
			<select id="radiacionUV" 	name="radiacionUV" required>
				<option value="Si"<c:if test='${empresa.radiacionUV == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.radiacionUV == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiaci�n UV Etapa</td><td> : </td>
			<td>
			<select id="radiacionUVEtapa" 	name="radiacionUVEtapa">
				<option value="Evaluaci�n Cualitativa"<c:if test='${empresa.radiacionUVEtapa == "Evaluaci�n Cualitativa"}'> selected</c:if>>Evaluaci�n Cualitativa</option>
				<option value="Difusi�n de la Gu�a"<c:if test='${empresa.radiacionUVEtapa == "Difusi�n de la Gu�a"}'> selected</c:if>>Difusi�n de la Gu�a</option>
				<option value="Asesor�a en la definici�n del Programa de gesti�n del riesgo de UV solar"<c:if test='${empresa.radiacionUVEtapa == "Asesor�a en la definici�n del Programa de gesti�n del riesgo de UV solar"}'> selected</c:if>>Asesor�a en la definici�n del Programa de gesti�n del riesgo de UV solar</option>
				<option value="Apoyo en la implementaci�n del programa y seguimiento"<c:if test='${empresa.radiacionUVEtapa == "Apoyo en la implementaci�n del programa y seguimiento"}'> selected</c:if>>Apoyo en la implementaci�n del programa y seguimiento</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiaci�n UV Observaciones</td><td> : </td>
			<td><input  type="text"  	value="${empresa.radiacionUVTexto}"	id="radiacionUVTexto" 	name="radiacionUVTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Experto</td><td> : </td>
			<td> <input required type="text" class="fecha"	value="${empresa.ultimaVisitaExperto}"	id="ultimaVisitaExperto" 		name="ultimaVisitaExperto" 		placeholder="Ultima Visita Experto" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Director</td><td> : </td>
			<td> <input required type="text" class="fecha"	value="${empresa.ultimaVisitaDirector}"	id="ultimaVisitaDirector" 		name="ultimaVisitaDirector" 		placeholder="Ultima Visita Director" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Gerente</td><td> : </td>
			<td> <input required type="text" 	class="fecha" value="${empresa.ultimaVisitaGTTE}"	id="ultimaVisitaGTTE" 		name="ultimaVisitaGTTE" 		placeholder="Ultima Visita Gerente" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Alta Gerencia</td><td> : </td>
			<td> <input required type="text" 	class="fecha" value="${empresa.ultimaVisitaAltaGerencia}"	id="ultimaVisitaAltaGerencia" 		name="ultimaVisitaAltaGerencia" 		placeholder="Ultima Visita Alta Gerencia" ></td>
		</tr>
		<tr>
			<td>Reporte Visita</td><td> : </td>
			<td> <input required type="text" 	value="${empresa.reporteVisita}"	id="reporteVisita" 		name="reporteVisita" 		placeholder="Reporte Visita" ></td>
		</tr>
		<tr>
			<td>Riesgo de Fuga</td><td> : </td>
			<td>
			<select id="riesgoDeFuga" 	name="riesgoDeFuga">
				<option value="Bajo"<c:if test='${empresa.riesgoDeFuga == "Bajo"}'> selected</c:if>>Bajo</option>
				<option value="Medio"<c:if test='${empresa.riesgoDeFuga == "Medio"}'> selected</c:if>>Medio</option>
				<option value="Alto"<c:if test='${empresa.riesgoDeFuga == "Alto"}'> selected</c:if>>Alto</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Reclamo Ultimo Periodo</td><td> : </td>
			<td> <input required type="text" value="${empresa.reclamoUltimoPeriodo}"	class="fecha"	id="reclamoUltimoPeriodo" 		name="reclamoUltimoPeriodo" 		placeholder="Reclamo Ultimo Periodo" ></td>
		</tr>
		<tr>
			<td>Participaci�n Mesa Trabajo</td><td> : </td>
			<td>
			<select id="participacionMesaTrabajo" 	name="participacionMesaTrabajo">
				<option value="Si"<c:if test='${empresa.participacionMesaTrabajo == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.participacionMesaTrabajo == "No"}'> selected</c:if>>No</option>
				<option value="NoAplica"<c:if test='${empresa.participacionMesaTrabajo == "No Aplica"}'> selected</c:if>>No Aplica</option>
			</select>
			</td>
		</tr>
	</table>
	</div>
	<div id="tabs-accidentabilidad">
	<table>
	<tr>
					<td>Porcentaje de Accidentabilidad</td>
					<td>:</td>
					<td><input required type="text" id="accidentabilidad"
						name="accidentabilidad" placeholder="% de accidentabilidad"></td>
		</tr>
	</table>
	</div>
		<div id="tabs-dias_perdidos">
	<table>
	<tr>
					<td>Dias Perdidos</td>
					<td>:</td>
					<td><input required type="text" id="diasPerdidos"
						name="diasPerdidos" placeholder="N� de dias Perdidos"></td>
		</tr>
	</table>
	</div>
	</div>
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idEmpresa" name="idEmpresa" value="${empresa.idEmpresa}">
</form>
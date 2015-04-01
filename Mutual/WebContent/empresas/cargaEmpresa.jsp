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
			<li><a href="#tabs-dias_perdidos">Días Perdidos</a></li>
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
			<td>Código Cartera</td><td> : </td>
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
			<td>Número Adherente</td><td> : </td>
			<td><input required type="text"  value="${empresa.numAdherente}"		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" ></td>
		</tr>
		<tr>
			<td>Razón Social</td><td> : </td>
			<td><input required type="text" value="${empresa.razonSocial}" 		id="razonSocial" 	name="razonSocial"	placeholder="Razón Social" ></td>
		</tr>
		<tr>
			<td>Año de adhesión</td><td> : </td>
			<td><input required type="text" class="fecha" value="${empresa.anoDeAdhesion}"		id="anoDeAdhesion" 	name="anoDeAdhesion"	placeholder="Año de Adhesión" ></td>
		</tr>
		<tr>
			<td>Segmentación</td><td> : </td>
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
					<option value="">Seleccione una región</option>
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
			<td>Sistema de Gestión</td><td> : </td>
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
			<td>Etapa Sistema de Gestión</td><td> : </td>
			<td>
			<select id="etapaSistemaGestion" 	name="etapaSistemaGestion" required>
				<option value="Implementación"<c:if test='${empresa.etapaSistemaGestion == "Implementación"}'> selected</c:if>>Implementación</option>
				<option value="Auditoría"<c:if test='${empresa.etapaSistemaGestion == "Auditoría"}'> selected</c:if>>Auditoría</option>
				<option value="Certificación"<c:if test='${empresa.etapaSistemaGestion == "Certificación"}'> selected</c:if>>Certificación</option>
				<option value="No Aplica"<c:if test='${empresa.etapaSistemaGestion == "No Aplica"}'> selected</c:if>>No Aplica</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Número CPHS</td><td> : </td>
			<td><input required type="text"  value="${empresa.numCphs}"		id="numCPHS" 	name="numCPHS"	placeholder="Número CPHS" ></td>
		</tr>
		<tr>
			<td>Número CPHS Certificados</td><td> : </td>
			<td><input required type="text"  	value="${empresa.numCphsCertificado}"	id="numCPHSCertificados" 	name="numCPHSCertificados"	placeholder="Número CPHS Certificados"></td>
		</tr>
		<tr>
			<td>Número CPHS Bronce</td><td> : </td>
			<td><input required type="text"  	value="${empresa.numCphsBronce}"	id="numCPHSBronce" 	name="numCPHSBronce"	placeholder="Número CPHS Bronce" ></td>
		</tr>
		<tr>
			<td>Número CPHS Plata</td><td> : </td>
			<td><input required type="text"  value="${empresa.numCphsPlata}"		id="numCPHSPlata" 	name="numCPHSPlata"	placeholder="Número CPHS Plata" ></td>
		</tr>
		<tr>
			<td>Número CPHS Oro</td><td> : </td>
			<td><input required type="text"  value="${empresa.numCphsOro}"		id="numCPHSOro" 	name="numCPHSOro"	placeholder="Número CPHS Oro" ></td>
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
				<option value="Evaluación Cualitativa"<c:if test='${empresa.prexorEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.prexorEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Difusión del Protocolo"<c:if test='${empresa.prexorEtapa == "Difusión del Protocolo"}'> selected</c:if>>Difusión del Protocolo</option>
				<option value="Asesoría en la Construcción de la matriz de riesgo de ruido"<c:if test='${empresa.prexorEtapa == "Asesoría en la Construcción de la matriz de riesgo de ruido"}'> selected</c:if>>Asesoría en la Construcción de la matriz de riesgo de ruido</option>
				<option value="Evaluación Cualitativa del GES"<c:if test='${empresa.prexorEtapa == "Evaluación Cualitativa del GES"}'> selected</c:if>>Evaluación Cualitativa del GES</option>
				<option value="Ingreso a programa vigente de conservación auditiva"<c:if test='${empresa.prexorEtapa == "Ingreso a programa vigente de conservación auditiva"}'> selected</c:if>>Ingreso a programa vigente de conservación auditiva</option>
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
				<option value="Evaluación Cualitativa"<c:if test='${empresa.planesiEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.planesiEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Difusión del Protocolo"<c:if test='${empresa.planesiEtapa == "Difusión del Protocolo"}'> selected</c:if>>Difusión del Protocolo</option>
				<option value="Asesoría en la Construcción de la matriz de riesgo Sílice"<c:if test='${empresa.planesiEtapa == "Asesoría en la Construcción de la matriz de riesgo Sílice"}'> selected</c:if>>Asesoría en la Construcción de la matriz de riesgo Sílice</option>
				<option value="Evaluación Cualitativa del GES"<c:if test='${empresa.planesiEtapa == "Evaluación Cualitativa del GES"}'> selected</c:if>>Evaluación Cualitativa del GES</option>
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
				<option value="Evaluación Cualitativa"<c:if test='${empresa.asbestoEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
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
				<option value="Evaluación Cualitativa"<c:if test='${empresa.hipobariaEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
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
			<td>Radiación Ionizante</td><td> : </td>
			<td>
			<select id="radiaciones" 	name="radiaciones" required>
				<option value="Si"<c:if test='${empresa.radiaciones == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.radiaciones == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiación Ionizante Etapa</td><td> : </td>
			<td>
			<select id="radiacionesEtapa" 	name="radiacionesEtapa">
				<option value="Evaluación Cualitativa"<c:if test='${empresa.radiacionesEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.radiacionesEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluación Cuantitativa"<c:if test='${empresa.radiacionesEtapa == "Evaluación Cuantitativa"}'> selected</c:if>>Evaluación Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de exposición a radiaciones"<c:if test='${empresa.radiacionesEtapa == "Seg04"}'> selected</c:if>>Ingreso a Programa de Vigilancia de exposición a radiaciones</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.radiacionesEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiación Observaciones</td><td> : </td>
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
				<option value="Evaluación Cualitativa"<c:if test='${empresa.asmaEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.asmaEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluación Cuantitativa"<c:if test='${empresa.asmaEtapa == "Evaluación Cuantitativa"}'> selected</c:if>>Evaluación Cuantitativa</option>
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
				<option value="Evaluación Cualitativa"<c:if test='${empresa.solventesEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.solventesEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluación Cuantitativa"<c:if test='${empresa.solventesEtapa == "Evaluación Cuantitativa"}'> selected</c:if>>Evaluación Cuantitativa</option>
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
				<option value="Evaluación Cualitativa"<c:if test='${empresa.metalesEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.metalesEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluación Cuantitativa"<c:if test='${empresa.metalesEtapa == "Evaluación Cuantitativa"}'> selected</c:if>>Evaluación Cuantitativa</option>
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
			<td>Óxido de Etileno</td><td> : </td>
			<td>
			<select id="oxido" 	name="oxido" required>
				<option value="Si"<c:if test='${empresa.oxido == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.oxido == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Óxido de Etileno Etapa</td><td> : </td>
			<td>
			<select id="oxidoEtapa" 	name="oxidoEtapa">
				<option value="Evaluación Cualitativa"<c:if test='${empresa.oxidoEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.oxidoEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluación Cuantitativa"<c:if test='${empresa.oxidoEtapa == "Evaluación Cuantitativa"}'> selected</c:if>>Evaluación Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Oxido"<c:if test='${empresa.oxidoEtapa == "Ingreso a Programa de Vigilancia de Oxido"}'> selected</c:if>>Ingreso a Programa de Vigilancia de Oxido</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.oxidoEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Óxido de Etileno Observaciones</td><td> : </td>
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
				<option value="Evaluación Cualitativa"<c:if test='${empresa.plaguicidaEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
				<option value="No Aplica"<c:if test='${empresa.plaguicidaEtapa == "No Aplica"}'> selected</c:if>>No Aplica</option>
				<option value="Evaluación Cuantitativa"<c:if test='${empresa.plaguicidaEtapa == "Seg03"}'> selected</c:if>>Evaluación Cuantitativa</option>
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
				<option value="Difusión"<c:if test='${empresa.mmcEtapa == "Difusión"}'> selected</c:if>>Difusión</option>
				<option value="Asesoría en la construcción de la matriz  MMC"<c:if test='${empresa.mmcEtapa == "Asesoría en la construcción de la matriz  MMC"}'> selected</c:if>>Asesoría en la construcción de la matriz  MMC</option>
				<option value="Reunión de presentación resultados de la Matriz MMC"<c:if test='${empresa.mmcEtapa == "Reunión de presentación resultados de la Matriz MMC"}'> selected</c:if>>Reunión de presentación resultados de la Matriz MMC</option>
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
				<option value="Difusión"<c:if test='${empresa.tmertEtapa == "Difusión"}'> selected</c:if>>Difusión</option>
				<option value="Asesoría en la aplicación de listas de chequeo"<c:if test='${empresa.tmertEtapa == "Asesoría en la aplicación de listas de chequeo"}'> selected</c:if>>Asesoría en la aplicación de listas de chequeo</option>
				<option value="Reunión de presentación resultados de la Matriz MMC"<c:if test='${empresa.tmertEtapa == "Reunión de presentación resultados de la Matriz MMC"}'> selected</c:if>>Reunión de presentación resultados de la Matriz MMC</option>
				<option value="Seguimiento a las recomendaciones"<c:if test='${empresa.tmertEtapa == "Seguimiento a las recomendaciones"}'> selected</c:if>>Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>TMERT Observaciones</td><td> : </td>
			<td><input  type="text"  value="${empresa.tmertTexto}"		id="tmertTexto" 	name="tmertTexto"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Radiación UV</td><td> : </td>
			<td>
			<select id="radiacionUV" 	name="radiacionUV" required>
				<option value="Si"<c:if test='${empresa.radiacionUV == "Si"}'> selected</c:if>>Si</option>
				<option value="No"<c:if test='${empresa.radiacionUV == "No"}'> selected</c:if>>No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiación UV Etapa</td><td> : </td>
			<td>
			<select id="radiacionUVEtapa" 	name="radiacionUVEtapa">
				<option value="Evaluación Cualitativa"<c:if test='${empresa.radiacionUVEtapa == "Evaluación Cualitativa"}'> selected</c:if>>Evaluación Cualitativa</option>
				<option value="Difusión de la Guía"<c:if test='${empresa.radiacionUVEtapa == "Difusión de la Guía"}'> selected</c:if>>Difusión de la Guía</option>
				<option value="Asesoría en la definición del Programa de gestión del riesgo de UV solar"<c:if test='${empresa.radiacionUVEtapa == "Asesoría en la definición del Programa de gestión del riesgo de UV solar"}'> selected</c:if>>Asesoría en la definición del Programa de gestión del riesgo de UV solar</option>
				<option value="Apoyo en la implementación del programa y seguimiento"<c:if test='${empresa.radiacionUVEtapa == "Apoyo en la implementación del programa y seguimiento"}'> selected</c:if>>Apoyo en la implementación del programa y seguimiento</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiación UV Observaciones</td><td> : </td>
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
			<td>Participación Mesa Trabajo</td><td> : </td>
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
						name="diasPerdidos" placeholder="Nº de dias Perdidos"></td>
		</tr>
	</table>
	</div>
	</div>
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idEmpresa" name="idEmpresa" value="${empresa.idEmpresa}">
</form>
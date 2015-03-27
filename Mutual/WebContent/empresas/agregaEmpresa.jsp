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
			<td>Nombre Experto</td><td> : </td>
			<td><input required type="text"  		id="nomExperto" 	name="nomExperto"	placeholder="Nombre Experto" ></td>
		</tr>
		<tr>
			<td>Código Cartera</td><td> : </td>
			<td>
				<select id="codCartera" name="codCartera" required>
					<option value="" selected>Seleccione una cartera</option>
						<c:forEach items="${requestScope.listaCarteras}" var="cartera">
							<option value="${cartera.idCartera}" >${cartera.desCartera}</option>
						</c:forEach>
				</select>
			</td>
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
			<td>Año de adhesión</td><td> : </td>
			<td><input required type="text" class="fecha" 		id="anoDeAdhesion" 	name="anoDeAdhesion"	placeholder="Año de Adhesión" ></td>
		</tr>
		<tr>
			<td>Segmentación</td><td> : </td>
			<td>
			<select id="segmentacion" 	name="segmentacion" required>
					<option value="Grandes cuentas">Grandes cuentas</option>
					<option value="Estrategicas">Estrategicas</option>
					<option value="Corporativas">Corporativas</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td>
				<select id="holding" 	name="holding" required>
					<option value="Si">Si</option>
					<option value="No">No</option>
				</select>
			</td>	
		</tr>
		<tr>
			<td>Estrategicas</td><td> : </td>
			<td>
			<select id="estrategicas" 	name="estrategias" required>
					<option value="Si">Si</option>
					<option value="No">No</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Casa Matriz </td><td>:</td>
			<td>
				<select id="codRegionCasaMatriz" 	name="codRegionCasaMatriz"  required>
					<option value="">Seleccione una región</option>
					<c:forEach items="${requestScope.listaRegiones}" var="region">
						<option value="${region.codRegion}">${region.desRegion}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>Multi Region</td><td> : </td>
			<td>
			<select id="multiRegion" 	name="multiRegion" required>
				<option value="Si">Si</option>
				<option value="No">No</option>
				<option value="No Aplica">No Aplica</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Numero Centros de Trabajo</td><td> : </td>
			<td><input required type="text"  		id="numCentrosTrabajo" 	name="numCentrosTrabajo"	placeholder="Numeros Centros de Trabajo" ></td>
		</tr>
		<tr>
			<td>Masa Sum Metropolitana</td><td> : </td>
			<td><input required type="text"  		id="masaSumMetropolitana" 	name="masaSumMetropolitana"	placeholder="Masa Sum Metropolitana" ></td>
		</tr>
		<tr>
			<td>Masa Sum Nacional</td><td> : </td>
			<td><input required type="text"  		id="masaSumNacional" 	name="masaSumNacional"	placeholder="Masa Sum Nacional" ></td>
		</tr>
		<tr>
			<td>Planes de Cuenta</td><td> : </td>
			<td>
			<select id="planesDeCuenta" 	name="planesDeCuenta" required>
				<option value="Si">Si</option>
				<option value="No">No</option>
				<option value="No Aplica">No Aplica</option>
			</select>
			</td>
			</tr>
		<tr>
			<td>Planes de Trabajo</td><td> : </td>
			<td>
			<select id="planesDeTrabajo" 	name="planesDeTrabajo" required>
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Firma de planes</td><td> : </td>
			<td>
			<select id="firmaDePlanes" 	name="firmaDePlanes" required>
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Sistema de Gestión</td><td> : </td>
			<td>
			<select id="sistemaDeGestion" 	name="sistemaDeGestion" required>
				<option value="PEC Estandar">PEC Estandar</option>
				<option value="PEC Competitividad">PEC Competitividad</option>
				<option value="Excelencia">Excelencia</option>
				<option value="Autogestion">Autogestion</option>
				<option value="No Tiene">No Tiene</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Firma del protocolo</td><td> : </td>
			<td><input required type="text" class="fecha" 		id="fechaFirmaProtocolo" 	name="fechaFirmaProtocolo"	placeholder="Firma del Protocolo" ></td>
		</tr>
		<tr>
			<td>Etapa Sistema de Gestión</td><td> : </td>
			<td>
			<select id="etapaSistemaGestion" 	name="etapaSistemaGestion" required>
				<option value="Implementacion">Implementación</option>
				<option value="Auditoria">Auditoría</option>
				<option value="Certificacion">Certificación</option>
				<option value="No Aplica">No Aplica</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Número CPHS</td><td> : </td>
			<td><input required type="text"  		id="numeroCPHS" 	name="numeroCPHS"	placeholder="Número CPHS" ></td>
		</tr>
		<tr>
			<td>Número CPHS Certificados</td><td> : </td>
			<td><input required type="text"  		id="numeroCPHSCertificados" 	name="numeroCPHSCertificados"	placeholder="Número CPHS Certificados"></td>
		</tr>
		<tr>
			<td>Número CPHS Bronce</td><td> : </td>
			<td><input required type="text"  		id="numeroCPHSBronce" 	name="numeroCPHSBronce"	placeholder="Número CPHS Bronce" ></td>
		</tr>
		<tr>
			<td>Número CPHS Plata</td><td> : </td>
			<td><input required type="text"  		id="numeroCPHSPlata" 	name="numeroCPHSPlata"	placeholder="Número CPHS Plata" ></td>
		</tr>
		<tr>
			<td>Número CPHS Oro</td><td> : </td>
			<td><input required type="text"  		id="numeroCPHSOro" 	name="numeroCPHSOro"	placeholder="Número CPHS Oro" ></td>
		</tr>
		<tr>
			<td>PREXOR</td><td> : </td>
			<td>
			<select id="prexor" name="prexor" required>
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>PREXOR Etapa</td><td> : </td>
			<td>
			<select id="prexorEtapa" name="prexorEtapa" required>
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Difusión del Protocolo">Difusión del Protocolo</option>
				<option value="Asesoría en la Construcción de la matriz de riesgo de ruido">Asesoría en la Construcción de la matriz de riesgo de ruido</option>
				<option value="Evaluación Cualitativa del GES">Evaluación Cualitativa del GES</option>
				<option value="Ingreso a programa vigente de conservación auditiva">Ingreso a programa vigente de conservación auditiva</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>PREXOR Observaciones</td><td> : </td>
			<td><input required type="text"  		id="prexorObservaciones" 	name="prexorObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>TMERT</td><td> : </td>
			<td>
			<select id="tmert" 	name="tmert">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>TMERT Etapa</td><td> : </td>
			<td>
			<select id="tmertEtapa" name="tmertEtapa" required>
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Difusión del Protocolo">Difusión del Protocolo</option>
				<option value="Asesoría en la Construcción de la matriz de riesgo Sílice">Asesoría en la Construcción de la matriz de riesgo Sílice</option>
				<option value="Evaluación Cualitativa del GES">Evaluación Cualitativa del GES</option>
				<option value="Ingreso a programa vigente Neumoconiogeno">Ingreso a programa vigente Neumoconiogeno</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>TMERT Observaciones</td><td> : </td>
			<td><input required type="text"  		id="tmertObservaciones" 	name="tmertObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Asbesto</td><td> : </td>
			<td>
			<select id="asbesto" 	name="asbesto">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Asbesto Etapa</td><td> : </td>
			<td>
			<select id="asbestoEtapa" 	name="asbestoEtapa">
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Ingreso a programa vigente Neumoconiogeno">Ingreso a programa vigente Neumoconiogeno</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Asbesto Observaciones</td><td> : </td>
			<td><input required type="text"  		id="asbestoObservaciones" 	name="asbestoObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Hipobaria</td><td> : </td>
			<td>
			<select id="hipobaria" 	name="hipobaria">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Hipobaria Etapa</td><td> : </td>
			<td>
			<select id="hipobariaEtapa" 	name="hipobariaEtapa">
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Estudio Diagnostico">Estudio Diagnostico</option>
				<option value="Ingreso a Programa de Vigilancia">Ingreso a Programa de Vigilancia</option>
				<option value="Vigilancia, Seguimiento de impacto de medidas de mitigación">Ingreso a programa vigente Neumoconiogeno</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Hipobaria Observaciones</td><td> : </td>
			<td><input required type="text"  		id="hipobariaObservaciones" 	name="hipobariaObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Radiación Ionizante</td><td> : </td>
			<td>
			<select id="radiacionIonizante" 	name="radiacionIonizante">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiación Ionizante Etapa</td><td> : </td>
			<td>
			<select id="radiacionIonizanteEtapa" 	name="radiacionIonizanteEtapa">
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Evaluación Cuantitativa">Evaluación Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de exposición a radiaciones">Ingreso a Programa de Vigilancia de exposición a radiaciones</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiación Observaciones</td><td> : </td>
			<td><input required type="text"  		id="radiacionObservaciones" 	name="radiacionObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Asma</td><td> : </td>
			<td>
			<select id="asma" 	name="asma">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Asma Etapa</td><td> : </td>
			<td>
			<select id="asmaEtapa" 	name="asmaEtapa">
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Evaluación Cuantitativa">Evaluación Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Asma">Ingreso a Programa de Vigilancia de Asma</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Asma Observaciones</td><td> : </td>
			<td><input required type="text"  		id="asmaObservaciones" 	name="asmaObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Solventes</td><td> : </td>
			<td>
			<select id="solventes" 	name="solventes">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Solventes Etapa</td><td> : </td>
			<td>
			<select id="solventesEtapa" 	name="solventesEtapa">
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Evaluación Cuantitativa">Evaluación Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Solventes">Ingreso a Programa de Vigilancia de Asma</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Solventes Observaciones</td><td> : </td>
			<td><input required type="text"  		id="solventesObservaciones" 	name="solventesObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Metales</td><td> : </td>
			<td>
			<select id="metales" 	name="metales">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Metales Etapa</td><td> : </td>
			<td>
			<select id="metalesEtapa" 	name="metalesEtapa">
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Evaluación Cuantitativa">Evaluación Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Metales">Ingreso a Programa de Vigilancia de Asma</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones<s/option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Metales Observaciones</td><td> : </td>
			<td><input required type="text"  		id="metalesObservaciones" 	name="metalesObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Óxido de Etileno</td><td> : </td>
			<td>
			<select id="oxido" 	name="oxido">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Óxido de Etileno Etapa</td><td> : </td>
			<td>
			<select id="oxidoEtapa" 	name="oxidoEtapa">
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Evaluación Cuantitativa">Evaluación Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Oxido">Ingreso a Programa de Vigilancia de Oxido</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Óxido de Etileno Observaciones</td><td> : </td>
			<td><input required type="text"  		id="oxidoObservaciones" 	name="oxidoObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Plaguicida</td><td> : </td>
			<td>
			<select id="plaguicida" 	name="plaguicida">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Plaguicida Etapa</td><td> : </td>
			<td>
			<select id="plaguicidaEtapa" 	name="plaguicidaEtapa">
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="No Aplica">No Aplica</option>
				<option value="Evaluación Cuantitativa">Evaluación Cuantitativa</option>
				<option value="Ingreso a Programa de Vigilancia de Plaguicida">Ingreso a Programa de Vigilancia de Oxido</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Plaguicida Observaciones</td><td> : </td>
			<td><input required type="text"  		id="plaguicidaObservaciones" 	name="plaguicidaObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>MMC</td><td> : </td>
			<td>
			<select id="mmc" 	name="mmc">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>MMC Etapa</td><td> : </td>
			<td>
			<select id="mmcEtapa" 	name="mmcEtapa">
				<option value="Difusión">Difusión</option>
				<option value="Asesoría en la construcción de la matriz  MMC">Asesoría en la construcción de la matriz  MMC</option>
				<option value="Reunión de presentación resultados de la Matriz MMC">Reunión de presentación resultados de la Matriz MMC</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>MMC Observaciones</td><td> : </td>
			<td><input required type="text"  		id="mmcObservaciones" 	name="mmcObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>TMERT</td><td> : </td>
			<td>
			<select id="tmert" 	name="tmert">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>TMERT Etapa</td><td> : </td>
			<td>
			<select id="tmertEtapa" 	name="tmertEtapa">
				<option value="Difusión">Difusión</option>
				<option value="Asesoría en la aplicación de listas de chequeo">Asesoría en la aplicación de listas de chequeo</option>
				<option value="Reunión de presentación resultados de la Matriz MMC">Reunión de presentación resultados de la Matriz MMC</option>
				<option value="Seguimiento a las recomendaciones">Seguimiento a las recomendaciones</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>TMERT Observaciones</td><td> : </td>
			<td><input required type="text"  		id="tmertObservaciones" 	name="tmertObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Radiación UV</td><td> : </td>
			<td>
			<select id="radiacionUv" 	name="radiacionUv">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiación UV Etapa</td><td> : </td>
			<td>
			<select id="radiacionUvEtapa" 	name="radiacionUvEtapa">
				<option value="Evaluación Cualitativa">Evaluación Cualitativa</option>
				<option value="Difusión de la Guía">Difusión de la Guía</option>
				<option value="Asesoría en la definición del Programa de gestión del riesgo de UV solar">Asesoría en la definición del Programa de gestión del riesgo de UV solar</option>
				<option value="Apoyo en la implementación del programa y seguimiento">Apoyo en la implementación del programa y seguimiento</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Radiación UV Observaciones</td><td> : </td>
			<td><input required type="text"  		id="radiacionUvObservaciones" 	name="radiacionUvObservaciones"	placeholder="Observaciones" ></td>
		</tr>
		<tr>
			<td>Proyecto Investigación</td><td> : </td>
			<td> <input required type="text" 		id="proyectoInvestigacion" 		name="proyectoInvestigacion" 		placeholder="Proyecto Investigación" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Experto</td><td> : </td>
			<td> <input required type="text" class="fecha"		id="ultimaVisitaExperto" 		name="ultimaVisitaExperto" 		placeholder="Ultima Visita Experto" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Director</td><td> : </td>
			<td> <input required type="text" class="fecha"		id="ultimaVisitaDirector" 		name="ultimaVisitaDirector" 		placeholder="Ultima Visita Director" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Gerente</td><td> : </td>
			<td> <input required type="text" 	class="fecha"	id="ultimaVisitaGtte" 		name="ultimaVisitaGtte" 		placeholder="Ultima Visita Gerente" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Alta Gerencia</td><td> : </td>
			<td> <input required type="text" 	class="fecha"	id="ultimaVisitaAltaGerencia" 		name="ultimaVisitaAltaGerencia" 		placeholder="Ultima Visita Alta Gerencia" ></td>
		</tr>
		<tr>
			<td>Reporte Visita</td><td> : </td>
			<td> <input required type="text" 		id="reporteVisita" 		name="reporteVisita" 		placeholder="Reporte Visita" ></td>
		</tr>
		<tr>
			<td>Riesgo de Fuga</td><td> : </td>
			<td>
			<select id="riesgoDeFuga" 	name="riesgoDeFuga">
				<option value="Bajo">Bajo</option>
				<option value="Medio">Medio</option>
				<option value="Alto">Alto</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Reclamo Ultimo Periodo</td><td> : </td>
			<td> <input required type="text" 	class="fecha"	id="reclamoUltimoPeriodo" 		name="reclamoUltimoPeriodo" 		placeholder="Reclamo Ultimo Periodo" ></td>
		</tr>
		<tr>
			<td>Participa Mesa Trabajo</td><td> : </td>
			<td>
			<select id="participaMesaTrabajo" 	name="participaMesaTrabajo">
				<option value="Si">Si</option>
				<option value="No">No</option>
				<option value="No Aplica">No Aplica</option>
			</select>
			</td>
		</tr>
	</table>
</form>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<script type="text/javascript">
	//$('select').select2();
</script>
<script type="text/javascript">
	$(function() {
		setDatePicker();
		formatRut();
		$("#tabs").tabs();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden" id="accion" name="accion" value="agregarEmpresa">
	<input type="submit" class="submit" style="display: none;">
	<div id="tabs">
		<ul>
			<li><a href="#tabs-general">General</a></li>
			<li><a href="#tabs-salud_ocupacional">Salud Ocupacional</a></li>
		</ul>
		<div id="tabs-general">
			<table>
				<tr>
					<td>Nombre</td>
					<td>:</td>
					<td><input required type="text" id="nombre" name="nombre"
						placeholder="Nombre Empresa"></td>
				</tr>
				<tr>
					<td>Nombre Experto</td>
					<td>:</td>
					<td><input required type="text" id="nomExperto"
						name="nomExperto" placeholder="Nombre Experto"></td>
				</tr>
				<tr>
					<td>C�digo Cartera</td>
					<td>:</td>
					<td><select id="codCartera" name="codCartera" required>
							<option value="" selected>Seleccione una cartera</option>
							<c:forEach items="${requestScope.listaCarteras}" var="cartera">
								<option value="${cartera.idCartera}">${cartera.desCartera}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>N�mero Adherente</td>
					<td>:</td>
					<td><input required type="text" id="numAdherente"
						name="numAdherente" placeholder="N� Adherente"></td>
				</tr>
				<tr>
					<td>Raz�n Social</td>
					<td>:</td>
					<td><input required type="text" id="razonSocial"
						name="razonSocial" placeholder="Raz�n Social"></td>
				</tr>
				<tr>
					<td>A�o de adhesi�n</td>
					<td>:</td>
					<td><input required type="text" class="fecha"
						id="anoDeAdhesion" name="anoDeAdhesion"
						placeholder="A�o de Adhesi�n"></td>
				</tr>
				<tr>
					<td>Segmentaci�n</td>
					<td>:</td>
					<td><select id="segmentacion" name="segmentacion" required>
							<option value="Seg01">Grandes cuentas</option>
							<option value="Seg02">Estrategicas</option>
							<option value="Seg03">Corporativas</option>
					</select></td>
				</tr>
				<tr>
					<td>Holding</td>
					<td>:</td>
					<td><select id="holding" name="holding" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Estrategicas</td>
					<td>:</td>
					<td><select id="estrategica" name="estrategica" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
				<tr>
					<td>Situacion</td>
					<td>:</td>
					<td><input required type="text" id="situacion"
						name="situacion" placeholder="Situacion"></td>
				</tr>
				<tr>
					<td>Multi Region</td>
					<td>:</td>
					<td><select id="multiregion" name="multiregion" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
							<option value="No Aplica">No Aplica</option>
					</select></td>
				</tr>
				<tr>
					<td>Casa Matriz</td>
					<td>:</td>
					<td><select id="casaMatriz" name="casaMatriz" required>
							<option value="">Seleccione una regi�n</option>
							<c:forEach items="${requestScope.listaRegiones}" var="region">
								<option value="${region.codRegion}">${region.desRegion}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>Numero Centros de Trabajo</td>
					<td>:</td>
					<td><input required type="text" id="numCentrosTrabajo"
						name="numCentrosTrabajo" placeholder="Numeros Centros de Trabajo"></td>
				</tr>
				<tr>
					<td>Masa Sum Metropolitana</td>
					<td>:</td>
					<td><input required type="text" id="masaSumMetropolitana"
						name="masaSumMetropolitana" placeholder="Masa Sum Metropolitana"></td>
				</tr>
				<tr>
					<td>Masa Sum Nacional</td>
					<td>:</td>
					<td><input required type="text" id="masaSumNacional"
						name="masaSumNacional" placeholder="Masa Sum Nacional"></td>
				</tr>
				<tr>
					<td>Planes de Cuenta</td>
					<td>:</td>
					<td><select id="planesDeCuenta" name="planesDeCuenta" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
							<option value="No Aplica">No Aplica</option>
					</select></td>
				</tr>
				<tr>
					<td>Planes de Trabajo</td>
					<td>:</td>
					<td><select id="planesDeTrabajo" name="planesDeTrabajo"
						required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Firma de planes</td>
					<td>:</td>
					<td><select id="firmaDePlanes" name="firmaDePlanes" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Sistema de Gesti�n</td>
					<td>:</td>
					<td><select id="sistemaDeGestion" name="sistemaDeGestion"
						required>
							<option value="PEC Estandar">PEC Estandar</option>
							<option value="PEC Competitividad">PEC Competitividad</option>
							<option value="Excelencia">Excelencia</option>
							<option value="Autogestion">Autogestion</option>
							<option value="No Tiene">No Tiene</option>
					</select></td>
				</tr>
				<tr>
					<td>Firma del protocolo</td>
					<td>:</td>
					<td><input required type="text" class="fecha"
						id="firmaProtocolo" name="firmaProtocolo"
						placeholder="Firma del Protocolo"></td>
				</tr>
				<tr>
					<td>Etapa Sistema de Gesti�n</td>
					<td>:</td>
					<td><select id="etapaSistemaGestion"
						name="etapaSistemaGestion" required>
							<option value="Implementacion">Implementaci�n</option>
							<option value="Auditoria">Auditor�a</option>
							<option value="Certificacion">Certificaci�n</option>
							<option value="No Aplica">No Aplica</option>
					</select></td>
				</tr>
				<tr>
					<td>N�mero CPHS</td>
					<td>:</td>
					<td><input required type="text" id="numCphs" name="numCphs"
						placeholder="N�mero CPHS"></td>
				</tr>
				<tr>
					<td>N�mero CPHS Certificados</td>
					<td>:</td>
					<td><input required type="text" id="numCphsCertificado"
						name="numCphsCertificado" placeholder="N�mero CPHS Certificados"></td>
				</tr>
				<tr>
					<td>N�mero CPHS Bronce</td>
					<td>:</td>
					<td><input required type="text" id="numCphsBronce"
						name="numCphsBronce" placeholder="N�mero CPHS Bronce"></td>
				</tr>
				<tr>
					<td>N�mero CPHS Plata</td>
					<td>:</td>
					<td><input required type="text" id="numCphsPlata"
						name="numCphsPlata" placeholder="N�mero CPHS Plata"></td>
				</tr>
				<tr>
					<td>N�mero CPHS Oro</td>
					<td>:</td>
					<td><input required type="text" id="numCphsOro"
						name="numCphsOro" placeholder="N�mero CPHS Oro"></td>
				</tr>
			</table>
		</div>
		<div id="tabs-salud_ocupacional">
			<table>
				<tr>
					<td>PREXOR</td>
					<td>:</td>
					<td><select id="prexor" name="prexor" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>PREXOR Etapa</td>
					<td>:</td>
					<td><select id="prexorEtapa" name="prexorEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Difusi�n del Protocolo">Difusi�n del
								Protocolo</option>
							<option
								value="Asesor�a en la Construcci�n de la matriz de riesgo de ruido">Asesor�a
								en la Construcci�n de la matriz de riesgo de ruido</option>
							<option value="Evaluaci�n Cualitativa del GES">Evaluaci�n
								Cualitativa del GES</option>
							<option
								value="Ingreso a programa vigente de conservaci�n auditiva">Ingreso
								a programa vigente de conservaci�n auditiva</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>PREXOR Observaciones</td>
					<td>:</td>
					<td><input type="text" id="prexorTexto" name="prexorTexto"
						placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>PLANESI</td>
					<td>:</td>
					<td><select id="planesi" name="planesi" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>PLANESI Etapa</td>
					<td>:</td>
					<td><select id="planesiEtapa" name="planesiEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Difusi�n del Protocolo">Difusi�n del
								Protocolo</option>
							<option
								value="Asesor�a en la Construcci�n de la matriz de riesgo S�lice">Asesor�a
								en la Construcci�n de la matriz de riesgo S�lice</option>
							<option value="Evaluaci�n Cualitativa del GES">Evaluaci�n
								Cualitativa del GES</option>
							<option value="Ingreso a programa vigente Neumoconiogeno">Ingreso
								a programa vigente Neumoconiogeno</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>PLANESI Observaciones</td>
					<td>:</td>
					<td><input type="text" id="planesiTexto" name="planesiTexto"
						placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>Asbesto</td>
					<td>:</td>
					<td><select id="asbesto" name="asbesto" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Asbesto Etapa</td>
					<td>:</td>
					<td><select id="asbestoEtapa" name="asbestoEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Ingreso a programa vigente Neumoconiogeno">Ingreso
								a programa vigente Neumoconiogeno</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>Asbesto Observaciones</td>
					<td>:</td>
					<td><input type="text" id="asbestoTexto" name="asbestoTexto"
						placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>Hipobaria</td>
					<td>:</td>
					<td><select id="hipobaria" name="hipobaria" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Hipobaria Etapa</td>
					<td>:</td>
					<td><select id="hipobariaEtapa" name="hipobariaEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Estudio Diagnostico">Estudio Diagnostico</option>
							<option value="Ingreso a Programa de Vigilancia">Ingreso
								a Programa de Vigilancia</option>
							<option
								value="Vigilancia, Seguimiento de impacto de medidas de mitigaci�n">Ingreso
								a programa vigente Neumoconiogeno</option>
					</select></td>
				</tr>
				<tr>
					<td>Hipobaria Observaciones</td>
					<td>:</td>
					<td><input type="text" id="hipobariaTexto"
						name="hipobariaTexto" placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>Radiaci�n Ionizante</td>
					<td>:</td>
					<td><select id="radiaciones" name="radiaciones"
						required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Radiaci�n Ionizante Etapa</td>
					<td>:</td>
					<td><select id="radiacionesEtapa"
						name="radiacionesEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Evaluaci�n Cuantitativa">Evaluaci�n
								Cuantitativa</option>
							<option
								value="Ingreso a Programa de Vigilancia de exposici�n a radiaciones">Ingreso
								a Programa de Vigilancia de exposici�n a radiaciones</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>Radiaci�n Observaciones</td>
					<td>:</td>
					<td><input type="text" id="radiacionesTexto"
						name="radiacionesTexto" placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>Asma</td>
					<td>:</td>
					<td><select id="asma" name="asma" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Asma Etapa</td>
					<td>:</td>
					<td><select id="asmaEtapa" name="asmaEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Evaluaci�n Cuantitativa">Evaluaci�n
								Cuantitativa</option>
							<option value="Ingreso a Programa de Vigilancia de Asma">Ingreso
								a Programa de Vigilancia de Asma</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>Asma Observaciones</td>
					<td>:</td>
					<td><input type="text" id="asmaTexto" name="asmaTexto"
						placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>Solventes</td>
					<td>:</td>
					<td><select id="solventes" name="solventes" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Solventes Etapa</td>
					<td>:</td>
					<td><select id="solventesEtapa" name="solventesEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Evaluaci�n Cuantitativa">Evaluaci�n
								Cuantitativa</option>
							<option value="Ingreso a Programa de Vigilancia de Solventes">Ingreso
								a Programa de Vigilancia de Asma</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>Solventes Observaciones</td>
					<td>:</td>
					<td><input type="text" id="solventesTexto"
						name="solventesTexto" placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>Metales</td>
					<td>:</td>
					<td><select id="metales" name="metales" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Metales Etapa</td>
					<td>:</td>
					<td><select id="metalesEtapa" name="metalesEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Evaluaci�n Cuantitativa">Evaluaci�n
								Cuantitativa</option>
							<option value="Ingreso a Programa de Vigilancia de Metales">Ingreso
								a Programa de Vigilancia de Asma</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>Metales Observaciones</td>
					<td>:</td>
					<td><input type="text" id="metalesTexto" name="metalesTexto"
						placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>�xido de Etileno</td>
					<td>:</td>
					<td><select id="oxido" name="oxido" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>�xido de Etileno Etapa</td>
					<td>:</td>
					<td><select id="oxidoEtapa" name="oxidoEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Evaluaci�n Cuantitativa">Evaluaci�n
								Cuantitativa</option>
							<option value="Ingreso a Programa de Vigilancia de Oxido">Ingreso
								a Programa de Vigilancia de Oxido</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>�xido de Etileno Observaciones</td>
					<td>:</td>
					<td><input type="text" id="oxidoTexto" name="oxidoTexto"
						placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>Plaguicida</td>
					<td>:</td>
					<td><select id="plaguicida" name="plaguicida" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Plaguicida Etapa</td>
					<td>:</td>
					<td><select id="plaguicidaEtapa" name="plaguicidaEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="No Aplica">No Aplica</option>
							<option value="Evaluaci�n Cuantitativa">Evaluaci�n
								Cuantitativa</option>
							<option value="Ingreso a Programa de Vigilancia de Plaguicida">Ingreso
								a Programa de Vigilancia de Oxido</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>Plaguicida Observaciones</td>
					<td>:</td>
					<td><input type="text" id="plaguicidaTexto"
						name="plaguicidaTexto" placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>MMC</td>
					<td>:</td>
					<td><select id="mmc" name="mmc" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>MMC Etapa</td>
					<td>:</td>
					<td><select id="mmcEtapa" name="mmcEtapa">
							<option value="Difusi�n">Difusi�n</option>
							<option value="Asesor�a en la construcci�n de la matriz� MMC">Asesor�a
								en la construcci�n de la matriz� MMC</option>
							<option
								value="Reuni�n de presentaci�n resultados de la Matriz MMC">Reuni�n
								de presentaci�n resultados de la Matriz MMC</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>MMC Observaciones</td>
					<td>:</td>
					<td><input type="text" id="mmcTexto" name="mmcTexto"
						placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>TMERT</td>
					<td>:</td>
					<td><select id="tmert" name="tmert" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>TMERT Etapa</td>
					<td>:</td>
					<td><select id="tmertEtapa" name="tmertEtapa">
							<option value="Difusi�n">Difusi�n</option>
							<option value="Asesor�a en la aplicaci�n de listas de chequeo">Asesor�a
								en la aplicaci�n de listas de chequeo</option>
							<option
								value="Reuni�n de presentaci�n resultados de la Matriz MMC">Reuni�n
								de presentaci�n resultados de la Matriz MMC</option>
							<option value="Seguimiento a las recomendaciones">Seguimiento
								a las recomendaciones</option>
					</select></td>
				</tr>
				<tr>
					<td>TMERT Observaciones</td>
					<td>:</td>
					<td><input type="text" id="tmertTexto" name="tmertTexto"
						placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>Radiaci�n UV</td>
					<td>:</td>
					<td><select id="radiacionUv" name="radiacionUv" required>
							<option value="Si">Si</option>
							<option value="No">No</option>
					</select></td>
				</tr>
				<tr>
					<td>Radiaci�n UV Etapa</td>
					<td>:</td>
					<td><select id="radiacionUvEtapa" name="radiacionUvEtapa">
							<option value="Evaluaci�n Cualitativa">Evaluaci�n
								Cualitativa</option>
							<option value="Difusi�n de la Gu�a">Difusi�n de la Gu�a</option>
							<option
								value="Asesor�a en la definici�n del Programa de gesti�n del riesgo de UV solar">Asesor�a
								en la definici�n del Programa de gesti�n del riesgo de UV solar</option>
							<option
								value="Apoyo en la implementaci�n del programa y seguimiento">Apoyo
								en la implementaci�n del programa y seguimiento</option>
					</select></td>
				</tr>
				<tr>
					<td>Radiaci�n UV Observaciones</td>
					<td>:</td>
					<td><input type="text" id="radiacionUVTexto"
						name="radiacionUVTexto" placeholder="Observaciones"></td>
				</tr>
				<tr>
					<td>Ultima Visita Experto</td>
					<td>:</td>
					<td><input required type="text" class="fecha"
						id="ultimaVisitaExperto" name="ultimaVisitaExperto"
						placeholder="Ultima Visita Experto"></td>
				</tr>
				<tr>
					<td>Ultima Visita Director</td>
					<td>:</td>
					<td><input required type="text" class="fecha"
						id="ultimaVisitaDirector" name="ultimaVisitaDirector"
						placeholder="Ultima Visita Director"></td>
				</tr>
				<tr>
					<td>Ultima Visita Gerente</td>
					<td>:</td>
					<td><input required type="text" class="fecha"
						id="ultimaVisitaGTTE" name="ultimaVisitaGTTE"
						placeholder="Ultima Visita Gerente"></td>
				</tr>
				<tr>
					<td>Ultima Visita Alta Gerencia</td>
					<td>:</td>
					<td><input required type="text" class="fecha"
						id="ultimaVisitaAltaGerencia" name="ultimaVisitaAltaGerencia"
						placeholder="Ultima Visita Alta Gerencia"></td>
				</tr>
				<tr>
					<td>Reporte Visita</td>
					<td>:</td>
					<td><input required type="text" id="reporteVisita"
						name="reporteVisita" placeholder="Reporte Visita"></td>
				</tr>
				<tr>
					<td>Riesgo de Fuga</td>
					<td>:</td>
					<td><select id="riesgoDeFuga" name="riesgoDeFuga">
							<option value="Bajo">Bajo</option>
							<option value="Medio">Medio</option>
							<option value="Alto">Alto</option>
					</select></td>
				</tr>
				<tr>
					<td>Reclamo Ultimo Periodo</td>
					<td>:</td>
					<td><input required type="text" class="fecha"
						id="reclamoUltimoPeriodo" name="reclamoUltimoPeriodo"
						placeholder="Reclamo Ultimo Periodo"></td>
				</tr>
				<tr>
					<td>Participaci&oacute;n Mesa Trabajo</td>
					<td>:</td>
					<td><select id="participacionMesaTrabajo"
						name="participacionMesaTrabajo">
							<option value="Si">Si</option>
							<option value="No">No</option>
							<option value="No Aplica">No Aplica</option>
					</select></td>
				</tr>
			</table>
		</div>
	</div>
</form>
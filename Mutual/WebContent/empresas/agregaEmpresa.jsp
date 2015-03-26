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
			<td>Año de adhesión</td><td> : </td>
			<td><input required type="text" class="fecha" 		id="anoDeAdhesion" 	name="anoDeAdhesion"	placeholder="Año de Adhesión" ></td>
		</tr>
		<tr>
			<td>Segmentación</td><td> : </td>
			<td>
			<select id="segmentacion" 	name="segmentacion">
					<option value="Grandes cuentas">Grandes cuentas</option>
					<option value="Estrategicas">Estrategicas</option>
					<option value="Corporativas">Corporativas</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td>
				<select id="holding" 	name="holding">
					<option value="Si">Si</option>
					<option value="No">No</option>
				</select>
			</td>
			
		</tr>
		<tr>
			<td>Situación</td><td> : </td>
			<td><input required type="text"  		id="situacion" 	name="situacion"	placeholder="Situación"  ></td>
		</tr>
		<tr>
			<td>Multi Region</td><td> : </td>
			
			<td>
			<select id="multiRegion" 	name="multiRegion">
				<option value="Si">Si</option>
				<option value="No">No</option>
				<option value="No Aplica">No Aplica</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Casa Matriz</td><td> : </td>
			<td><input required type="text"  		id="casaMatriz" 	name="casaMatriz"	placeholder="Casa Matriz" ></td>
		</tr>
		<tr>
			<td>Región Casa Matriz </td><td>:</td>
			<td>
				<select id="codRegionCasaMatriz" 	name="codRegionCasaMatriz"  required>
					<option value="">Seleccione una región</option>
					<c:forEach items="${requestScope.listaRegiones}" var="region">
						<option value="${region.codRegion}">${region.desRegion}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
			<td>Masa Sum</td><td> : </td>
			<td><input required type="text"  		id="masaSum" 	name="masaSum"	placeholder="Masa Sum" ></td>
		</tr>
		<tr>
			<td>Planes de Cuenta</td><td> : </td>
			<td>
			<select id="planesDeCuenta" 	name="planesDeCuenta">
				<option value="Si">Si</option>
				<option value="No">No</option>
				<option value="No Aplica">No Aplica</option>
			</select>
			</td>
			</tr>
		<tr>
			<td>Planes de Trabajo</td><td> : </td>
			<td>
			<select id="planesDeTrabajo" 	name="planesDeTrabajo">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Firma de planes</td><td> : </td>
			<td>
			<select id="firmaDePlanes" 	name="firmaDePlanes">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Sistema de Gestión</td><td> : </td>
			<td>
			<select id="sistemaDeGestion" 	name="sistemaDeGestion">
				<option value="PEC Estandar">PEC Estandar</option>
				<option value="PEC Competitividad">PEC Competitividad</option>
				<option value="Excelencia">Excelencia</option>
				<option value="Autogestion">Autogestion</option>
				<option value="No Tiene">No Tiene</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Constitución Cphs</td><td> : </td>
			<td><input required type="text"  		id="constitucionCphs" 	name="constitucionCphs"	placeholder="Planes de CConstitución cphs" ></td>
		</tr>
		<tr>
			<td>Certificación Cphs</td><td> : </td>
			<td><input required type="text"  		id="certificacionCphs" 	name="certificacionCphs"	placeholder="Certificación cphs" ></td>
		</tr>
		<tr>
			<td>MMC</td><td> : </td>
			<td><input required type="text"  		id="mmc" 	name="mmc"	placeholder="MMC" ></td>
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
			<td>Planesi</td><td> : </td>
			<td>
			<select id="planesi" 	name="planesi">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
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
			<td>Radiación UV</td><td> : </td>
			<td>
			<select id="radiacionUv" 	name="radiacionUv">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
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
			<td>PREXOR</td><td> : </td>
			<td>
			<select id="prexor" 	name="prexor">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Psicosociales</td><td> : </td>
			<td>
			<select id="psicosociales" 	name="psicosociales">
				<option value="Si">Si</option>
				<option value="No">No</option>
			</select>
			</td>
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
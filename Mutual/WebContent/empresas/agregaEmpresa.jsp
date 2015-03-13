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
			<td>C�digo Cartera</td><td> : </td>
			<td><input required type="text"  		id="codCartera" 	name="codCartera"	placeholder="C�digo Cartera" ></td>
		</tr>
		<tr>
			<td>Nombre Experto</td><td> : </td>
			<td><input required type="text"  		id="nomExperto" 	name="nomExperto"	placeholder="Nombre Experto" ></td>
		</tr>
		<tr>
			<td>N�mero Adherente</td><td> : </td>
			<td><input required type="text"  		id="numAdherente" 	name="numAdherente"	placeholder="N� Adherente" ></td>
		</tr>
		<tr>
			<td>Raz�n Social</td><td> : </td>
			<td><input required type="text"  		id="razonSocial" 	name="razonSocial"	placeholder="Raz�n Social" ></td>
		</tr>
		<tr>
			<td>A�o de adhesi�n</td><td> : </td>
			<td><input required type="date"  		id="anoDeAdhesion" 	name="anoDeAdhesion"	placeholder="A�o de Adhesi�n" ></td>
		</tr>
		<tr>
			<td>Segmentaci�n</td><td> : </td>
			<td><input required type="text"  		id="segmentacion" 	name="segmentacion"	placeholder="Segmentaci�n"  ></td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td><input required type="text"  		id="holding" 	name="holding"	placeholder="Holding"  ></td>
		</tr>
		<tr>
			<td>Multi Region</td><td> : </td>
			<td><input required type="text"  		id="multiRegion" 	name="multiRegion"	placeholder="Multi Region" ></td>
		</tr>
		<tr>
			<td>Casa Matriz</td><td> : </td>
			<td><input required type="text"  		id="casaMatriz" 	name="casaMatriz"	placeholder="Casa Matriz" ></td>
		</tr>
		<tr>
			<td>Region Casa Matriz</td><td> : </td>
			<td><input required type="text"  		id="regionCasaMatriz" 	name="regionCasaMatriz"	placeholder="Region Casa Matriz" ></td>
		</tr>
		<tr>
			<td>Mesa Sum</td><td> : </td>
			<td><input required type="text"  		id="mesaSum" 	name="mesaSum"	placeholder="Mesa Sum" ></td>
		</tr>
		<tr>
			<td>Planes de Cuenta</td><td> : </td>
			<td><input required type="text"  		id="planesDeCuenta" 	name="planesDeCuenta"	placeholder="Planes De Cuenta" ></td>
		</tr>
		<tr>
			<td>Planes de Trabajo</td><td> : </td>
			<td><input required type="text"  		id="planesDeTrabajo" 	name="planesDeTrabajo"	placeholder="Planes de Trabajo" ></td>
		</tr>
		<tr>
			<td>Firma de Planes</td><td> : </td>
			<td><input required type="text"  		id="firmaDePlanes" 	name="firmaDePlanes"	placeholder="Firma De Planes" ></td>
		</tr>
		<tr>
			<td>Sistema de Gesti�n</td><td> : </td>
			<td><input required type="text"  		id="sistemaDeGestion" 	name="sistemaDeGestion"	placeholder="Sistema de Gesti�n" ></td>
		</tr>
		<tr>
			<td>Constituci�n Cphs</td><td> : </td>
			<td><input required type="text"  		id="constitucionCphs" 	name="constitucionCphs"	placeholder="Planes de CConstituci�n cphs" ></td>
		</tr>
		<tr>
			<td>Certificaci�n Cphs</td><td> : </td>
			<td><input required type="text"  		id="certificacionCphs" 	name="certificacionCphs"	placeholder="Certificaci�n cphs" ></td>
		</tr>
		<tr>
			<td>MMC</td><td> : </td>
			<td><input required type="text"  		id="mmc" 	name="mmc"	placeholder="MMC" ></td>
		</tr>
		<tr>
			<td>TMERT</td><td> : </td>
			<td><input required type="text"  		id="tmert" 	name="tmert"	placeholder="TMERT" ></td>
		</tr>
		<tr>
			<td>Planesi</td><td> : </td>
			<td><input required type="text"  		id="planesi" 	name="planesi"	placeholder="Planesi" ></td>
		</tr>
		<tr>
			<td>Plaguicida</td><td> : </td>
			<td><input required type="text"  		id="plaguicida" 	name="plaguicida"	placeholder="Plaguicida" ></td>
		</tr>
		<tr>
			<td>Radiaci�n UV</td><td> : </td>
			<td> <input required type="text" 		id="rdiacionUv" 		name="radiacionUv" 		placeholder="Radiaci�n UV" ></td>
		</tr>
		<tr>
			<td>Hipobaria</td><td> : </td>
			<td><input required type="text"  		id="hipobaria" 	name="hipobaria"	placeholder="Hipobaria" ></td>
		</tr>
		<tr>
			<td>PREXOR</td><td> : </td>
			<td><input required type="text"  		id="prexor" 	name="prexor"	placeholder="PREXOR" ></td>
		</tr>
		<tr>
			<td>Psicosociales</td><td> : </td>
			<td><input required type="text"  		id="psicosociales" 	name="psicosociales"	placeholder="Psicosociales" ></td>
		</tr>
		<tr>
			<td>Proyecto Investigaci�n</td><td> : </td>
			<td> <input required type="text" 		id="proyectoInvestigacion" 		name="proyectoInvestigaci�n" 		placeholder="Proyecto Investigaci�n" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Experto</td><td> : </td>
			<td> <input required type="date" 		id="ultimaVisitaExperto" 		name="ultimaVisitaExperto" 		placeholder="Ultima Visita Experto" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Director</td><td> : </td>
			<td> <input required type="date" 		id="ultimaVisitaDirector" 		name="ultimaVisitaDirector" 		placeholder="Ultima Visita Director" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Gerente</td><td> : </td>
			<td> <input required type="date" 		id="ultimaVisitaGtte" 		name="ultimaVisitaGtte" 		placeholder="Ultima Visita Gerente" ></td>
		</tr>
		<tr>
			<td>Ultima Visita Alta Gerencia</td><td> : </td>
			<td> <input required type="date" 		id="ultimaVisitaAltaGerencia" 		name="ultimaVisitaAltaGerencia" 		placeholder="Ultima Visita Alta Gerencia" ></td>
		</tr>
		<tr>
			<td>Reporte Visita</td><td> : </td>
			<td> <input required type="text" 		id="reporteVisita" 		name="reporteVisita" 		placeholder="Reporte Visita" ></td>
		</tr>
		<tr>
			<td>Riesgo de Fuga</td><td> : </td>
			<td> <input required type="text" 		id="riesgoDeFuga" 		name="riesgoDeFuga" 		placeholder="Riesgo de Fuga" ></td>
		</tr>
		<tr>
			<td>Reclamo Ultimo Pedido</td><td> : </td>
			<td> <input required type="date" 		id="reclamoUltimoPedido" 		name="reclamoUltimoPedido" 		placeholder="Reclamo Ultimo Pedido" ></td>
		</tr>
		<tr>
			<td>Participa Mesa Trabajo</td><td> : </td>
			<td> <input required type="text" 		id="participaMesaTrabajo" 		name="participaMesaTrabajo" 		placeholder="Participa Mesa Trabajo" ></td>
		</tr>
	</table>
</form>
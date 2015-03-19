<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript"> 	
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>
<script src="js/Chart.js"></script>
<script>
	var barChartData = {
		labels : [],
		datasets : [
			{
				fillColor : "rgba(143,190,0,0.8)",
				strokeColor : "rgba(143,190,0,1)",
				highlightFill : "rgba(143,190,0,1)",
				highlightStroke : "rgba(143,190,0,1)",
				data : []
			}
		]

	}
	function SetUpCharts(){
		var ctx = document.getElementById("plotArea1").getContext("2d");
		PlotDiasPerdidos = new Chart(ctx).Bar(barChartData, {
			responsive : true,animation : true
		});
		var ctx = document.getElementById("plotArea2").getContext("2d");
		PlotAccidentabilidad = new Chart(ctx).Bar(barChartData, {
			responsive : true,animation : true
		});
		for (i = 0; i < 12; i++) { 
			PlotDiasPerdidos.addData([Math.random()],i);
			PlotAccidentabilidad.addData([Math.random()],i);
		}
	}
</script>

<script type="text/javascript"> 	
	$(function() {
		SetUpCharts();
	});
</script>

<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<!--<input type="hidden"	id="accion" 		name="accion" 		value="modificarEmpresa">-->		
	<h1>${empresa.nombre}</h1>
	<table class="centrado">
		<tr>
			<td>Fecha Inicio</td><td> : </td>
			<td><input required type="text" class="fecha" 		id="fechaInicio" 	name="fechaInicio"	placeholder="Fecha Inicio" ></td>
		</tr>
		<tr>
			<td>Fecha Fin</td><td> : </td>
			<td><input required type="text" class="fecha" 		id="fechaFin" 	name="fecha Inicio"	placeholder="Fecha Fin" ></td>
		</tr>
	</table>
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idEmpresa" name="idEmpresa" value="${empresa.idEmpresa}">
	
	<div>
			<div style="width: 50%;float:left !important;">
				<canvas id="plotArea1"></canvas>
			</div>
			<div style="width: 50%;float:right !important;">
			    <canvas id="plotArea2"></canvas>
			</div>
		</div>
</form>
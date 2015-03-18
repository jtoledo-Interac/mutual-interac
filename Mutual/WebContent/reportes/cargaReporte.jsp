<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript"> 	
	$(function() {
		setDatePicker();
		formatRut();
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
</form>
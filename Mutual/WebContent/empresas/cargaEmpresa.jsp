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
		<td><input type="text" 	id="nombre"	name="nombre"	value="${empresa.nombre}"	placeholder="Nombre Empresa"></td>
	</tr>
	<tr>
		<td>Número Adherente</td><td> : </td>
		<td><input type="text" 		id="numAdherente" 	name="numAdherente"	value="${empresa.numAdherente}" placeholder="Nº Adherente"></td>
	</tr>
	</table>
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idEmpresa" name="idEmpresa" value="${empresa.idEmpresa}">
</form>
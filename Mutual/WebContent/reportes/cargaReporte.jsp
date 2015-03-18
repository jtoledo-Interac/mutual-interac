<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript"> 	
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>
	
<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<!--<input type="hidden"	id="accion" 		name="accion" 		value="modificarEmpresa">-->		
	<table class="centrado">
		<tr>
			<td>Nombre</td><td> : </td>
			<td> <input required type="text" 	value="${empresa.nombre}"	id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" ></td>
		</tr>
	</table>
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idEmpresa" name="idEmpresa" value="${empresa.idEmpresa}">
</form>
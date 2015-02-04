<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="hidden"	class="input"	id="accion"	name="accion"	value="agregarPrioridad">
	<input type="submit" class="submit" style="display:none;">
	<input type="text"	id="desPrioridad"	name="desPrioridad"	placeholder="Nombre de la Prioridad" required>
	<input type="text"	id="codPrioridad" 	name="codPrioridad"	placeholder="Codigo" maxlength="5" required> 
</form>
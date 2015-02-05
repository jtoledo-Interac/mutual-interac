<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	class="input"	id="accion" 		name="accion" 		value="agregarTipo">
	<input type="submit" class="submit" style="display:none;">
	<input type="text" 		id="desTipo" 	name="desTipo"		placeholder="Nombre Tipo" required="required">
	<input type="text" 		id="codTipo" 	name="codTipo"		placeholder="Codigo" maxlength="5" required> 
</form>
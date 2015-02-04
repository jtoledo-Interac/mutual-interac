<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarCartera">
	<input type="submit" class="submit" style="display:none;">
	<input type="text" 		id="nombre" 	required		name="nombre"		placeholder="Nombre Cartera">
</form>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formEdita" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarCartera">
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idCartera" name="idCartera" value="${cartera.idCartera}">
	<input type="text" 		id="desCartera" 	name="desCartera"	placeholder="Nombre Cartera" value="${cartera.desCartera}">
</form>
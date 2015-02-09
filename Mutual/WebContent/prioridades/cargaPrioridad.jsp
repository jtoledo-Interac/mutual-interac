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
	
<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarPrioridad" >
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idPrioridad" name="idPrioridad" value="${prioridad.idPrioridad}">
	<input type="text" 		id="desPrioridad" 	name="desPrioridad"	placeholder="Nombre Prioridad" value="${prioridad.desPrioridad}">
</form>
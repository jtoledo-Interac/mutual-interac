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
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarMedio" >
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idMedio" name="idMedio" value="${medio.idMedio}">
	<input type="text" 		id="desMedio" 	name="desMedio"	placeholder="Nombre Medio" value="${medio.desMedio}">
</form>
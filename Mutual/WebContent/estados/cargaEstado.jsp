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
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarEstado" >
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idEstado" name="idEstado" value="${estado.idEstado}">
	<input type="text" 		id="desEstado" 	name="desEstado"	placeholder="Estado" value="${estado.desEstado}">
</form>
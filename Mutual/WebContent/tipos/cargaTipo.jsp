<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  $('select').select2();
</script>
<script type="text/javascript"> 
$(function() {
		setDatePicker();
		formatRut();
	});
</script>
<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarTipo" >
	<input type="hidden" id="idTipo" name="idTipo" value="${tipo.idTipo}">
	<input type="text" 		id="desTipo" 	name="desTipo"	placeholder="Nombre Tipo" value="${tipo.desTipo}">
</form>
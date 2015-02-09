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
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarMotivo" >
	<input type="hidden" id="codMotivo" name="codMotivo" value="${motivo.idMotivo}">
	<input type="submit" class="submit" style="display:none;">
	<input type="text" 		id="desMotivo" 	name="desMotivo"	placeholder="Nombre Motivo" value="${motivo.desMotivo}">
</form>
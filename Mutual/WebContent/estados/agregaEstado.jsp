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

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	class="input"	id="accion" 		name="accion" 		value="agregarEstado">
	<input type="submit" class="submit" style="display:none;">
	<input type="text" 		id="desEstado" 	name="desEstado"		placeholder="Nuevo estado" required>
	<input type="text" 		id="codEstado" 	name="codEstado"		placeholder="Codigo" maxlength="5" required> 
</form>
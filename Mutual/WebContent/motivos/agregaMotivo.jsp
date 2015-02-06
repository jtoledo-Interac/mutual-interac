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

<form id="formAgrega" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="hidden"	class="input"	id="accion"	name="accion"	value="agregarMotivo">
	<input type="submit" class="submit" style="display:none;">
	<input type="text"	id="desMotivo"	name="desMotivo"	placeholder="Nombre del Motivo" required>
	<input type="text"	id="codMotivo" 	name="codMotivo"	placeholder="Codigo" maxlength="5" required> 
</form>
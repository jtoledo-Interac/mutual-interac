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

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarEmpresa">
	<input type="text"		id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" required>
	<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="N� Adherente" required>
	<input type="submit" class="submit" style="display:none;">
</form>
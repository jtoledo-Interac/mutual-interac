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
	<input type="hidden"	class="input"	id="accion" 		name="accion" 		value="agregarCategoriaLink">
	<input type="submit" class="submit" style="display:none;">
	<input type="text" 		id="desCategoriaLink" 	name="desCategoriaLink"		placeholder="Nombre de Categoria de Link" required="required">
</form>
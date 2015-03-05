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
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarCategoriaLink" >
	<input type="hidden" 	id="idCategoriaLink" 		name="idCategoriaLink" 	value="${categoriaLink.idCategoriaLink}">
	<input type="text" 		id="desCategoriaLink" 		name="desCategoriaLink"	placeholder="Nombre Categoria Link" value="${categoriaLink.desCategoriaLink}">
</form>
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
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarProducto" >
	<input type="hidden" id="idProducto" name="idProducto" value="${producto.idProducto}">
	<input type="submit" class="submit" style="display:none;">
	<input type="text" 		id="desProducto" 	name="desProducto"	placeholder="Nombre Producto" value="${producto.desProducto}">
</form>
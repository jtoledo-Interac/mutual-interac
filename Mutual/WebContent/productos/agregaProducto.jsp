<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  //$('select').select2();
</script>
<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	class="input"	id="accion" 		name="accion" 		value="agregarProducto">
	<input type="submit" class="submit" style="display:none;">
	<input type="text" 		id="desProducto" 	name="desProducto"		placeholder="Nombre Producto" required>
</form>
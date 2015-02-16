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
	<input type="submit" class="submit" style="display:none;">
	<table>
		<tr>
			<td>Nombre</td><td> : </td>
			<td> <input type="text"		id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" required></td>
		</tr>
		<tr>
		<td>Número Adherente</td><td> : </td>
		<td><input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" required></td>
		</tr>
	</table>
</form>
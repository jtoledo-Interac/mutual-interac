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
	<input type="hidden"	class="input"	id="accion" 		name="accion" 		value="agregarLink">
	<input type="submit" class="submit" style="display:none;">
	<table>
	<tr>
	<td> Categoría del link</td><td> : </td>
	<td><select id="idCategoriaLink"	name="idCategoriaLink" >
		<option value="0" selected>Seleccione Categoría para el link</option>
		<c:forEach items="${requestScope.listaCategoriasLink}" var="categoriaLink">
			<option value="${categoriaLink.idCategoriaLink}" > ${categoriaLink.idCategoriaLink} </option>
		</c:forEach>
	</select></td>
	</tr>
	<tr>
	<td> Link </td><td> : </td>
	<td><input type="text" 		id="urlLink" 	name="urlLink"		placeholder="www.milink.com" required="required"></td>
	</tr>
	<tr>
	<td> Descripción del Link </td><td> : </td>
	<td><input type="text" 		id="desLink" 	name="desLink"		placeholder="Descripción del link" required="required"></td>
	</tr>
	</table>
</form>
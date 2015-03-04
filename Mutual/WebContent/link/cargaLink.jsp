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
	<input type="hidden"	id="accion" 		name="accion" 	value="modificarLink" >
	<input type="hidden" 	id="idLink" 		name="idLink" 	value="${link.idLink}">
	<input type="text" 		id="desLink" 		name="desLink"	placeholder="Descripción Link" value="${link.desLink}">
	<input type="text" 		id="urlLink" 		name="urlLink"	placeholder="Link" value="${link.urlLink}">
	<select id="idCategoriaLink"	name="idCategoriaLink" >
		<option value="0" selected>Seleccione Categoría para el link</option>
		<c:forEach items="${requestScope.listaCategoriasLink}" var="categoriaLink">
			<option value="${categoriaLink.idCategoriaLink}" <c:if test='${link.idCategoriaLink == categoriaLink.idCategoriaLink}'> selected</c:if>>${categoriaLink.idCategoriaLink} </option>
		</c:forEach>
	</select>
</form>
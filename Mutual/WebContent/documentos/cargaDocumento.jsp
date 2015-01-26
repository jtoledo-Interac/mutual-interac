<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formEdita" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarDocumento">
	<input type="hidden"	id="idDocumento"				name="idDocumento"				value="${documento.idDocumento }" >
	<input type="text" 		id="nombre" 		name="nombre"		placeholder="Nombre Documento" value="${documento.nombre}">
	<input type="text" 		id="numFolio" 		name="numFolio"		placeholder="Nº Folio" value="${documento.numFolio}">
	<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" value="${documento.numAdherente}">
	<input type="text" 		id="descripcion" 	name="descripcion"	placeholder="Descripci&oacute;n" value="${documento.descripcion}">
	<input type="text" 		id="fecCreacion" 	name="fecCreacion" 	placeholder="Fecha Creaci&oacute;n" class="fecha" value="11/12/2014" readonly>

	<select id="codCartera" name="codCartera">
		<option value="" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" <c:if test='${documento.codCartera == cartera.codCartera}'> selected</c:if>>${cartera.desCartera}</option>
		</c:forEach>
	</select> 
	
	<select id="codProducto" name="codProducto">
		<option value="" selected>Seleccione un producto</option>
		<c:forEach items="${requestScope.listaProductos}" var="producto">
			<option value="${producto.codProducto}" <c:if test='${documento.codProducto == producto.codProducto}'> selected</c:if>>${producto.desProducto}</option>
		</c:forEach>
	</select> 	

	<select id="codArea" name="codArea">
		<option value="" selected>Seleccione un area</option>
		<c:forEach items="${requestScope.listaAreas}" var="area">
			<option value="${area.codArea}" <c:if test='${documento.codArea == area.codArea}'> selected</c:if>>${area.desArea}</option>
		</c:forEach>
	</select>
</form>
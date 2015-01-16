<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarDocumento">
	<input type="text" 		id="nombre" 		name="nombre"		placeholder="Nombre Documento">
	<input type="text" 		id="numFolio" 		name="numFolio"		placeholder="Nº Folio">
	<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente">
	<input type="text" 		id="descripcion" 	name="descripcion"	placeholder="Descripci&oacute;n">
	<input type="text" 		id="fecCreacion" 	name="fecCreacion" 	placeholder="Fecha Creaci&oacute;n" class="fecha" readonly>

	<select id="codCartera" name="codCartera">
		<option value="0" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
		</c:forEach>
	</select> 
	
	<select id="codProducto" name="codProducto">
		<option value="0" selected>Seleccione un producto</option>
		<c:forEach items="${requestScope.listaProductos}" var="producto">
			<option value="${producto.codProducto}" >${producto.desProducto}</option>
		</c:forEach>
	</select> 	

	<select id="codArea" name="codArea">
		<option value="0" selected>Seleccione un área</option>
		<c:forEach items="${requestScope.listaAreas}" var="area">
			<option value="${area.codArea}" >${area.desArea}</option>
		</c:forEach>
	</select>

	<input type="file" id="documento" name="documento" placeholder="Documento Adjunto">	
</form>
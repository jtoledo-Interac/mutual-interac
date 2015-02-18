<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<script type="text/javascript">
	function validar_form(f) {
		var ok = true;
		var msg = "Debe ingresar todos los campos.";
		for (i = 0; i < f.elements.length; i++) {
			switch (f.elements[i].type) {
			case "text":
				if (f.elements[i].value.length == 0) {
					f.elements[i].style.bordeColor = "#FF0000";
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			case "password":
				if (f.elements[i].value.length == 0) {
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			case "select-one":
				if (f.elements[i].selectedIndex <= 0) {
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			case "file":
				if (f.elements[i].value.length == 0) {
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			default:
				break;
			}
		}
		if (!ok) {
			alert(msg);
		}
		return ok;
	}

	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formEdita" action="Servlet" method="post"
	onSubmit="return validar_form(this)">
	<input type="hidden" id="accion" name="accion"  value="modificarDocumento" >
	<input type="hidden" id="idDocumento" name="idDocumento" value="${documento.idDocumento }">
	<table class="centrado">
		<tr>
			<td> Nombre </td><td> : </td>
			<td><input type="text" id="nombre" name="nombre" placeholder="Nombre Documento" value="${documento.nombre}"></td>
		</tr>
		<tr>
			<td> Número Folio </td><td> : </td>
			<td><input type="text" id="numFolio" name="numFolio" placeholder="Nº Folio" value="${documento.numFolio}"></td>
		</tr>
		<tr>
			<td> Número Adherente </td><td> : </td>
			<td><input type="text" id="numAdherente" name="numAdherente" placeholder="Nº Adherente" value="${documento.numAdherente}"></td>
		</tr>
		<tr>
			<td> Descripción </td><td> : </td>
			<td><input type="text" id="descripcion" name="descripcion" placeholder="Descripci&oacute;n" value="${documento.descripcion}"></td>
		</tr>
		<tr>
			<td> Cartera </td><td> : </td>
			<td><select id="idCartera" name="idCartera">
					<option value="" selected>Seleccione una cartera</option>
					<c:forEach items="${requestScope.listaCarteras}" var="cartera">
						<option value="${cartera.idCartera}"
							<c:if test='${documento.idCartera == cartera.idCartera}'> selected</c:if>>${cartera.desCartera}</option>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td> Producto </td><td> : </td>
			<td><select id="idProducto" name="idProducto">
					<option value="" selected>Seleccione un producto</option>
					<c:forEach items="${requestScope.listaProductos}" var="producto">
						<option value="${producto.idProducto}"
							<c:if test='${documento.idProducto == producto.idProducto}'> selected</c:if>>${producto.idProducto}</option>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td> Área </td><td> : </td>
			<td><select id="codArea" name="codArea" >
					<option value="" selected>Seleccione un area</option>
					<c:forEach items="${requestScope.listaAreas}" var="area">
						<option value="${area.codArea}"
							<c:if test='${documento.codArea == area.codArea}'> selected</c:if>>${area.desArea}</option>
					</c:forEach>
			</select></td>
		</tr>
	</table>
</form>
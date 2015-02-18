<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript">	
	function valida_numeros(e){
	    tecla = (document.all) ? e.keyCode : e.which;
	    //Tecla de retroceso para borrar, siempre la permite
	    if (tecla==9 || tecla==8){
	        return true;
	    }
	    // Patron de entrada, en este caso solo acepta numeros
	    patron =/[0-9]/;
	    tecla_final = String.fromCharCode(tecla);
	    return patron.test(tecla_final);
	}
	
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Upload" method="post" enctype="multipart/form-data">
<input type="hidden" id="accion" name="accion" value="agregarDocumento">
<input type="submit" class="submit" style="display:none;">
<table class="centrado">
<tr>
	<td colspan="2"><input type="file" required id="documento" class="validar" name="documento" placeholder="Documento Adjunto"></td>
</tr>
</table>
<br/>
<table class="centrado"> 
<tr>
	<td> Número Folio </td><td> : </td><td> <input type="text"	id="numFolio" required name="numFolio" placeholder="Nº Folio"	onkeypress="return valida_numeros(event)"> </td>
</tr>
<tr>
	<td> Número Adherente </td><td> : </td><td> <input type="text"	id="numAdherente" required name="numAdherente"	placeholder="Nº Adherente" onkeypress="return valida_numeros(event)"> </td>
</tr>
<tr>
	<td> Descripción </td><td> : </td><td> <input type="text"	id="descripcion" required name="descripcion" placeholder="Descripción"> </td>
</tr>
<tr>	
	<td> Cartera </td><td> : </td>
	<td><select id="idCartera" required name="idCartera">
		<option value="0" disabled selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.idCartera}" >${cartera.desCartera}</option>
		</c:forEach>
	</select> </td>
</tr>
<tr>
	<td> Producto </td><td> : </td>
	<td><select id="idProducto" required name="idProducto">
		<option value="0" disabled selected>Seleccione un producto</option>
		<c:forEach items="${requestScope.listaProductos}" var="producto">
			<option value="${producto.idProducto}" >${producto.desProducto}</option>
		</c:forEach>
	</select> </td>	
</tr>
<tr>
	<td> Área</td><td> : </td>
	<td><select id="codArea" required name="codArea">
		<option value="0" disabled selected>Seleccione un área</option>
		<c:forEach items="${requestScope.listaAreas}" var="area">
			<option value="${area.codArea}" >${area.desArea}</option>
		</c:forEach>
	</select></td>	
</tr>
<tr>
	<td> Nombre </td><td> : </td><td> <input type="text"	id="nombre"	required name="nombre" placeholder="Nombre" > </td>
</tr>
</table>
</form>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	function validar_form(f){
		var ok = true;
		var msg = "Debe ingresar todos los campos.";
		for (i = 0; i < f.elements.length; i++) { 
			switch(f.elements[i].type){
			case "text":
				if(f.elements[i].value.length==0){
					f.elements[i].style.bordeColor= "#FF0000";
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			case "password":
				if(f.elements[i].value.length==0){
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			case "select-one":
				if(f.elements[i].selectedIndex<=0){
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			case "file":
				if(f.elements[i].value.length==0){
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			default:
				break;
			}
		}
		if(!ok){
			alert(msg);
		}
		return ok;
	}
	
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)" >
<table>
<tr>
	<td> <input type="hidden"	id="accion" 		name="accion" 		value="modificarDocumento" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"> </td>
	<td> <input type="hidden"	id="idDocumento"				name="idDocumento"				value="${documento.idDocumento }" > </td>
</tr>
<tr>
	<td><input type="text" 		id="nombre" 		name="nombre"		placeholder="Nombre Documento" value="${documento.nombre}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"></td>
	<td><input type="text" 		id="numFolio" 		name="numFolio"		placeholder="Nº Folio" value="${documento.numFolio}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"></td>
</tr>
<tr>
	<td><input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" value="${documento.numAdherente}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"></td>
	<td><input type="text" 		id="descripcion" 	name="descripcion"	placeholder="Descripci&oacute;n" value="${documento.descripcion}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"></td>
</tr>
<tr>
	<td><input type="text" 		id="fecCreacion" 	name="fecCreacion" 	placeholder="Fecha Creaci&oacute;n" class="fecha" value="11/12/2014" readonly onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"></td>

	<td><select id="codCartera" name="codCartera" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" <c:if test='${documento.codCartera == cartera.codCartera}'> selected</c:if>>${cartera.desCartera}</option>
		</c:forEach>
	</select></td> 
</tr>
<tr>
	<td><select id="codProducto" name="codProducto" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="" selected>Seleccione un producto</option>
		<c:forEach items="${requestScope.listaProductos}" var="producto">
			<option value="${producto.codProducto}" <c:if test='${documento.codProducto == producto.codProducto}'> selected</c:if>>${producto.desProducto}</option>
		</c:forEach>
	</select> </td>	

	<td><select id="codArea" name="codArea" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="" selected>Seleccione un area</option>
		<c:forEach items="${requestScope.listaAreas}" var="area">
			<option value="${area.codArea}" <c:if test='${documento.codArea == area.codArea}'> selected</c:if>>${area.desArea}</option>
		</c:forEach>
	</select></td>
</tr>
</table>
</form>
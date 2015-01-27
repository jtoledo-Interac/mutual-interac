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

<form id="formAgrega" action="Servlet" method="post" onSubmit="return validar_form(this)">
<input type="hidden"	id="accion" 		name="accion" 		value="agregarDocumento">
<table>
<tr>
	<td> <input type="text"		id="numFolio" 		name="numFolio"		placeholder="Nº Folio"	onkeypress="return valida_numeros(event)" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"> </td>
	<td> <input type="text"		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" onkeypress="return valida_numeros(event)" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"> </td>
</tr>
<tr>
	<td> <input type="text"		id="descripcion" 	name="descripcion"	placeholder="Descripci&oacute;n" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"> </td>
	<td> <input type="text"		id="fecCreacion" 	name="fecCreacion" 	placeholder="Fecha Creaci&oacute;n" class="fecha" readonly onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'"> </td>
</tr>
<tr>	
	<td><select id="codCartera" name="codCartera" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
		</c:forEach>
	</select> </td>
	
	<td><select id="codProducto" name="codProducto" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione un producto</option>
		<c:forEach items="${requestScope.listaProductos}" var="producto">
			<option value="${producto.codProducto}" >${producto.desProducto}</option>
		</c:forEach>
	</select> </td>	
</tr>
<tr>
	<td><select id="codArea" name="codArea" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione un área</option>
		<c:forEach items="${requestScope.listaAreas}" var="area">
			<option value="${area.codArea}" >${area.desArea}</option>
		</c:forEach>
	</select></td>
</tr>
<tr>
	<td colspan="2"><input type="file" id="documento" name="documento" placeholder="Documento Adjunto" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">	</td>
</tr>
</table>
</form>
</body>
</html>
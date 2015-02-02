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
	
<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarProducto" >
	<input type="hidden" id="codProducto" name="codProducto" value="${producto.codProducto}">
	<input type="text" 		id="desProducto" 	name="desProducto"	placeholder="Nombre Producto" value="${producto.desProducto}">
</form>
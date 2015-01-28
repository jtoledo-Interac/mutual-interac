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

<form id="formAgrega" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarEmpresa">
	<input type="text"		id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	
	<select id="codCartera" name="codCartera" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
		</c:forEach>
	</select>
	
	<input type="text" 		id="nombreExp" 		name="nombreExp"	placeholder="Nombre Experto" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="razonSocial" 	name="razonSocial" 	placeholder="Razon Social" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="direccion" 		name="direccion"	placeholder="Direccion" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="nomRep" 		name="nomRep" 		placeholder="Nombre Representante" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="contactoRep" 	name="contactoRep" 	placeholder="Contacto Representante" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">

	<input type="text" 		id="nomPrev" 		name="nomPrev" 		placeholder="Nombre Prevensionista" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="contactoPrev" 	name="contactoPrev" placeholder="Contacto Prevensionista" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">

	<input type="text" 		id="masaSUM" 		name="masaSUM" 	placeholder="Masa SUM" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">

	<input type="text" 		id="segmentacion" 	name="segmentacion" placeholder="Segmentacion" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
</form>
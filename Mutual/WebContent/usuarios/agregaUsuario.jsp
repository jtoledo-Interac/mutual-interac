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
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarUsuario">
	<input type="text"		id="sRut" 			name="sRut" 		placeholder="Rut" class="rut2"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="hidden"	id="sDV" 			name="sDV"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="sNombres" 		name="sNombres"		placeholder="Nombres"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="sApePaterno" 	name="sApePaterno"	placeholder="Apellido Paterno"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="sApeMaterno" 	name="sApeMaterno" 	placeholder="Apellido Materno"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="sNomUsuario" 	name="sNomUsuario"	placeholder="Nombre Usuario"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="password" 	id="sContrasena1" 	name="sContrasena1" placeholder="Contrase&ntilde;a"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="password" 	id="sContrasena2" 	name="sContrasena2" placeholder="Reingrese Contrase&ntilde;a"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<select id="sCodGenero" name="sCodGenero"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="M">Masculino</option>
		<option value="F">Femenino</option>
	</select>
	<input type="text" 		id="sFecNacimiento" name="sFecNacimiento" 	placeholder="Fecha Nacimiento" class="fecha" readonly	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="sTelefono" 		name="sTelefono"		placeholder="Telefono"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="sCelular" 		name="sCelular"			placeholder="Celular"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="sEmail" 		name="sEmail"			placeholder="Email"	onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
</form>
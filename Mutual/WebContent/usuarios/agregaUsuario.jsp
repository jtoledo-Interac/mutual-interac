<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarUsuario">
	<input type="text"		id="sRut" 			name="sRut" 		placeholder="Rut" class="rut2">
	<input type="hidden"	id="sDV" 			name="sDV">
	<input type="text" 		id="sNombres" 		name="sNombres"		placeholder="Nombres">
	<input type="text" 		id="sApePaterno" 	name="sApePaterno"	placeholder="Apellido Paterno">
	<input type="text" 		id="sApeMaterno" 	name="sApeMaterno" 	placeholder="Apellido Materno">
	<input type="text" 		id="sNomUsuario" 	name="sNomUsuario"	placeholder="Nombre Usuario">
	<input type="password" 	id="sContrasena1" 	name="sContrasena1" placeholder="Contrase&ntilde;a">
	<input type="password" 	id="sContrasena2" 	name="sContrasena2" placeholder="Reingrese Contrase&ntilde;a">
	<select id="sCodGenero" name="sCodGenero">
		<option value="M">Masculino</option>
		<option value="F">Femenino</option>
	</select>
	<input type="text" 		id="sFecNacimiento" name="sFecNacimiento" 	placeholder="Fecha Nacimiento" class="fecha" readonly>
	<input type="text" 		id="sTelefono" 		name="sTelefono"		placeholder="Telefono">
	<input type="text" 		id="sCelular" 		name="sCelular"			placeholder="Celular">
	<input type="text" 		id="sEmail" 		name="sEmail"			placeholder="Email">
</form>
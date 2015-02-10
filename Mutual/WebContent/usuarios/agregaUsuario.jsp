<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  //$('select').select2();
</script>
<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarUsuario">
	<input type="text"		id="sRut" 			name="sRut" 		placeholder="Rut" class="rut2"	required="required">
	<input type="hidden"	id="sDV" 			name="sDV"	required>
	<input type="text" 		id="sNombres" 		name="sNombres"		placeholder="Nombres"	required>
	<input type="text" 		id="sApePaterno" 	name="sApePaterno"	placeholder="Apellido Paterno"	required>
	<input type="text" 		id="sApeMaterno" 	name="sApeMaterno" 	placeholder="Apellido Materno"	required>
	<input type="text" 		id="sNomUsuario" 	name="sNomUsuario"	placeholder="Nombre Usuario"	required>
	<input type="password" 	id="sContrasena1" 	name="sContrasena1" placeholder="Contrase&ntilde;a"	required pattern="[\w]{6,}" title="Mínimo 6 caracteres." onchange="formAgrega.sContrasena2.pattern = this.value;">
	<input type="password" 	id="sContrasena2" 	name="sContrasena2" placeholder="Reingrese Contrase&ntilde;a" required pattern="[\w]{6,}" title="Las contraseñas deben ser iguales.">
	<select id="sCodGenero" name="sCodGenero"	required>
		<option value="M">Masculino</option>
		<option value="F">Femenino</option>
	</select>
	<input type="text" 		id="sFecNacimiento" name="sFecNacimiento" 	placeholder="Fecha Nacimiento" class="fecha" readonly	required>
	<input type="text" 		id="sTelefono" 		name="sTelefono"		placeholder="Telefono"	required>
	<input type="text" 		id="sCelular" 		name="sCelular"			placeholder="Celular"	required>
	<input type="text" 		id="sEmail" 		name="sEmail"			placeholder="Email"	required>
</form>
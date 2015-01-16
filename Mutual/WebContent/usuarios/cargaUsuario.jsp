<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>
	
<form id="formEdita" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarUsuario">
	<input type="hidden" 	id="nIdUsuario" 	name="nIdUsuario"	value="${usuario.nIdUsuario}">
	<input type="text"		id="sRut" 			name="sRut" 		placeholder="Rut"	value="${usuario.sRutFormat}" class="rut2">
	<input type="hidden"	id="sDV" 			name="sDV" 			value="${usuario.sDV}">
	<input type="text" 		id="sNombres" 		name="sNombres"		placeholder="Nombres"	value="${usuario.sNombres}">
	<input type="text" 		id="sApePaterno" 	name="sApePaterno"	placeholder="Apellido Paterno" value="${usuario.sApePaterno}">
	<input type="text" 		id="sApeMaterno" 	name="sApeMaterno" 	placeholder="Apellido Materno" value="${usuario.sApeMaterno}">
	<input type="text" 		id="sNomUsuario" 	name="sNomUsuario"	placeholder="Nombre Usuario" value="${usuario.sNomUsuario}">
	<input type="password" 	id="sContrasena" 	name="sContrasena"  placeholder="Contrase&ntilde;a" value="${usuario.sContrasena}">
	<input type="password" 	id="sContrasena2" 	name="sContrasena2" placeholder="Reingrese Contrase&ntilde;a" value="${usuario.sContrasena}">
	<select id="sCodGenero" name="sCodGenero">
		<option value="M" <c:if test="${usuario.sCodGenero == 'M'}"> selected</c:if>>Masculino</option>
		<option value="F" <c:if test="${usuario.sCodGenero == 'F'}"> selected</c:if>>Femenino</option>
	</select>
	<input type="text" 		id="sFecNacimiento" name="sFecNacimiento" 	placeholder="Fecha Nacimiento" value="${usuario.sFecNacimiento}" class="fecha" readonly>
	<input type="text" 		id="sTelefono" 		name="sTelefono"	placeholder="Telefono" value="${usuario.sTelefono}">
	<input type="text" 		id="sCelular" 		name="sCelular"		placeholder="Celular" value="${usuario.sCelular}">
	<input type="text" 		id="sEmail" 		name="sEmail"		placeholder="Email" value="${usuario.sEmail}">
</form>
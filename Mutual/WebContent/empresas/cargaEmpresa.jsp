<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>
	
<form id="formEdita" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarEmpresa">
	<input type="hidden" 	id="nIdEmpresa" 	name="nIdEmpresa"	value="${empresa.nIdEmpresa}">
	<input type="text"		id="sRut" 			name="sRut" 		placeholder="Rut"	value="${empresa.sRutFormat}" class="rut2">
	<input type="hidden"	id="sDV" 			name="sDV" 			value="${empresa.sDV}">
	<input type="text" 		id="sNombres" 		name="sNombres"		placeholder="Nombres"	value="${empresa.sNombres}">
	<input type="text" 		id="sApePaterno" 	name="sApePaterno"	placeholder="Apellido Paterno" value="${empresa.sApePaterno}">
	<input type="text" 		id="sApeMaterno" 	name="sApeMaterno" 	placeholder="Apellido Materno" value="${empresa.sApeMaterno}">
	<input type="text" 		id="sNomEmpresa" 	name="sNomEmpresa"	placeholder="Nombre Empresa" value="${empresa.sNomEmpresa}">
	<input type="password" 	id="sContrasena" 	name="sContrasena"  placeholder="Contrase&ntilde;a" value="${empresa.sContrasena}">
	<input type="password" 	id="sContrasena2" 	name="sContrasena2" placeholder="Reingrese Contrase&ntilde;a" value="${empresa.sContrasena}">
	<select id="sCodGenero" name="sCodGenero">
		<option value="M" <c:if test="${empresa.sCodGenero == 'M'}"> selected</c:if>>Masculino</option>
		<option value="F" <c:if test="${empresa.sCodGenero == 'F'}"> selected</c:if>>Femenino</option>
	</select>
	<input type="text" 		id="sFecNacimiento" name="sFecNacimiento" 	placeholder="Fecha Nacimiento" value="${empresa.sFecNacimiento}" class="fecha" readonly>
	<input type="text" 		id="sTelefono" 		name="sTelefono"	placeholder="Telefono" value="${empresa.sTelefono}">
	<input type="text" 		id="sCelular" 		name="sCelular"		placeholder="Celular" value="${empresa.sCelular}">
	<input type="text" 		id="sEmail" 		name="sEmail"		placeholder="Email" value="${empresa.sEmail}">
</form>
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
<form id="formEdita" action="UploadImage" method="post" onSubmit="return validar_form(this)" enctype="multipart/form-data">
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarUsuario">
	<input type="hidden" 	id="nIdUsuario" 	name="nIdUsuario"	value="${usuario.idUsuario}">
	<table class="centrado">
	<tr>
		<td> Rut </td><td>:</td>
		<td>
			<input type="text"	class="inputRut"	id="sRut"	name="sRut"	placeholder="8765432"	value="${usuario.rut}"	required="required" maxlength="8" pattern="[0-9]{7,8}" title="Ingrese su rut sin puntos">
			- <input type="text"	class="inputDV"	id="sDV"	name="sDV" placeholder="1" value="${usuario.dv}"	maxlength="8" pattern="[0-9|k]" title="Ingrese sólo números o la letra k">
		</td>
	</tr>
	<tr>
		<td> Nombres </td><td>:</td>
		<td><input type="text" 		id="sNombres" 		name="sNombres"		placeholder="Nombres"	value="${usuario.nombres}"	required></td>
	</tr>
	<tr>
		<td> Apellido paterno </td><td>:</td>
		<td><input type="text" 		id="sApePaterno" 	name="sApePaterno"	placeholder="Apellido Paterno"	value="${usuario.apePaterno }"	required></td>
	</tr>
	<tr>
		<td> Apellido materno </td><td>:</td>
		<td><input type="text" 		id="sApeMaterno" 	name="sApeMaterno" 	placeholder="Apellido Materno"	value="${usuario.apeMaterno}"	required></td>
	</tr>
	<tr>
		<td> Nombre de usuario </td><td>:</td>
		<td><input type="text" 		id="sNomUsuario" 	name="sNomUsuario"	placeholder="Nombre Usuario"	value="${usuario.nomUsuario}"	required></td>
	</tr>
	<tr>
		<td> Sexo </td><td>:</td>
		<td><select id="sCodGenero" name="sCodGenero"	required>
			<option value="M" <c:if test="${usuario.codGenero == 'M'}"> selected</c:if>>Masculino</option>
			<option value="F" <c:if test="${usuario.codGenero == 'F'}"> selected</c:if>>Femenino</option>
		</select></td>
	<tr>
	<tr>
		<td> Fecha de nacimiento </td><td>:</td>
		<td><input type="text" 		id="sFecNacimiento" name="sFecNacimiento" 	placeholder="Fecha Nacimiento" class="fecha"	 value="${usuario.fecNacimiento}"	readonly	required></td>
	</tr>
	<tr>
		<td> Teléfono </td><td>:</td>
		<td><input type="text" 		id="sTelefono" 		name="sTelefono"		placeholder="Telefono"	value="${usuario.telefono}"	required></td>
	</tr>
	<tr>
		<td> Teléfono Celular </td><td>:</td>
		<td><input type="text" 		id="sCelular" 		name="sCelular"			placeholder="Celular"	value="${usuario.celular}"	required></td>
	</tr>
	<tr>
		<td> Email </td><td>:</td>
		<td><input type="email" 		id="sEmail" 		name="sEmail"			placeholder="user@mail.com"	value="${usuario.email}"	required></td>
	</tr>
	<tr>
		<td> Imagen de Perfil </td><td>:</td>
		<td>
			<input type="file" id="${usuario.idUsuario}" class="validar" name="${usuario.idUsuario}" placeholder="Documento Adjunto" accept="image/*">
		</td>
	</tr>
	</table>
</form>
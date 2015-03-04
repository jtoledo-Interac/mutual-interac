<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript">
  //$('select').select2();
</script>
<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
	
	function validarRut() {
		var numero = document.formAgrega.sRut.value;
		var dv = document.formAgrega.sDv.value;
		var dv2=0;
		console.log(nuevo_numero);
		for(i=0,j=2,suma=0; i < nuevo_numero.length; i++, ((j==7) ? j=2 : j++)) {
			suma += (parseInt(nuevo_numero.charAt(i)) * j);	
		}
		n_dv = 11 - (suma % 11);
		dv2 = ((n_dv == 11) ? 0 : ((n_dv == 10) ? "K" : n_dv));
		if(dv2 == dv) return true;
		return false;
	}
	
	function getDV(numero) {
		nuevo_numero = numero.toString().reverse();
		console.log(nuevo_numero);
		for(i=0,j=2,suma=0; i < nuevo_numero.length; i++, ((j==7) ? j=2 : j++)) {
			suma += (parseInt(nuevo_numero.charAt(i)) * j);	
		}
		n_dv = 11 - (suma % 11);
		return ((n_dv == 11) ? 0 : ((n_dv == 10) ? "K" : n_dv));
	}
</script>

<form id="formAgrega" name="formAgrega" action="Servlet" method="post" onSubmit="return validarRut()">
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarUsuario">
	
	<table class="centrado">
	<tr>
		<td> Rut </td><td>:</td>
		<td>
			<input type="text"	class="inputRut"	id="sRut"	name="sRut"	placeholder="8765432"	required="required" maxlength="8" pattern="[0-9]{7,8}" title="Ingrese su rut sin puntos">
			-<input type="text"	class="inputDV"	id="sDV"	name="sDV" placeholder="1" maxlength="8" pattern="[0-9|k]" title="Ingrese sólo números o la letra k">
		</td>
	</tr>
	<tr>
		<td> Nombres </td><td>:</td>
		<td><input type="text" 		id="sNombres" 		name="sNombres"		placeholder="Nombres"	required></td>
	</tr>
	<tr>
		<td> Apellido paterno </td><td>:</td>
		<td><input type="text" 		id="sApePaterno" 	name="sApePaterno"	placeholder="Apellido Paterno"	required></td>
	</tr>
	<tr>
		<td> Apellido materno </td><td>:</td>
		<td><input type="text" 		id="sApeMaterno" 	name="sApeMaterno" 	placeholder="Apellido Materno"	required></td>
	</tr>
	<tr>
		<td> Nombre de usuario </td><td>:</td>
		<td><input type="text" 		id="sNomUsuario" 	name="sNomUsuario"	placeholder="Nombre Usuario"	required></td>
	</tr>
	<tr>
		<td> Contraseña </td><td>:</td>
		<td><input type="password" 	id="sContrasena1" 	name="sContrasena1" placeholder="Contrase&ntilde;a"	required pattern="[\w]{6,}"	title="Mínimo 6 caracteres." onchange="formAgrega.sContrasena2.pattern = this.value;"> </td>
	</tr>
	<tr>
		<td> Repita la contraseña </td><td>:</td>
		<td><input type="password" 	id="sContrasena2" 	name="sContrasena2" placeholder="Reingrese Contrase&ntilde;a" required pattern="[\w]{6,}" title="Las contraseñas deben ser iguales."> </td>
	</tr>
	<tr>
		<td> Sexo </td><td>:</td>
		<td><select id="sCodGenero" name="sCodGenero"	required>
			<option value="M">Masculino</option>
			<option value="F">Femenino</option>
		</select></td>
	<tr>
	<tr>
		<td> Fecha de nacimiento </td><td>:</td>
		<td><input type="text" 		id="sFecNacimiento" name="sFecNacimiento" 	placeholder="Fecha Nacimiento" class="fecha" readonly	required></td>
	</tr>
	<tr>
		<td> Teléfono </td><td>:</td>
		<td><input type="text" 		id="sTelefono" 		name="sTelefono"		placeholder="Telefono"	required></td>
	</tr>
	<tr>
		<td> Teléfono Celular </td><td>:</td>
		<td><input type="text" 		id="sCelular" 		name="sCelular"			placeholder="Celular"	required></td>
	</tr>
	<tr>
		<td> Email </td><td>:</td>
		<td><input type="email" 		id="sEmail" 		name="sEmail"			placeholder="user@mail.com"	required></td>
	</tr>
	</table>
</form>
<%@ page language="java"%>
<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>

<form id="restablecer" action="Servlet" method="post">
	<input type="hidden" name="accion" value="actualizarContrasena">
	<input type="hidden" id="id" name="id" value="${id}">
	Ingrese la nueva contraseña para el usuario ${user}:<br/>
	<table>
		<tr>
			<td>Escriba su nueva contraseña</td>
			<td><input type="password" name="nuevaContrasena" required pattern="[\w]{6,}" title="Mínimo 6 caracteres." onchange="formAgrega.nuevaContrasena2.pattern = this.value;" /></td>
		</tr>
		<tr>
			<td>Vuelva a escribir su contraseña</td>
			<td><input type="password" name="nuevaContrasena2" required pattern="[\w]{6,}" title="Las contraseñas deben ser iguales."/></td>
		</tr>
		<tr>
			<td colspan="2"> <input type="submit" /> </td>
		</tr>
	</table>
</form>
</body>
</html>
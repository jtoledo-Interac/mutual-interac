<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cambiar contraseña</title>
</head>
<body>
<form action="Servlet" method="post">
	<table>
		<tr>
			<td>Escriba su nueva contraseña</td>
			<td><input type="password" id="nuevaContrasena"/></td>
		</tr>
		<tr>
			<td>Vuelva a escribir su contraseña</td>
			<td><input type="password" id="nuevaContrasena2"/></td>
		</tr>
		<tr>
			<td colspan="2"> <input type="submit" /> </td>
		</tr>
	</table>
</form>
</body>
</html>
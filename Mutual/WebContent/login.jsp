<%@ page language="java"%>
<%@ include file="declaraciones.jsp" %>
<%@ include file="encabezado.jsp" %>
<%@ page import="cl.antartis.interac.beans.Error" %>

<%
	if(session.getAttribute("user")!= null){
		response.sendRedirect("contenedor.jsp?accion=login");
	}
%>

<script type="text/javascript">
$(function()
{
	$("#btnLogin").click(function()
	{
		$('#formLogin').attr('action','Servlet?accion=login')
		$('#formLogin').submit();
	});
});
</script>

<div id="contenedor">
	<form id="formLogin" method="post">		
		<div class="centrado" style="width:270px;">
			<img src="img/logo-mutual.png" style="width:270px;margin-top:30px;">
		</div>
		
		<div id="login" style="background: url('img/trama.png');width:270px;height:210px;text-align:center;margin-top:35px;border-radius: 20px 20px" class="centrado">
			<input type="text" id="sNomUsuario" name="sNomUsuario" maxlength="20" tabindex="1" placeholder="Usuario" style="width: 150px;margin-top: 20px;border-radius: 10px 10px;height: 20px;"><br>
			<input type="password" id="sContrasena" name="sContrasena" maxlength="20" tabindex="2" placeholder="Contraseña" style="width: 150px;border-radius: 10px 10px;height: 20px;margin-top: 10px;"><br>
			<input type=image id="btnLogin" src="img/btnLogin.png" tabindex="3" alt="Login" style="width: 120px;height: 30px;margin-top:20px;"><br><br>
			<%
				Error e = ((Error)(request.getAttribute("error")));
				if(e!=null){
					if(e.getNumError().equals("1")){
						out.print("<div style='color:RED'>Datos de inicio de sesión inválidos.</div>");
					}
				}
			%>
			<a href="#" id="registrar"><span>Registrar Cuenta</span></a>
			<br>
			<a href="usuarios/recuperar.jsp"><span style="color:grey">No puedo acceder a mi cuenta &#128546</span>
			</a>
		</div>
	</form>
</div>
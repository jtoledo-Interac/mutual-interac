<%@ page language="java"%>
<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>

<style>
	#recuperar{
		width: 80%;
		margin: 0 auto;
	}
</style>

<script type="text/javascript">
	window.onload = load;
	
	function load(){
		document.getElementById('1').style.display = "none"
		document.getElementById('2').style.display = "none"
	}
	
	
	function show_hide(id){
		close();
		var obj = document.getElementById(id)
		if(id=='1'){
			if(obj.style.display == "none"){
				obj.style.display = "block"
				document.getElementById('2').style.display="none"	
			}
		}
		else{
			if(obj.style.display == "none"){
				obj.style.display = "block"
				document.getElementById('1').style.display="none"	
			}
		}
	}
</script>

<div id="recuperar">
	<h2>¿No puedes iniciar sesión?</h2><br/>
	<form id="formRecuperar" action="../Servlet" method="post">
		<input type="hidden" id="accion" name="accion" value="recuperar">
		
		<input type="radio" name="op" id="op1" value="op1" onclick="show_hide('1')"/>
		<label for = "op1">He olvidado mi contraseña</label> <br/>
		<div id="1">
			Para reestablecer la contraseña, introduce el nombre de usuario que utilizas para iniciar sesión en Interac.
			<input type="text" id="_user" name="_user" placeholder="nombre de usuario" />
		</div>
		
		<input type="radio" name="op" id="op2" value="op2" onclick="show_hide('2')"/>
		<label for = "op2">He olvidado mi nombre de usuario</label> <br/>
		<div id="2">
			Ingresa tu correo electrónico asociado a tu cuenta de Interac: 
			<input type="text" id="email" placeholder="correo@mail.com" />
		</div>
		<input type="submit" id="btnContinuar" value="Continuar"/>
	</form>
</div>
</body>
</html>
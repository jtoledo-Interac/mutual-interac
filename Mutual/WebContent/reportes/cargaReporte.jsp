<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript"> 
	/*$(function() {
		
		$('#rep1').click(function(){
			$('#accion').val("repAccidentados");
			$('#formMantenedores').submit();
		});
		
		$('#rep2').click(function(){
			$('#accion').val("repDias");
			$('#formMantenedores').submit();
		});
	});*/
</script>

<div class="mantenedor">
	<div class="filtros">	
		<form id="formReportes" action="Servlet" method="post">
			<input type="button"  onSubmit="return validar_form(this)"	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton">
			<input name="nomEmpresa">
			<datalist id="nomEmpresa" 	name="nomEmpresa"	placeholder="Nombre Empresa" class="text">
				<option value="${empresa.nombre}">
			</datalist>
		</form>
	</div>
	<div id="listadoBusquedaReporte" class="listado">
		<table id="listadoReportes"></table>
		<div id="pieEmpresa" class="pie"></div>
	</div>
</div>
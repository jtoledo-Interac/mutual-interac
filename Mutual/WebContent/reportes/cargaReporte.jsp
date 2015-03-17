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
	
	var idEmpresa;
	
	$('#btnBuscar').click(function(){
		buscarEmpresaReporte();
	});
	
	function buscarEmpresaReporte(){
		var sData = "Servlet";
		sData += "?accion=buscarEmpresas";
		sData += "&nomEmpresa="+$('#nomEmpresa').val();
		return sData;
	}
</script>

<div class="mantenedor">
	<form id="formEmpresas" action="Servlet" method="post">
		<div class="filtros">
			<input type="hidden" id="accion" name="accion">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="text" 		id="nomEmpresa" 	name="nomEmpresa"	placeholder="Nombre Empresa" class="text">
		</div>
		<span></span>
	</form>
</div>
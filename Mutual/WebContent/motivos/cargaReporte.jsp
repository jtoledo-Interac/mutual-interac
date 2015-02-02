<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		
		$('#rep1').click(function(){
			$('#accion').val("repAccidentados");
			$('#formMantenedores').submit();
		});
		
		$('#rep2').click(function(){
			$('#accion').val("repDias");
			$('#formMantenedores').submit();
		});
	});
</script>
	
<form id="formReportes" action="Servlet" method="post">
	<input type="hidden" id="accion" name="accion">
	<div class="botones">
		<div id="rep1" class="btn">
			<span>Reporte Accidentados</span>
		</div>
		<div id="rep2" class="btn">
			<span>Reporte D&iacute;as Perdidos</span>
		</div>
	</div>
</form>
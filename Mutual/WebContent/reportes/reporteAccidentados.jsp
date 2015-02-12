<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>
	
<form id="formEdita" action="Servlet" method="post">
	<div class="reportes">
	<h3 style="
    margin-left: 20px;
    margin-top: 10px;">Reporte Accidentados</h3>
		<div style="
    margin-left: 20px;
    margin-top: 20px;
">
			<span>Ingrese archivo excel a procesar: </span>
			<input type="file" id="documento" name="documento" placeholder="Documento Adjunto">
			<input type="button" id="btnCargar" class="boton" value="Generar">
		</div>
	</div>
</form>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>
	
<form id="formEdita" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarEmpresa">
	<input type="text" 	id="nombre" 	name="nombre"	value="${empresa.nombre}">
	<input type="text" 		id="numAdherente" 	name="numAdherente"	value="${empresa.numAdherente}">
</form>
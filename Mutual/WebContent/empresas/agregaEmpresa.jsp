<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarEmpresa">
	<input type="text"		id="nombre" 		name="nombre" 		placeholder="Nombre Empresa">
	
	<select id="codCartera" name="codCartera">
		<option value="0" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
		</c:forEach>
	</select>
	
	<input type="text" 		id="nombreExp" 		name="nombreExp"	placeholder="Nombre Experto">
	<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente">
	<input type="text" 		id="razonSocial" 	name="razonSocial" 	placeholder="Razon Social">
	<input type="text" 		id="direccion" 		name="direccion"	placeholder="Direccion">
	<input type="text" 		id="nomRep" 		name="nomRep" 		placeholder="Nombre Representante">
	<input type="text" 		id="contactoRep" 	name="contactoRep" 	placeholder="Contacto Representante">

	<input type="text" 		id="nomPrev" 		name="nomPrev" 		placeholder="Nombre Prevensionista">
	<input type="text" 		id="contactoPrev" 	name="contactoPrev" placeholder="Contacto Prevensionista">

	<input type="text" 		id="masaSUM" 		name="masaSUM" 	placeholder="Masa SUM" >

	<input type="text" 		id="segmentacion" 	name="segmentacion" placeholder="Segmentacion">
</form>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  //$('select').select2();
</script>
<script type="text/javascript"> 
$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarEmpresa">
	<input type="text"		id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" required>
	<input type="submit" class="submit" style="display:none;">
	<!--  <select id="codCartera" name="codCartera" required>
		<option value="0" disabled selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
		</c:forEach>
	</select>-->
	  
	<input type="text" 		id="nombreExp" 		name="nombreExp"	placeholder="Nombre Experto" required>
	<!--
	<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" required>
	<input type="text" 		id="razonSocial" 	name="razonSocial" 	placeholder="Razon Social" required>
	<input type="text" 		id="direccion" 		name="direccion"	placeholder="Direccion" required>
	<input type="text" 		id="nomRep" 		name="nomRep" 		placeholder="Nombre Representante" required>
	<input type="text" 		id="contactoRep" 	name="contactoRep" 	placeholder="Contacto Representante" required>

	<input type="text" 		id="nomPrev" 		name="nomPrev" 		placeholder="Nombre Prevensionista" required>
	<input type="text" 		id="contactoPrev" 	name="contactoPrev" placeholder="Contacto Prevensionista" required>

	<input type="text" 		id="masaSUM" 		name="masaSUM" 	placeholder="Masa SUM" required>

	<input type="text" 		id="segmentacion" 	name="segmentacion" placeholder="Segmentacion" required>
	-->
</form>
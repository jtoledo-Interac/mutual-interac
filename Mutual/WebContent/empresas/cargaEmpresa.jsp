<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript"> 	
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>
	
<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="hidden"	id="accion" 		name="accion" 		value="modificarEmpresa">		
	<table class="centrado">
		<tr>
			<td>Nombre</td><td> : </td>
			<td><input type="text" 	id="nombre"	name="nombre"	value="${empresa.nombre}"	placeholder="Nombre Empresa"></td>
		</tr>
		<tr>
			<td>Código Cartera</td><td> : </td>
			<td><input type="text" 		id="codCartera" 	name="codCartera" value="${empresa.codCartera}"	placeholder="Código Cartera" required></td>
		</tr>
		<tr>
			<td>Nombre Experto</td><td> : </td>
			<td><input type="text" 		id="nomExperto" 	name="nomExperto" value="${empresa.nomExperto}"	placeholder="Nombre Experto" required></td>
		</tr>
		<tr>
			<td>Número Adherente</td><td> : </td>
			<td><input type="text" 		id="numAdherente" 	name="numAdherente"	value="${empresa.numAdherente}" placeholder="Nº Adherente"></td>
		</tr>
		<tr>
			<td>Razón Social</td><td> : </td>
			<td><input type="text" 		id="razonSocial" 	name="razonSocial" value="${empresa.razonSocial}"	placeholder="Razón Social" required></td>
		</tr>
		<tr>
			<td>Dirección</td><td> : </td>
			<td><input type="text" 		id="direccion" 	name="direccion" value="${empresa.direccion}"	placeholder="Dirección" required></td>
		</tr>
		<tr>
			<td>Representante</td><td> : </td>
			<td><input type="text" 		id="representante" 	name="representante" value="${empresa.representante}"	placeholder="Representante" required></td>
		</tr>
		<tr>
			<td>Contacto Representante</td><td> : </td>
			<td><input type="text" 		id="contactoRepresentante" 	name="contactoRepresentante" value="${empresa.contactoRepresentante}"	placeholder="Contacto Rerpresentante" required></td>
		</tr>
		<tr>
			<td>Nombre Prevencionista</td><td> : </td>
			<td><input type="text" 		id="nombrePrevencionista" 	name="nombrePrevencionista"	placeholder="Nombre Prevencionista" value="${empresa.nombrePrevencionista}" required></td>
		</tr>
		<tr>
			<td>Contacto Prevencionista</td><td> : </td>
			<td><input type="text" 		id="contactoPrevencionista" 	name="contactoPrevencionista" value="${empresa.contactoPrevencionista}"	placeholder="Contacto Prevencionista" required></td>
		</tr>
		<tr>
			<td>Masa Sum</td><td> : </td>
			<td><input type="text" 		id="masaSum" 	name="masaSum" value="${empresa.masaSum}"	placeholder="Masa Sum" required></td>
		</tr>
		<tr>
			<td>Segmentación</td><td> : </td>
			<td><input type="text" 		id="segmentacion" 	name="segmentacion" value="${empresa.segmentacion}"	placeholder="Segmentación" required></td>
		</tr>
		<tr>
			<td>Multi Regional</td><td> : </td>
			<td><input type="text" 		id="multiregional" 	name="multiregional" value="${empresa.multiregional}"	placeholder="Multi Regional" required></td>
		</tr>
		<tr>
			<td>Número de Centros</td><td> : </td>
			<td><input type="text" 		id="numCentros" 	name="numCentros" value="${empresa.numCentros}"	placeholder="Número de Centros" required></td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td><input type="text" 		id="holding" 	name="holding" value="${empresa.holding}"	placeholder="Holding" required></td>
		</tr>
		<tr>
			<td>Número CHPS</td><td> : </td>
			<td><input type="text" 		id="numCHPS" 	name="numCHPS" value="${empresa.numCHPS}"	placeholder="Númer CHPS" required></td>
		</tr>
		<tr>
			<td>Nombre Presidente</td><td> : </td>
			<td><input type="text" 		id="nomPresidente" 	name="nomPresidente" value="${empresa.nomPresidente}"	placeholder="Nombre Presidente" required></td>
		</tr>
		<tr>
			<td>Nombre Secretario</td><td> : </td>
			<td><input type="text" 		id="nomSecretario" 	name="nomSecretario" value="${empresa.nomSecretario}"	placeholder="Nombre Secretario" required></td>
		</tr>
		<tr>
			<td>Saami</td><td> : </td>
			<td><input type="text" 		id="saami" 	name="saami" value="${empresa.saami}"	placeholder="Saami" required></td>
		</tr>
		<tr>
			<td>Amputaciones</td><td> : </td>
			<td><input type="text" 		id="amputaciones" 	name="amputaciones" value="${empresa.amputaciones}"	placeholder="Amputaciones" required></td>
		</tr>
		<tr>
			<td>Fatales</td><td> : </td>
			<td><input type="text" 		id="fatales" 	name="fatales" value="${empresa.fatales}"	placeholder="Fatales" required></td>
		</tr>
		<tr>
			<td>Proyectos Desarrollados</td><td> : </td>
			<td><input type="text" 		id="proyectosDesarrollados" 	name="proyectoDesarrollados" value="${empresa.proyectosDesarrollados}"	placeholder="Proyecto Desarrollados" required></td>
		</tr>
		</table>
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden" id="idEmpresa" name="idEmpresa" value="${empresa.idEmpresa}">
</form>
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
	<input type="submit" class="submit" style="display:none;">
	<table>
		<tr>
			<td>Nombre</td><td> : </td>
			<td> <input type="text"		id="nombre" 		name="nombre" 		placeholder="Nombre Empresa" required></td>
		</tr>
		<tr>
			<td>Código Cartera</td><td> : </td>
			<td><input type="text" 		id="codCartera" 	name="codCartera"	placeholder="Código Cartera" required></td>
		</tr>
		<tr>
			<td>Nombre Experto</td><td> : </td>
			<td><input type="text" 		id="nomExperto" 	name="nomExperto"	placeholder="Nombre Experto" required></td>
		</tr>
		<tr>
			<td>Número Adherente</td><td> : </td>
			<td><input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" required></td>
		</tr>
		<tr>
			<td>Razón Social</td><td> : </td>
			<td><input type="text" 		id="razonSocial" 	name="razonSocial"	placeholder="Razón Social" required></td>
		</tr>
		<tr>
			<td>Dirección</td><td> : </td>
			<td><input type="text" 		id="direccion" 	name="direccion"	placeholder="Dirección" required></td>
		</tr>
		<tr>
			<td>Representante</td><td> : </td>
			<td><input type="text" 		id="representante" 	name="representante"	placeholder="Representante" required></td>
		</tr>
		<tr>
			<td>Contacto Representante</td><td> : </td>
			<td><input type="text" 		id="contactoRepresentante" 	name="contactoRepresentante"	placeholder="Contacto Rerpresentante" required></td>
		</tr>
		<tr>
			<td>Nombre Previsionista</td><td> : </td>
			<td><input type="text" 		id="nombrePrevisionista" 	name="nombrePrevisionista"	placeholder="Nombre Previsionista" required></td>
		</tr>
		<tr>
			<td>Contacto Previsionista</td><td> : </td>
			<td><input type="text" 		id="contactoPrevisionista" 	name="contactoPrevisionista"	placeholder="Contacto Previsionista" required></td>
		</tr>
		<tr>
			<td>Masa Sum</td><td> : </td>
			<td><input type="text" 		id="masaSum" 	name="masaSum"	placeholder="Masa Sum" required></td>
		</tr>
		<tr>
			<td>Segmentación</td><td> : </td>
			<td><input type="text" 		id="segmentacion" 	name="segmentacion"	placeholder="Segmentación" required></td>
		</tr>
		<tr>
			<td>Multi Regional</td><td> : </td>
			<td><input type="text" 		id="multiregional" 	name="multiregional"	placeholder="Multi Regional" required></td>
		</tr>
		<tr>
			<td>Número de Centros</td><td> : </td>
			<td><input type="text" 		id="numCentros" 	name="numCentros"	placeholder="Número de Centros" required></td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td><input type="text" 		id="holding" 	name="holding"	placeholder="Holding" required></td>
		</tr>
		<tr>
			<td>Número CHPS</td><td> : </td>
			<td><input type="text" 		id="numCHPS" 	name="numCHPS"	placeholder="Númer CHPS" required></td>
		</tr>
		<tr>
			<td>Nombre Presidente</td><td> : </td>
			<td><input type="text" 		id="nomPresidente" 	name="nomPresidente"	placeholder="Nombre Presidente" required></td>
		</tr>
		<tr>
			<td>Nombre Secretario</td><td> : </td>
			<td><input type="text" 		id="nomSecretario" 	name="nomSecretario"	placeholder="Nombre Secretario" required></td>
		</tr>
		<tr>
			<td>Saami</td><td> : </td>
			<td><input type="text" 		id="saami" 	name="saami"	placeholder="Saami" required></td>
		</tr>
		<tr>
			<td>Amputaciones</td><td> : </td>
			<td><input type="text" 		id="amputaciones" 	name="amputaciones"	placeholder="Amputaciones" required></td>
		</tr>
		<tr>
			<td>Fatales</td><td> : </td>
			<td><input type="text" 		id="fatales" 	name="fatales"	placeholder="Fatales" required></td>
		</tr>
		<tr>
			<td>Proyectos Desarrollados</td><td> : </td>
			<td><input type="text" 		id="proyectosDesarrollados" 	name="proyectoDesarrollados"	placeholder="Proyecto Desarrollados" required></td>
		</tr>
		
	</table>
</form>
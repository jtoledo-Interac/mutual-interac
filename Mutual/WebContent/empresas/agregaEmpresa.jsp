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
			<td>C�digo Cartera</td><td> : </td>
			<td><input type="text" 		id="codCartera" 	name="codCartera"	placeholder="C�digo Cartera" required></td>
		</tr>
		<tr>
			<td>Nombre Experto</td><td> : </td>
			<td><input type="text" 		id="nomExperto" 	name="nomExperto"	placeholder="Nombre Experto" required></td>
		</tr>
		<tr>
			<td>N�mero Adherente</td><td> : </td>
			<td><input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="N� Adherente" required></td>
		</tr>
		<tr>
			<td>Raz�n Social</td><td> : </td>
			<td><input type="text" 		id="razonSocial" 	name="razonSocial"	placeholder="Raz�n Social" required></td>
		</tr>
		<tr>
			<td>Direcci�n</td><td> : </td>
			<td><input type="text" 		id="direccion" 	name="direccion"	placeholder="Direcci�n" required></td>
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
			<td>Segmentaci�n</td><td> : </td>
			<td><input type="text" 		id="segmentacion" 	name="segmentacion"	placeholder="Segmentaci�n" required></td>
		</tr>
		<tr>
			<td>Multi Regional</td><td> : </td>
			<td><input type="text" 		id="multiregional" 	name="multiregional"	placeholder="Multi Regional" required></td>
		</tr>
		<tr>
			<td>N�mero de Centros</td><td> : </td>
			<td><input type="text" 		id="numCentros" 	name="numCentros"	placeholder="N�mero de Centros" required></td>
		</tr>
		<tr>
			<td>Holding</td><td> : </td>
			<td><input type="text" 		id="holding" 	name="holding"	placeholder="Holding" required></td>
		</tr>
		<tr>
			<td>N�mero CHPS</td><td> : </td>
			<td><input type="text" 		id="numCHPS" 	name="numCHPS"	placeholder="N�mer CHPS" required></td>
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
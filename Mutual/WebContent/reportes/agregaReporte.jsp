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
	<input type="hidden"	id="accion" 		name="accion" 		value="agregarReporte">
	<input type="submit" class="submit" style="display:none;">
	<table>
		<tr>
			<td>
				<select id="idEmpresa" name="idEmpresa" required>
					<option value="" selected>Seleccione Empresa</option>
					<c:forEach items="${requestScope.listaEmpresas}" var="prioridad">
						<option value="${empresa.idEmpresa}" >${empresa.nombre}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>Dias Perdidos</td><td> : </td>
			<td> <input required type="text" 		id="diasPerdidos" 		name="diasPerdidos" 		placeholder="Dias Perdidos" ></td>
		</tr>
		<tr>
			<td>Accidentabilidad</td><td> : </td>
			<td> <input required type="text" 		id="accidentabilidad" 		name="accidentabilidad" 		placeholder="Accidentabilidad" ></td>
		</tr>
		<tr>
			<td>Fecha</td><td> : </td>
			<td><input required type="text" class="fecha" 		id="fechaReporte" 	name="fechaReporte"	placeholder="Fecha" ></td>
		</tr>
	</table>
</form>
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
				<select id="id_empresa" name="id_empresa" required>
					<option value="" selected>Seleccione Empresa</option>
					<c:forEach items="${requestScope.listaEmpresas}" var="prioridad">
						<option value="${empresa.idEmpresa}" >${empresa.nombre}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
	</table>
</form>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script>
	$(function() {
		setDatePicker();
		formatRut();
	});
	$('#btnSeleccionar').click(function()
	{
		alert(1);
	    seleccionarEmpresa();
	});
	
	$('#seleccionarEmpresa').dialog({
		autoOpen: false,
	    height: 400,
	    width: 600,
	    modal: true,
	    position: 'center',
	    buttons: {
			"Ok": function() {
				$('#formEdita .submit').click();
			},
			"Cancelar": function() {
				$(this).dialog("close");
		    }
	    },
		close: function() {
			$('#formEdita input').val(''); //limpia Data
		}
	});
	
	function seleccionarEmpresa()
	{
		alert(2);
		ajaxCall(getUrlSeleccionarEmpresa(), function(response){
			$('#seleccionarEmpresa').html(response).dialog('open');
		});
	}
	function getUrlSeleccionarEmpresa()
	{	
		alert(3);
		var sData = "Servlet";
		sData += '?accion=seleccionarEmpresa';
		return sData;
	}
</script>

<div id="seleccionarEmpresa" title="Seleccionar Empresa" style="display:none"></div>
<form id="formAgrega" action="Servlet" method="post">
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden"	id="accion"	name="accion"	value="agregarReclamo">
<table class="centrado">
	<tr>
		<td> Número de adherente </td><td>:</td><td><input type="text" 		id="num_adherente" 			name="num_adherente"			placeholder="Nº Adherente" onkeypress="return valida_numeros(event)" required>  <input type="button" value="Buscar" id="btnSeleccionar"></td>
	</tr>
	<tr>
		<td> Nombre solicitante </td><td>:</td><td><input type="text" 		id="nombre_solicitante" 	name="nombre_solicitante"		placeholder="nombre_solicitante"  required> </td>
	</tr>
	<tr>
		<td> Email </td><td>:</td><td><input type="text" 		id="contacto@mail.com" 		name="email_solicitante" 		placeholder="email_solicitante"  required> </td>
	</tr>
	<tr>
		<td> Teléfono solicitante </td><td>:</td><td><input type="text" 		id="fono_solicitante" 		name="fono_solicitante" 		placeholder="fono_solicitante" onkeypress="return valida_numeros(event)" required> </td>
	</tr>
	<tr>
		<td> Región </td><td>:</td>
		<td><select id="cod_region"	name="cod_region"  required>
		<option value="0" selected>Seleccione una región </option>
		<c:forEach items="${requestScope.listaRegiones}" var="region">
			<option value="${region.codRegion}" >${region.desRegion}</option>
		</c:forEach>
		</select>	</td>
	</tr>
	<tr>
		<td> Tipo </td><td>:</td>
		<td><select id="id_tipo" name="id_tipo" required>
			<option value="0" selected>Seleccione un tipo</option>
			<c:forEach items="${requestScope.listaTipos}" var="tipo">
				<option value="${tipo.idTipo}">${tipo.desTipo}</option>
			</c:forEach>
		</select> 	</td>
	</tr>

	<tr>
		<td> Motivo </td><td>:</td>
		<td><select id="id_motivo" name="id_motivo" required>
			<option value="0" selected>Seleccione un motivo</option>
			<c:forEach items="${requestScope.listaMotivos}" var="motivo">
				<option value="${motivo.idMotivo}" >${motivo.desMotivo}</option>
			</c:forEach>
		</select></td>
	</tr>
	
	<tr>
		<td> Prioridad </td><td>:</td>
		<td><select id="id_prioridad" name="id_prioridad" required>
			<option value="0" selected>Seleccione una prioridad</option>
			<c:forEach items="${requestScope.listaPrioridades}" var="prioridad">
				<option value="${prioridad.idPrioridad}" >${prioridad.desPrioridad}</option>
			</c:forEach>
		</select></td>
	</tr>

	<tr>
		<td> Cartera </td><td>:</td>
		<td><select id="id_cartera" name="id_cartera" required>
			<option value="0" selected>Seleccione una cartera</option>
			<c:forEach items="${requestScope.listaCarteras}" var="cartera">
				<option value="${cartera.idCartera}" >${cartera.desCartera}</option>
			</c:forEach>
		</select> </td>
	</tr>
	
	<tr>
		<td> Estado </td><td>:</td>
		<td><select id="id_estado" name="id_estado" required>
			<option value="0" selected>Seleccione un estado</option>
			<c:forEach items="${requestScope.listaEstados}" var="estado">
				<option value="${estado.idEstado}" >${estado.desEstado}</option>
			</c:forEach>
		</select> </td>
	</tr>
							
	<tr>
		<td> Medio de respuesta </td><td>:</td>
		<td><select id="id_medio_respuesta" name="id_medio_respuesta" required>
			<option value="0" selected>Seleccione un medio de respuesta</option>
			<c:forEach items="${requestScope.listaMedios}" var="medio">
				<option value="${medio.idMedio}" >${medio.desMedio}</option>
			</c:forEach>
		</select> </td>
	</tr>

	<tr>
		<td> Fecha de ingreso </td><td>:</td><td><input type="text" 		id="fec_ingreso" 			name="fec_ingreso" 			placeholder="fec_ingreso" class="fecha" required> </td>
	</tr>
	<tr>
		<td> Adjunto </td><td>:</td><td><input type="text" 		id="adjunto" 				name="adjunto" 				placeholder="adjunto" required> </td>
	</tr>
	<tr>
		<td> Observaciones </td><td>:</td><td><input type="text" 		id="observaciones" 			name="observaciones" 		placeholder="observaciones" required> </td>
	</tr>
	<tr>
		<td> Responsable ingreso </td><td>:</td><td><input type="text" 		id="responsable_ingreso" 	name="responsable_ingreso" 	placeholder="responsable_ingreso" required>			 </td>
	</tr>
	<tr>
		<td> Responsable actual </td><td>:</td><td><input type="text" 		id="responsable_actual" 	name="responsable_actual" 	placeholder="responsable_actual" required>		 </td>
	</tr>
	<tr>
		<td> Fecha de respuesta </td><td>:</td><td><input type="text" 		id="fec_respuesta" 			name="fec_respuesta" 		placeholder="fec_respuesta" class="fecha" readonly required> </td>
	</tr>
	<tr>
		<td> Glosa </td><td>:</td><td><textarea rows="3" cols="50"	id="glosa"	name="glosa"	placeholder="glosa"	maxlength="2000" required> </textarea></td>
	</tr>
</table>
</form>

<div id="agregaArchivo" title="Crear Archivo" style="display:none"></div>
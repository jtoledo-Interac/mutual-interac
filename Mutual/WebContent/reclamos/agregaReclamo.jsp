<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>

<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	id="accion" 				name="accion" 					value="agregarReclamo">
	<input type="text" 		id="num_adherente" 			name="num_adherente"			placeholder="Nº Adherente">
	<input type="text" 		id="nombre_solicitante" 	name="nombre_solicitante"		placeholder="nombre_solicitante">
	<input type="text" 		id="email_solicitante" 		name="email_solicitante" 		placeholder="email_solicitante">
	<input type="text" 		id="fono_solicitante" 		name="fono_solicitante" 		placeholder="fono_solicitante">
	<input type="text" 		id="region_solicitante" 	name="region_solicitante" 		placeholder="region_solicitante">
	
	<select id="cod_tipo" name="cod_tipo">
		<option value="0" selected>Seleccione un tipo</option>
		<c:forEach items="${requestScope.listaTipos}" var="tipo">
			<option value="${tipo.codTipo}">${tipo.desTipo}</option>
		</c:forEach>
	</select> 	

	<select id="cod_motivo" name="cod_motivo">
		<option value="0" selected>Seleccione un motivo</option>
		<c:forEach items="${requestScope.listaMotivos}" var="motivo">
			<option value="${motivo.codMotivo}" >${motivo.desMotivo}</option>
		</c:forEach>
	</select>
	
	<select id="cod_prioridad" name="cod_prioridad">
		<option value="0" selected>Seleccione una prioridad</option>
		<c:forEach items="${requestScope.listaPrioridades}" var="prioridad">
			<option value="${prioridad.codPrioridad}" >${prioridad.desPrioridad}</option>
		</c:forEach>
	</select>

	<select id="cod_cartera" name="cod_cartera">
		<option value="0" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
		</c:forEach>
	</select> 
	
	<select id="cod_estado" name="cod_estado">
		<option value="0" selected>Seleccione un estado</option>
		<c:forEach items="${requestScope.listaEstados}" var="estado">
			<option value="${estado.codEstado}" >${estado.desEstado}</option>
		</c:forEach>
	</select> 
							
	<select id="cod_medio_respuesta" name="cod_medio_respuesta">
		<option value="0" selected>Seleccione un medio de respuesta</option>
		<c:forEach items="${requestScope.listaMedios}" var="medio">
			<option value="${medio.codMedio}" >${medio.desMedio}</option>
		</c:forEach>
	</select> 

	<input type="text" 		id="fec_ingreso" 			name="fec_ingreso" 			placeholder="fec_ingreso" class="fecha" readonly>
	<input type="text" 		id="glosa" 					name="glosa" 				placeholder="glosa">
	<input type="text" 		id="adjunto" 				name="adjunto" 				placeholder="adjunto">
	<input type="text" 		id="observaciones" 			name="observaciones" 		placeholder="observaciones">
	<input type="text" 		id="responsable_ingreso" 	name="responsable_ingreso" 	placeholder="responsable_ingreso">			
	<input type="text" 		id="responsable_actual" 	name="responsable_actual" 	placeholder="responsable_actual">		
	<input type="text" 		id="fec_respuesta" 			name="fec_respuesta" 		placeholder="fec_respuesta" class="fecha" readonly>
</form>
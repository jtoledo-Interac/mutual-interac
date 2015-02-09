<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  //$('select').select2();
</script>
<script>	
	function valida_numeros(e){
	    tecla = (document.all) ? e.keyCode : e.which;
	    //Tecla de retroceso para borrar, siempre la permite
	    if (tecla==9 || tecla==8){
	        return true;
	    }
	    // Patron de entrada, en este caso solo acepta numeros
	    patron =/[0-9]/;
	    tecla_final = String.fromCharCode(tecla);
	    return patron.test(tecla_final);
	}
	
	$(function() {
		setDatePicker();
		formatRut();
	});
</script>


<form id="formAgrega" action="Servlet" method="post">
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden"	id="accion" 				name="accion" 					value="agregarReclamo">
	<input type="text" 		id="num_adherente" 			name="num_adherente"			placeholder="Nº Adherente" onkeypress="return valida_numeros(event)" required>
	<input type="text" 		id="nombre_solicitante" 	name="nombre_solicitante"		placeholder="nombre_solicitante"  required>
	<input type="text" 		id="email_solicitante" 		name="email_solicitante" 		placeholder="email_solicitante"  required>
	<input type="text" 		id="fono_solicitante" 		name="fono_solicitante" 		placeholder="fono_solicitante" onkeypress="return valida_numeros(event)" required>
	<select id="cod_region"	name="cod_region"  required>
	<option value="0" selected>Seleccione una región </option>
	<c:forEach items="${requestScope.listaRegiones}" var="region">
		<option value="${region.codRegion}" >${region.desRegion}</option>
	</c:forEach>
	</select>	
	<select id="cod_tipo" name="cod_tipo" required>
		<option value="0" selected>Seleccione un tipo</option>
		<c:forEach items="${requestScope.listaTipos}" var="tipo">
			<option value="${tipo.codTipo}">${tipo.desTipo}</option>
		</c:forEach>
	</select> 	

	<select id="cod_motivo" name="cod_motivo" required>
		<option value="0" selected>Seleccione un motivo</option>
		<c:forEach items="${requestScope.listaMotivos}" var="motivo">
			<option value="${motivo.codMotivo}" >${motivo.desMotivo}</option>
		</c:forEach>
	</select>
	
	<select id="cod_prioridad" name="cod_prioridad" required>
		<option value="0" selected>Seleccione una prioridad</option>
		<c:forEach items="${requestScope.listaPrioridades}" var="prioridad">
			<option value="${prioridad.codPrioridad}" >${prioridad.desPrioridad}</option>
		</c:forEach>
	</select>

	<select id="cod_cartera" name="cod_cartera" required>
		<option value="0" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
		</c:forEach>
	</select> 
	
	<select id="cod_estado" name="cod_estado" required>
		<option value="0" selected>Seleccione un estado</option>
		<c:forEach items="${requestScope.listaEstados}" var="estado">
			<option value="${estado.codEstado}" >${estado.desEstado}</option>
		</c:forEach>
	</select> 
							
	<select id="cod_medio_respuesta" name="cod_medio_respuesta" required>
		<option value="0" selected>Seleccione un medio de respuesta</option>
		<c:forEach items="${requestScope.listaMedios}" var="medio">
			<option value="${medio.codMedio}" >${medio.desMedio}</option>
		</c:forEach>
	</select> 

	<input type="text" 		id="fec_ingreso" 			name="fec_ingreso" 			placeholder="fec_ingreso" class="fecha" required>
	<input type="text" 		id="glosa" 					name="glosa" 				placeholder="glosa" required>
	<input type="text" 		id="adjunto" 				name="adjunto" 				placeholder="adjunto" required>
	<input type="text" 		id="observaciones" 			name="observaciones" 		placeholder="observaciones" required>
	<input type="text" 		id="responsable_ingreso" 	name="responsable_ingreso" 	placeholder="responsable_ingreso" required>			
	<input type="text" 		id="responsable_actual" 	name="responsable_actual" 	placeholder="responsable_actual" required>		
	<input type="text" 		id="fec_respuesta" 			name="fec_respuesta" 		placeholder="fec_respuesta" class="fecha" readonly required>
</form>

<div id="agregaArchivo" title="Crear Archivo" style="display:none"></div>
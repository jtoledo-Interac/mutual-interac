<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

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

<form id="formEdita" action="Servlet" method="post" onSubmit="return validar_form(this)">
	<input type="submit" class="submit" style="display:none;">
	<input type="hidden"	id="accion" 				name="accion" 					value="modificarReclamo">
	<input type="hidden"	id="idReclamo"				name="idReclamo"				value="${reclamo.idReclamo }" >
	<input type="text" 		id="num_adherente" 			name="num_adherente"			placeholder="Nº Adherente" value="${reclamo.numAdherente}" onkeypress="return valida_numeros(event)" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="nombre_solicitante" 	name="nombre_solicitante"		placeholder="Nombre Solicitante" value="${reclamo.nombreSolicitante}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="email_solicitante" 		name="email_solicitante" 		placeholder="Email Solicitante" value="${reclamo.emailSolicitante}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="fono_solicitante" 		name="fono_solicitante" 		placeholder="Fono Solicitante" value="${reclamo.fonoSolicitante}" onkeypress="return valida_numeros(event)" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<select id="cod_region"	name="cod_region" >
	<option value="0" selected>Seleccione una región </option>
	<c:forEach items="${requestScope.listaRegiones}" var="region">
		<option value="${region.codRegion}" >${region.desRegion}</option>
	</c:forEach>
	</select>
	
	<select id="idCartera" name="idCartera" >
		<option value="" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.idCartera}" <c:if test='${documento.idCartera == cartera.idCartera}'> selected</c:if>>${cartera.desCartera}</option>
		</c:forEach>
	</select> 
	
	<select id="id_tipo" name="id_tipo">
		<option value="0" selected>Seleccione un tipo</option>
		<c:forEach items="${requestScope.listaTipos}" var="tipo">
			<option value="${tipo.idTipo}" <c:if test='${reclamo.idTipo == tipo.idTipo}'> selected</c:if>>${tipo.desTipo}</option>
		</c:forEach>
	</select> 	

	<select id="id_motivo" name="id_motivo" >
		<option value="0" selected>Seleccione un motivo</option>
		<c:forEach items="${requestScope.listaMotivos}" var="motivo">
			<option value="${motivo.idMotivo}" <c:if test='${reclamo.idMotivo == motivo.idMotivo}'> selected</c:if>>${motivo.desMotivo}</option>
		</c:forEach>
	</select>
	
	<select id="id_prioridad" name="id_prioridad" >
		<option value="0" selected>Seleccione una prioridad</option>
		<c:forEach items="${requestScope.listaPrioridades}" var="prioridad">
			<option value="${prioridad.idPrioridad}" <c:if test='${reclamo.idPrioridad == prioridad.idPrioridad}'> selected</c:if>>${prioridad.desPrioridad}</option>
		</c:forEach>
	</select>

	<select id="id_cartera" name="id_cartera">
		<option value="0" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.idCartera}" <c:if test='${reclamo.idCartera == cartera.idCartera}'> selected</c:if>>${cartera.desCartera}</option>
		</c:forEach>
	</select> 
	
	<select id="id_estado" name="id_estado">
		<option value="0" selected>Seleccione un estado</option>
		<c:forEach items="${requestScope.listaEstados}" var="estado">
			<option value="${estado.idEstado}" <c:if test='${reclamo.idEstado == estado.idEstado}'> selected</c:if>>${estado.desEstado}</option>
		</c:forEach>
	</select> 
							
	<select id="id_medio_respuesta" name="id_medio_respuesta" >
		<option value="0" selected>Seleccione un medio de respuesta</option>
		<c:forEach items="${requestScope.listaMedios}" var="medio">
			<option value="${medio.idMedio}" <c:if test='${reclamo.idMedio == medio.idMedio}'> selected</c:if>>${medio.desMedio}</option>
		</c:forEach>
	</select> 

	<input type="text" 		id="fec_ingreso" 			name="fec_ingreso" 			placeholder="Fecha Ingreso" class="fecha" value="${reclamo.fecIngreso}" readonly onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="glosa" 					name="glosa" 				placeholder="Glosa" value="${reclamo.glosa}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="adjunto" 				name="adjunto" 				placeholder="Adjunto" value="${reclamo.adjunto}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="observaciones" 			name="observaciones" 		placeholder="Observaciones" value="${reclamo.observaciones}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="responsable_ingreso" 	name="responsable_ingreso" 	placeholder="Responsable Ingreso" value="${reclamo.responsableIngreso}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">			
	<input type="text" 		id="responsable_actual" 	name="responsable_actual" 	placeholder="Responsable Actual" value="${reclamo.responsableActual}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">		
	<input type="text" 		id="fec_respuesta" 			name="fec_respuesta" 		placeholder="Feha Respuesta" class="fecha" value="${reclamo.fecRespuesta}" readonly onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
</form>
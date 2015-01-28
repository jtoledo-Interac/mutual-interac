<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>


<script>
	function validar_form(f){
		var ok = true;
		var msg = "Debe ingresar todos los campos.";
		for (i = 0; i < f.elements.length; i++) { 
			switch(f.elements[i].type){
			case "text":
				if(f.elements[i].value.length==0){
					f.elements[i].style.bordeColor= "#FF0000";
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			case "password":
				if(f.elements[i].value.length==0){
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			case "select-one":
				if(f.elements[i].selectedIndex<=0){
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			case "file":
				if(f.elements[i].value.length==0){
					f.elements[i].style.boxShadow = " 0 0 10px #FF0000";
					ok = false;
				}
				break;
			default:
				break;
			}
		}
		if(!ok){
			alert(msg);
		}
		return ok;
	}
	
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
	<input type="hidden"	id="accion" 				name="accion" 					value="modificarReclamo">
	<input type="hidden"	id="idReclamo"				name="idReclamo"				value="${reclamo.idReclamo }" >
	<input type="text" 		id="num_adherente" 			name="num_adherente"			placeholder="Nº Adherente" value="${reclamo.numAdherente}" onkeypress="return valida_numeros(event)" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="nombre_solicitante" 	name="nombre_solicitante"		placeholder="Nombre Solicitante" value="${reclamo.nombreSolicitante}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="email_solicitante" 		name="email_solicitante" 		placeholder="Email Solicitante" value="${reclamo.emailSolicitante}" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<input type="text" 		id="fono_solicitante" 		name="fono_solicitante" 		placeholder="Fono Solicitante" value="${reclamo.fonoSolicitante}" onkeypress="return valida_numeros(event)" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<select id="cod_region"	name="cod_region" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
	<option value="0" selected>Seleccione una región </option>
	<c:forEach items="${requestScope.listaRegiones}" var="region">
		<option value="${region.codRegion}" >${region.desRegion}</option>
	</c:forEach>
	</select>
	
	<select id="codCartera" name="codCartera" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" <c:if test='${documento.codCartera == cartera.codCartera}'> selected</c:if>>${cartera.desCartera}</option>
		</c:forEach>
	</select> 
	
	<select id="cod_tipo" name="cod_tipo" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione un tipo</option>
		<c:forEach items="${requestScope.listaTipos}" var="tipo">
			<option value="${tipo.codTipo}" <c:if test='${reclamo.codTipo == tipo.codTipo}'> selected</c:if>>${tipo.desTipo}</option>
		</c:forEach>
	</select> 	

	<select id="cod_motivo" name="cod_motivo" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione un motivo</option>
		<c:forEach items="${requestScope.listaMotivos}" var="motivo">
			<option value="${motivo.codMotivo}" <c:if test='${reclamo.codMotivo == motivo.codMotivo}'> selected</c:if>>${motivo.desMotivo}</option>
		</c:forEach>
	</select>
	
	<select id="cod_prioridad" name="cod_prioridad" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione una prioridad</option>
		<c:forEach items="${requestScope.listaPrioridades}" var="prioridad">
			<option value="${prioridad.codPrioridad}" <c:if test='${reclamo.codPrioridad == prioridad.codPrioridad}'> selected</c:if>>${prioridad.desPrioridad}</option>
		</c:forEach>
	</select>

	<select id="cod_cartera" name="cod_cartera" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione una cartera</option>
		<c:forEach items="${requestScope.listaCarteras}" var="cartera">
			<option value="${cartera.codCartera}" <c:if test='${reclamo.codCartera == cartera.codCartera}'> selected</c:if>>${cartera.desCartera}</option>
		</c:forEach>
	</select> 
	
	<select id="cod_estado" name="cod_estado" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione un estado</option>
		<c:forEach items="${requestScope.listaEstados}" var="estado">
			<option value="${estado.codEstado}" <c:if test='${reclamo.codEstado == estado.codEstado}'> selected</c:if>>${estado.desEstado}</option>
		</c:forEach>
	</select> 
							
	<select id="cod_medio_respuesta" name="cod_medio_respuesta" onfocus="this.style.boxShadow='0 0 10px #9ecaed'" onblur="this.style.boxShadow='none'">
		<option value="0" selected>Seleccione un medio de respuesta</option>
		<c:forEach items="${requestScope.listaMedios}" var="medio">
			<option value="${medio.codMedio}" <c:if test='${reclamo.codMedio == medio.codMedio}'> selected</c:if>>${medio.desMedio}</option>
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
<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

	var idReclamo;
	var idFila = 0;
	var numFilas = 20;
	
	$(function() {

		$('#listadoReclamos').jqGrid(
		{
			
		   	url: getUrlBuscarReclamos(),
		   	
			datatype: "xml",			
			colNames : ['', 'Nº Adherente','Nombre Solicitante','Tipo','Motivo', 'Medio Respuesta', 'Estado', 'Prioridad','Dias Sistema','Dias Bandeja',''],
			colModel : [
						{name : 'idReclamo', index:'idReclamo', hidden : true},
						{name : 'numAdherente', index:'numAdherente', width : 80, search : true, resizable : false, sortable : true},
						{name : 'nombreSolicitante', index:'nombreSolicitante', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'desTipo', index:'desTipo', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'desMotivo', index:'desMotivo', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'desMedio', index:'desMedio', width : 80, search : true, resizable : false, sortable : true},
						{name : 'desEstado', index:'desEstado', width : 80, search : true, resizable : false, sortable : true},
						{name : 'desPrioridad', index:'desPrioridad', width : 80, search : true, resizable : false, sortable : true},
						{name : 'diasSistema', index:'diasSistema', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'diasBandeja', index:'diasBandeja', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'act',index:'act', width : 30, resizable:false,sortable : true}
						],		
		   	rowNum:20,
		   	height: 450,
		   	autowidth: true,
		   	rowList:[10,20,30],
			xmlReader: {
				root : "filas",
				row: "fila",
				repeatitems: false,
				id: "idReclamo"
			},
		   	pager: $('#pieReclamo'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'codReclamo',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Reclamos",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoReclamos").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					var idFila = ids[i];

					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarReclamo("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarReclamo("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoReclamos").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoReclamos').jqGrid('getRowData',idFila);
				editarReclamo(fila.idReclamo);
			},
		}).navGrid('#pieReclamo',{edit:false,add:false,del:false});	

		formatRut();
		
		$('#btnBuscar').click(function()
		{
			buscarReclamos();
		});

		$('#btnAgregar').click(function()
		{
		    crearReclamo();
		});
		
		$('#agregaReclamo').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Reclamo": function() {
					$('#formAgrega .submit').click();
				},
				"Cancelar": function() {
					$(this).dialog("close");
			    }
		    },
			close: function() {
				$('#formAgrega input').val(''); //limpia Data
			}
		});
		
		$('#cargaReclamo').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Reclamo": function() {
					$('#formEdita').submit();
				},
				"Cancelar": function() {
					$(this).dialog("close");
			    }
		    },
			close: function() {
				$('#formEdita input').val(''); //limpia Data
			}
		});
	});
	
	function validarSeleccionado(idGrilla)
	{
		var retorno = true;
		var idSeleccionado = $('#'+idGrilla).jqGrid('getGridParam', 'selrow');
		
		if(idSeleccionado == null)
			retorno = false;
		
		return retorno;
	}
	
	function crearReclamo()
	{
		ajaxCall(getUrlCrearReclamo(), function(response){
			$('#agregaReclamo').html(response).dialog('open');
		});
	}
	
	function editarReclamo(idReclamo)
	{
		ajaxCall(getUrlCargarReclamo(idReclamo), function(response){
			$('#cargaReclamo').html(response).dialog('open');
		});
	}
	
	function eliminarReclamo(idReclamo)
	{  
   		jConfirm('¿ Confirma eliminar el Reclamo ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarReclamo(idReclamo), function(){
  					jAlert("El Reclamo ha sido eliminada exitosamente");
  					buscarReclamos();
   				});
   			}
   		});
	}
	
	function buscarReclamos() 
	{		
		$('#listadoReclamos').jqGrid('setGridParam', {
			url : getUrlBuscarReclamos(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarReclamos()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarReclamos";
		sData += "&nombre_solicitante="+$('#nombre_solicitante').val();
		sData += "&id_reclamo="+$('#id_reclamo').val();
		sData += "&num_adherente="+$('#num_adherente').val();
		sData += "&codCartera="+$('#codCartera').val();
		sData += "&codTipo="+$('#codTipo').val();
		sData += "&codEstado="+$('#codEstado').val();
		sData += "&codPrioridad="+$('#codPrioridad').val();
		
		return sData;
	}

	function getUrlCrearReclamo()
	{
		var sData = "Servlet";
		sData += '?accion=crearReclamo';
		return sData;
	}
	
	function getUrlCargarReclamo(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarReclamo';
		sData += '&idReclamo='+id;
		return sData;
	}

	function getUrlEliminarReclamo(idReclamo){  
		var sData = 'Servlet';
		sData += '?accion=eliminarReclamo';
		sData += '&idReclamo='+idReclamo;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaReclamo" title="Crear Reclamo" style="display:none"></div>
	
	<div id="cargaReclamo" title="Editar Reclamo" style="display:none"></div>

	<div class="filtros">		
		<form id="formReclamo" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="id_reclamo" 	name="id_reclamo"		placeholder="ID Reclamo" class="text" >
			<input type="text" 		id="nombre_solicitante"  name="nombre_solicitante"		placeholder="Nombre Solicitante" class="text">
			<input type="text" 		id="num_adherente" 	name="num_adherente" 	placeholder="Nº Adherente" class="text">
						
			<select id="codCartera" name="codCartera" class="select">
				<option value="" selected>Seleccione una cartera</option>
				<c:forEach items="${requestScope.listaCarteras}" var="cartera">
					<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
				</c:forEach>
			</select> 
			<select id="codTipo" name="codTipo" class="select">
				<option value="" selected>Seleccione un tipo</option>
				<c:forEach items="${requestScope.listaTipos}" var="tipo">
					<option value="${tipo.codTipo}" >${tipo.desTipo}</option>
				</c:forEach>
			</select>
			
			<select id="codEstado" name="codEstado" class="select">
				<option value="" selected>Seleccione un estado</option>
				<c:forEach items="${requestScope.listaEstados}" var="estado">
					<option value="${estado.codEstado}" >${estado.desEstado}</option>
				</c:forEach>
			</select>
			
			<select id="codPrioridad" name="codPrioridad" class="select">
				<option value="" selected>Seleccione una prioridad</option>
				<c:forEach items="${requestScope.listaPrioridades}" var="prioridad">
					<option value="${prioridad.codPrioridad}">${prioridad.desPrioridad}</option>
				</c:forEach>
			</select>
		</form>
	</div> 

	<div id="listadoBusquedaReclamos" class="listado">
		<table id="listadoReclamos"></table>
		<div id="pieReclamo" class="pie"></div>
	</div>
</div>
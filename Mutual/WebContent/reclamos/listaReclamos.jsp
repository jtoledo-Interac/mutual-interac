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
			colNames : ['', 'Nº Adherente','Nº Folio','Nombre Reclamo','Cartera', 'Tipo Producto', 'Area', 'Fecha Creación',''],
			colModel : [
						{name : 'idReclamo', index:'idReclamo', hidden : true},
						{name : 'numAdherente', index:'numAdherente', width : 80, search : true, resizable : false, sortable : true},
						{name : 'numFolio', index:'numFolio', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'nombre', index:'nombre', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'desCartera', index:'desCartera', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'desProducto', index:'desProducto', width : 80, search : true, resizable : false, sortable : true},
						{name : 'desArea', index:'desArea', width : 80, search : true, resizable : false, sortable : true},
						{name : 'fecCreacion', index:'fecCreacion', width : 80, search : true, resizable : false, sortable : true},				
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
					$('#formAgrega').submit();
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
		sData += "&nombre="+$('#nombre').val();
		sData += "&numFolio="+$('#numFolio').val();
		sData += "&numAdherente="+$('#numAdherente').val();
		sData += "&codCartera="+$('#codCartera').val();
		sData += "&codProducto="+$('#codProducto').val();
		sData += "&codArea="+$('#codArea').val();
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

	function getUrlEliminarReclamo(nIdReclamo){  
		var sData = 'Servlet';
		sData += '?accion=eliminarReclamo';
		sData += '&nIdReclamo='+nIdReclamo;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaReclamo" title="Crear Reclamo" style="display:none"></div>
	
	<div id="cargaReclamo" title="Editar Reclamo" style="display:none"></div>

	<div class="filtros">		
		<form id="formReclamo" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar"/>
			<input type="text" 		id="nombre" 		name="nombre"		placeholder="Nombre Reclamo">
			<input type="text" 		id="numFolio" 		name="numFolio"		placeholder="Nº Folio">
			<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente">
						
			<select id="codCartera" name="codCartera">
				<option value="0" selected>Seleccione una cartera</option>
				<c:forEach items="${requestScope.listaCarteras}" var="cartera">
					<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
				</c:forEach>
			</select> 
			
			<select id="codProducto" name="codProducto">
				<option value="0" selected>Seleccione un producto</option>
				<c:forEach items="${requestScope.listaProductos}" var="producto">
					<option value="${producto.codProducto}" >${producto.desProducto}</option>
				</c:forEach>
			</select>
			
			<select id="codArea" name="codArea">
				<option value="0" selected>Seleccione un área</option>
				<c:forEach items="${requestScope.listaAreas}" var="area">
					<option value="${area.codArea}" >${area.desArea}</option>
				</c:forEach>
			</select>
		</form>
	</div> 

	<div id="listadoBusquedaReclamos" class="listado">
		<table id="listadoReclamos"></table>
		<div id="pieReclamo" class="pie"></div>
	</div>
</div>
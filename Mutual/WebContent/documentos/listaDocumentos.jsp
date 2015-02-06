<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

	var idDocumento;
	var idFila = 0;
	var numFilas = 20;
	
	$(function() {

		$('#listadoDocumentos').jqGrid(
		{
		   	url: getUrlBuscarDocumentos(),
			datatype: "xml",			
			colNames : ['', 'Nº Adherente','Nº Folio','Nombre Documento','Cartera', 'Tipo Producto', 'Area', 'Fecha Creación',''],
			colModel : [
						{name : 'idDocumento', index:'idDocumento', hidden : true},
						{name : 'numAdherente', index:'numAdherente', width : 80, search : true, resizable : false, sortable : true},
						{name : 'numFolio', index:'numFolio', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'nombre', index:'nombre', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'desCartera', index:'desCartera', width : 80, search : true, resizable : false, sortable : true},	
						{name : 'desProducto', index:'desProducto', width : 80, search : true, resizable : false, sortable : true},
						{name : 'desArea', index:'desArea', width : 80, search : true, resizable : false, sortable : true},
						{name : 'fecCreacion', index:'fecCreacion', width : 80, search : true, resizable : false, sortable : true},				
						{name : 'act',index:'act', width : 30, resizable:false,sortable : true}
						],		
		   	rowNum: numeroDeFilas,
		   	height: altoGrilla,
		   	width: anchoGrilla,
		   	rowList:[10,20,30],
			xmlReader: {
				root : "filas",
				row: "fila",
				repeatitems: false,
				id: "idDocumento"
			},
		   	pager: $('#pieDocumento'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'codDocumento',
		   	loadonce:true,
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Documentos",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoDocumentos").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					var idFila = ids[i];

					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarDocumento("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarDocumento("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoDocumentos").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoDocumentos').jqGrid('getRowData',idFila);
				editarDocumento(fila.idDocumento);
			},
		}).navGrid('#pieDocumento',{edit:false,add:false,del:false});	

		formatRut();
		
		$('#btnBuscar').click(function()
		{
			buscarDocumentos();
		});

		$('#btnAgregar').click(function()
		{
		    crearDocumento();
		});
		
		$('#agregaDocumento').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Documento": function() {
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
		
		$('#cargaDocumento').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Documento": function() {
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
	
	function crearDocumento()
	{
		ajaxCall(getUrlCrearDocumento(), function(response){
			$('#agregaDocumento').html(response).dialog('open');
		});
	}
	
	function editarDocumento(idDocumento)
	{
		ajaxCall(getUrlCargarDocumento(idDocumento), function(response){
			$('#cargaDocumento').html(response).dialog('open');
		});
	}
	
	function eliminarDocumento(idDocumento)
	{  
   		jConfirm('¿Confirma eliminar el Documento?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarDocumento(idDocumento), function(){
  					jAlert("El Documento ha sido eliminada exitosamente");
  					buscarDocumentos();
   				});
   			}
   		});
	}
	
	function buscarDocumentos() 
	{		
		$('#listadoDocumentos').jqGrid('setGridParam', {
			url : getUrlBuscarDocumentos(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarDocumentos()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarDocumentos";
		sData += "&nombre="+$('#nombre').val();
		sData += "&numFolio="+$('#numFolio').val();
		sData += "&numAdherente="+$('#numAdherente').val();
		sData += "&codCartera="+$('#codCartera').val();
		sData += "&codProducto="+$('#codProducto').val();
		sData += "&codArea="+$('#codArea').val();
		return sData;
	}

	function getUrlCrearDocumento()
	{
		var sData = "Servlet";
		sData += '?accion=crearDocumento';
		return sData;
	}
	
	function getUrlCargarDocumento(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarDocumento';
		sData += '&idDocumento='+id;
		return sData;
	}

	function getUrlEliminarDocumento(nIdDocumento){  
		var sData = 'Servlet';
		sData += '?accion=eliminarDocumento';
		sData += '&idDocumento='+nIdDocumento;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaDocumento" title="Crear Documento" style="display:none"></div>
	
	<div id="cargaDocumento" title="Editar Documento" style="display:none"></div>

	<div class="filtros">		
		<form id="formDocumento" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	class="boton" value="Buscar"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	class="boton" value="Agregar"/>
			<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" class="text">
			<input type="text" 		id="numFolio" 		name="numFolio"		placeholder="Nº Folio" class="text">
			<input type="text" 		id="nombre" 		name="nombre"		placeholder="Nombre Documento" class="text">
			
			
						
			<select id="codCartera" name="codCartera" class="select" >
				<option value="" selected>Seleccione una cartera </option>
				<c:forEach items="${requestScope.listaCarteras}" var="cartera">
					<option value="${cartera.codCartera}" >${cartera.desCartera}</option>
				</c:forEach>
			</select> 
			
			<select id="codProducto" name="codProducto" class="select">
				<option value="" selected>Seleccione un producto</option>
				<c:forEach items="${requestScope.listaProductos}" var="producto">
					<option value="${producto.codProducto}" >${producto.desProducto}</option>
				</c:forEach>
			</select>
			
			<select id="codArea" name="codArea" class="select">
				<option value="" selected>Seleccione un área</option>
				<c:forEach items="${requestScope.listaAreas}" var="area">
					<option value="${area.codArea}" >${area.desArea}</option>
				</c:forEach>
			</select>
		</form>
	</div> 

	<div id="listadoBusquedaDocumentos" class="listado">
		<table id="listadoDocumentos"></table>
		<div id="pieDocumento" class="pie"></div>
	</div>
</div>
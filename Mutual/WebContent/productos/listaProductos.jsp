<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  $('select').select2();
</script>
<script type="text/javascript"> 
	var idProducto;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoProductos').jqGrid(
		{
		   	url: getUrlBuscarProductos(),
			datatype: "xml",
			colNames : ['', 'Tipo Documento',''],
			colModel : [			            
						{name : 'idProducto', index:'idProducto', hidden : true}, 
						{name : 'desProducto', index:'desProducto', width : 80, search : true, resizable : false, sortable : true},				
						{name : 'act',index:'act', width : 30, resizable:false,sortable : true}
						],
		   	rowNum: numeroDeFilas,
		   	height: altoGrilla,
		   	width: anchoGrilla,
		   	rowList:[10,20,30],
			xmlReader: {
				root : "filas",
				row	: "fila",
				repeatitems: false,
				id: "idProducto"
			},
		   	pager: $('#pieProducto'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'idProducto',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Tipos de Documentos",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){
				
			},
			gridComplete: function()
			{
				var ids = $("#listadoProductos").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					
					var idFila = ids[i];
					console.log("IDFILA: "+idFila);
					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarProducto("+ids[i]+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarProducto("+ids[i]+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoProductos").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
				console.log("[onSelectRow] idFila: "+idFila);
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoProductos').jqGrid('getRowData',idFila);
				editarProducto(fila.idProducto);
			},
		}).navGrid('#pieProducto',{edit:false,add:false,del:false});	
		
		$('#btnBuscar').click(function()
		{
			buscarProductos();
		});

		$('#btnAgregar').click(function()
		{
		    crearProducto();
		});
		
		$('#agregaProducto').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Producto": function() {
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
		
		$('#cargaProducto').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Producto": function() {
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
	});
	
	function validarSeleccionado(idGrilla)
	{
		var retorno = true;
		var idSeleccionado = $('#'+idGrilla).jqGrid('getGridParam', 'selrow');
		
		if(idSeleccionado == null)
			retorno = false;
		
		return retorno;
	}
	
	function crearProducto()
	{
		ajaxCall(getUrlCrearProducto(), function(response){
			$('#agregaProducto').html(response).dialog('open');
		});
	}
	
	function editarProducto(idProducto)
	{
		console.log(idProducto);
		ajaxCall(getUrlCargarProducto(idProducto), function(response){
			$('#cargaProducto').html(response).dialog('open');
		});
	}
	
	function eliminarProducto(idProducto)
	{  
   		jConfirm('¿ Confirma eliminar el Tipo de Documento ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarProducto(idProducto), function(){
  					jAlert("El Producto ha sido eliminado exitosamente");
  					buscarProductos();
   				});
   			}
   		});
	}
	
	function buscarProductos() 
	{		
		$('#listadoProductos').jqGrid('setGridParam', {
			url : getUrlBuscarProductos(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarProductos()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarProductos";
		sData += "&nomProducto="+$('#nomProducto').val();
		return sData;
	}

	function getUrlCrearProducto()
	{
		var sData = "Servlet";
		sData += '?accion=crearProducto';
		return sData;
	}
	
	function getUrlCargarProducto(id)
	{
		console.log("[getUrlCargarProducto] id: "+id);
		var sData = "Servlet";
		sData += '?accion=cargarProducto';
		sData += '&idProducto='+id;
		console.log("[editarProducto] "+sData);
		return sData;
	}

	function getUrlEliminarProducto(id){  
		var sData = 'Servlet';
		sData += '?accion=eliminarProducto';
		sData += '&idProducto='+id;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaProducto" title="Crear Producto" style="display:none"></div>
	
	<div id="cargaProducto" title="Editar Producto" style="display:none"></div>

	<div class="filtros">		
		<form id="formProducto" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="nomProducto" 	name="nomProducto"	placeholder="Tipo Documento"class="text">
		</form>
	</div> 

	<div id="listadoBusquedaProductos" class="listado">
		<table id="listadoProductos"></table>
		<div id="pieProducto" class="pie"></div>
	</div>
</div>
<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  //$('select').select2();
</script>
<script type="text/javascript"> 

	var idCategoriaLink;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoCategorias').jqGrid(
		{
		   	url: getUrlBuscarCategorias(),
			datatype: "xml",
			colNames : ['', 'Nombre Categoria',''],
			colModel : [
						{name : 'idCategoriaLink', index:'idCategoriaLink', hidden : true}, 
						{name : 'desCategoriaLink', index:'desCategoriaLink', width : 80, search : true, resizable : false, sortable : true},				
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
				id: "idCategoriaLink"
			},
		   	pager: $('#pieCategorias'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'idCategoriaLink',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Categorias de links de interés",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoCategorias").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					
					var idFila = ids[i];
					console.log("IDFILA: "+idFila);
					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarCategoria("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarCategoria("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoCategorias").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
				console.log("Paso aca: "+idFila);
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoCategorias').jqGrid('getRowData',idFila);
				//editarProducto(fila.codProducto);
			},
		}).navGrid('#pieCategoria',{edit:false,add:false,del:false});	
		
		$('#btnBuscar').click(function()
		{
			buscarCategorias();
		});

		$('#btnAgregar').click(function()
		{
		    crearCategoria();
		});
		
		$('#agregaCategoria').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Categoria": function() {
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
		
		$('#cargaCategoria').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Categoria": function() {
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
	
	function crearCategoria()
	{
		ajaxCall(getUrlCrearCategoria(), function(response){
			$('#agregaCategoria').html(response).dialog('open');
		});
	}
	
	function editarCategoria(idCategoriaLink)
	{
		console.log("Categoria: "+idCategoriaLink);
		
		ajaxCall(getUrlCargarCategoria(idCategoriaLink), function(response){
			$('#cargaCategoria').html(response).dialog('open');
		});
	}
	
	function eliminarCategoria(idCategoriaLink)
	{  
   		jConfirm('¿ Confirma eliminar la Categoria ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarCategoria(idCategoriaLink), function(){
  					jAlert("El Categoria ha sido eliminado exitosamente");
  					buscarCategorias();
   				});
   			}
   		});
	}
	
	function buscarCategorias() 
	{		
		$('#listadoCategorias').jqGrid('setGridParam', {
			url : getUrlBuscarCategorias(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarCategorias()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarCategorias";
		sData += "&nomCategoria="+$('#nomCategoria').val();
		return sData;
	}

	function getUrlCrearCategoria()
	{
		var sData = "Servlet";
		sData += '?accion=crearCategoriaLink';
		return sData;
	}
	
	function getUrlCargarCategoria(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarCategoriaLink';
		sData += '&idCategoriaLink='+id;
		console.log(sData);
		return sData;
	}

	function getUrlEliminarCategoria(id){  
		var sData = 'Servlet';
		sData += '?accion=eliminarCategoriaLink';
		sData += '&idCategoriaLink='+id;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaCategoria" title="Crear Categoria" style="display:none"></div>
	
	<div id="cargaCategoria" title="Editar Categoria" style="display:none"></div>

	<div class="filtros">		
		<form id="formCategoria" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="nomCategoria" 	name="nomCategoria"	placeholder="Nombre Categoria" class="text">
		</form>
	</div> 

	<div id="listadoBusquedaCategorias" class="listado">
		<table id="listadoCategorias"></table>
		<div id="pieCategoria" class="pie"></div>
	</div>
</div>
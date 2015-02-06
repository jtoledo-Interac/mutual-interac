<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

	var codPrioridad;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoPrioridades').jqGrid(
		{
		   	url: getUrlBuscarPrioridades(),
			datatype: "xml",
			colNames : ['', 'Nombre Prioridad',''],
			colModel : [
						{name : 'codPrioridad', index:'codPrioridad', hidden : true}, 
						{name : 'desPrioridad', index:'desPrioridad', width : 80, search : true, resizable : false, sortable : true},				
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
				id: "codPrioridad"
			},
		   	pager: $('#piePrioridades'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'codPrioridades',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Prioridades",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoPrioridades").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					var idFila = ids[i];
					console.log("IDFILA: "+idFila);
					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarPrioridad("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarPrioridad("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoPrioridades").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
				console.log("Paso aca: "+idFila);
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoPrioridades').jqGrid('getRowData',idFila);
			},
		}).navGrid('#piePrioridad',{edit:false,add:false,del:false});	
		
		$('#btnBuscar').click(function()
		{
			buscarPrioridades();
		});

		$('#btnAgregar').click(function()
		{
		    crearPrioridad();
		});
		
		$('#agregaPrioridad').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Prioridad": function() {
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
		
		$('#cargaPrioridad').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Prioridad": function() {
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
	
	function crearPrioridad()
	{
		ajaxCall(getUrlCrearPrioridad(), function(response){
			$('#agregaPrioridad').html(response).dialog('open');
		});
	}
	
	function editarPrioridad(codPrioridad)
	{
		console.log("Prioridad: "+codPrioridad);
		
		ajaxCall(getUrlCargarPrioridad(codPrioridad), function(response){
			$('#cargaPrioridad').html(response).dialog('open');
		});
	}
	
	function eliminarPrioridad(codPrioridad)
	{  
   		jConfirm('¿ Confirma eliminar la Prioridad ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarPrioridad(codPrioridad), function(){
  					jAlert("El Tipo ha sido eliminado exitosamente");
  					buscarPrioridades();
   				});
   			}
   		});
	}
	
	function buscarPrioridades() 
	{		
		$('#listadoTipos').jqGrid('setGridParam', {
			url : getUrlBuscarPrioridades(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarPrioridades()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarPrioridades";
		sData += "&nomPrioridad="+$('#nomPrioridad').val();
		return sData;
	}

	function getUrlCrearPrioridad()
	{
		var sData = "Servlet";
		sData += '?accion=crearPrioridad';
		return sData;
	}
	
	function getUrlCargarPrioridad(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarPrioridad';
		sData += '&codPrioridad='+id;
		console.log(sData);
		return sData;
	}

	function getUrlEliminarPrioridad(id){  
		var sData = 'Servlet';
		sData += '?accion=eliminarPrioridad';
		sData += '&codPrioridad='+id;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaPrioridad" title="Crear Prioridad" style="display:none"></div>
	
	<div id="cargaPrioridad" title="Editar Prioridad" style="display:none"></div>

	<div class="filtros">		
		<form id="formPrioridad" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="nomPrioridad" 	name="nomPrioridad"	placeholder="Nombre Prioridad" class="text">
		</form>
	</div> 

	<div id="listadoBusquedaPrioridades" class="listado">
		<table id="listadoPrioridades"></table>
		<div id="piePrioridad" class="pie"></div>
	</div>
</div>
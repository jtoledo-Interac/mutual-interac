<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

	var idCartera;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoCarteras').jqGrid(
		{
		   	url: getUrlBuscarCarteras(),
			datatype: "xml",
			colNames : ['', 'Nombre Cartera',''],
			colModel : [
						{name : 'idCartera', index:'idCartera', hidden : true}, 
						{name : 'desCartera', index:'desCartera', width : 80, search : true, resizable : false, sortable : true},				
						{name : 'act',index:'act', width : 30, resizable:false,sortable : true}
						],
		   	rowNum:10,
		   	autowidth: true,
		   	rowList:[10,20,30],
			xmlReader: {
				root : "filas",
				row: "fila",
				repeatitems: false,
				id: "idCartera"
			},
		   	pager: $('#pieCartera'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'idCartera',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Carteras",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoCarteras").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					var idFila = ids[i];

					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarCartera("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarCartera("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoCarteras").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoCarteras').jqGrid('getRowData',idFila);
				editarCartera(fila.idCartera);
			},
		}).navGrid('#pieCartera',{edit:false,add:false,del:false});	

		formatRut();
		
		$('#btnBuscar').click(function()
		{
			buscarCarteras();
		});
	

		$('#btnAgregar').click(function()
		{
		    crearCartera();
		});
		
		$('#agregaCartera').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Cartera": function() {
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
		
		$('#cargaCartera').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Cartera": function() {
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
	
	function crearCartera()
	{
		ajaxCall(getUrlCrearCartera(), function(response){
			$('#agregaCartera').html(response).dialog('open');
		});
	}
	
	function editarCartera(idCartera)
	{
		ajaxCall(getUrlCargarCartera(idCartera), function(response){
			$('#cargaCartera').html(response).dialog('open');
		});
	}
	
	function eliminarCartera(idCartera)
	{  
   		jConfirm('¿ Confirma eliminar la Cartera ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarCartera(idCartera), function(){
  					jAlert("La Cartera ha sido eliminada exitosamente");
  					buscarCarteras();
   				});
   			}
   		});
	}
	
	function buscarCarteras() 
	{		
		$('#listadoCarteras').jqGrid('setGridParam', {
			url : getUrlBuscarCarteras(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarCarteras()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarCarteras";
		sData += "&nomCartera="+$('#nomCartera').val();
		return sData;
	}

	function getUrlCrearCartera()
	{
		var sData = "Servlet";
		sData += '?accion=crearCartera';
		return sData;
	}
	
	function getUrlCargarCartera(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarCartera';
		sData += '&idCartera='+id;
		return sData;
	}

	function getUrlEliminarCartera(id){  
		var sData = 'Servlet';
		sData += '?accion=eliminarCartera';
		sData += '&idCartera='+id;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaCartera" title="Crear Cartera" style="display:none"></div>
	
	<div id="cargaCartera" title="Editar Cartera" style="display:none"></div>

	<div class="filtros">		
		<form id="formCartera" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="nomCartera" 	name="nomCartera"	placeholder="Nombre Cartera" class="text">
		</form>
	</div> 

	<div id="listadoBusquedaCarteras" class="listado">
		<table id="listadoCarteras"></table>
		<div id="pieCartera" class="pie"></div>
	</div>
</div>
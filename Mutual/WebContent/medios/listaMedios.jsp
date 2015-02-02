<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

	var codMedio;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoMedios').jqGrid(
		{
		   	url: getUrlBuscarMedios(),
			datatype: "xml",
			colNames : ['', 'Nombre Medio',''],
			colModel : [
						{name : 'codMedio', index:'codMedio', hidden : true}, 
						{name : 'desMedio', index:'desMedio', width : 80, search : true, resizable : false, sortable : true},				
						{name : 'act',index:'act', width : 30, resizable:false,sortable : true}
						],
		   	rowNum:10,
		   	autowidth: true,
		   	rowList:[10,20,30],
			xmlReader: {
				root : "filas",
				row: "fila",
				repeatitems: false,
				id: "codMedio"
			},
		   	pager: $('#pieMedio'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'codMedio',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Medios",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoMedios").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					
					var idFila = ids[i];
					console.log("IDFILA: "+idFila);
					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarMedio("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarMedio("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoMedios").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
				console.log("Paso aca: "+idFila);
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoMedios').jqGrid('getRowData',idFila);
				//editarProducto(fila.codProducto);
			},
		}).navGrid('#pieMedio',{edit:false,add:false,del:false});	
		
		$('#btnBuscar').click(function()
		{
			buscarMedios();
		});

		$('#btnAgregar').click(function()
		{
		    crearMedio();
		});
		
		$('#agregaMedio').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Medio": function() {
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
		
		$('#cargaMedio').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Medio": function() {
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
	
	function crearMedio()
	{
		ajaxCall(getUrlCrearMedio(), function(response){
			$('#agregaMedio').html(response).dialog('open');
		});
	}
	
	function editarMedio(codMedio)
	{
		console.log("Medio: "+codMedio);
		
		ajaxCall(getUrlCargarMedio(codMedio), function(response){
			$('#cargaMedio').html(response).dialog('open');
		});
	}
	
	function eliminarMedio(codMedio)
	{  
   		jConfirm('¿ Confirma eliminar el Medio ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarMedio(codMedio), function(){
  					jAlert("El Medio ha sido eliminado exitosamente");
  					buscarMedios();
   				});
   			}
   		});
	}
	
	function buscarMedios() 
	{		
		$('#listadoMedios').jqGrid('setGridParam', {
			url : getUrlBuscarMedios(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarMedios()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarMedios";
		sData += "&nomMedio="+$('#nomMedio').val();
		return sData;
	}

	function getUrlCrearMedio()
	{
		var sData = "Servlet";
		sData += '?accion=crearMedio';
		return sData;
	}
	
	function getUrlCargarMedio(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarMedio';
		sData += '&codMedio='+id;
		console.log(sData);
		return sData;
	}

	function getUrlEliminarMedio(id){  
		var sData = 'Servlet';
		sData += '?accion=eliminarMedio';
		sData += '&codMedio='+id;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaMedio" title="Crear Medio" style="display:none"></div>
	
	<div id="cargaMedio" title="Editar Medio" style="display:none"></div>

	<div class="filtros">		
		<form id="formMedio" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar"/>
			<input type="text" 		id="nomMedio" 	name="nomMedio"	placeholder="Nombre Medio">
		</form>
	</div> 

	<div id="listadoBusquedaMedios" class="listado">
		<table id="listadoMedios"></table>
		<div id="pieMedio" class="pie"></div>
	</div>
</div>
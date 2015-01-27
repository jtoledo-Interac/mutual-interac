<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

	var idEmpresa;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoEmpresas').jqGrid(
		{
		   	url: getUrlBuscarEmpresas(),
			datatype: "xml",
			colNames : ['Nº Adherente', 'Nombre Empresa',''],
			colModel : [
						{name : 'numAdherente', index:'numAdherente', width : 110}, 
						{name : 'nombre', index:'desEmpresa', width : 300, search : true, resizable : false, sortable : true},				
						{name : 'act',index:'act', width : 30, resizable:false,sortable : true}
						],
		   	rowNum:100,
		   	height: 450,
		   	autowidth: true,
		   	rowList:[100,200,300],
			xmlReader: {
				root : "filas",
				row: "fila",
				repeatitems: false,
				id: "codEmpresa"
			},
		   	pager: $('#pieEmpresa'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'codEmpresa',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Empresas",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoEmpresas").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					var idFila = ids[i];

					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarEmpresa("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarEmpresa("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoEmpresas").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoEmpresas').jqGrid('getRowData',idFila);
				editarEmpresa(fila.idEmpresa);
			},
		}).navGrid('#pieEmpresa',{edit:false,add:false,del:false});	

		formatRut();
		
		$('#btnBuscar').click(function()
		{
			buscarEmpresas();
		});

		$('#btnAgregar').click(function()
		{
		    crearEmpresa();
		});
		
		$('#agregaEmpresa').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Empresa": function() {
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
		
		$('#cargaEmpresa').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Empresa": function() {
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
	
	function crearEmpresa()
	{
		ajaxCall(getUrlCrearEmpresa(), function(response){
			$('#agregaEmpresa').html(response).dialog('open');
		});
	}
	
	function editarEmpresa(idEmpresa)
	{
		ajaxCall(getUrlCargarEmpresa(idEmpresa), function(response){
			$('#cargaEmpresa').html(response).dialog('open');
		});
	}
	
	function eliminarEmpresa(idEmpresa)
	{  
   		jConfirm('¿ Confirma eliminar el Empresa ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarEmpresa(idEmpresa), function(){
  					jAlert("El Empresa ha sido eliminado exitosamente");
  					buscarEmpresas();
   				});
   			}
   		});
	}
	
	function buscarEmpresas() 
	{		
		$('#listadoEmpresas').jqGrid('setGridParam', {
			url : getUrlBuscarEmpresas(),
			page : 1,
			rowNum : 100,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarEmpresas()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarEmpresas";
		sData += "&nomEmpresa="+$('#nomEmpresa').val();
		return sData;
	}

	function getUrlCrearEmpresa()
	{
		var sData = "Servlet";
		sData += '?accion=crearEmpresa';
		return sData;
	}
	
	function getUrlCargarEmpresa(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarEmpresa';
		sData += '&nIdEmpresa='+id;
		return sData;
	}

	function getUrlEliminarEmpresa(nIdEmpresa){  
		var sData = 'Servlet';
		sData += '?accion=eliminarEmpresa';
		sData += '&numAdherente='+nIdEmpresa;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaEmpresa" title="Crear Empresa" style="display:none"></div>
	
	<div id="cargaEmpresa" title="Editar Empresa" style="display:none"></div>

	<div class="filtros">		
		<form id="formEmpresa" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar"/>
			<input type="text" 		id="nomEmpresa" 	name="nomEmpresa"	placeholder="Nombre Empresa">
			<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente">
		</form>
	</div> 

	<div id="listadoBusquedaEmpresas" class="listado">
		<table id="listadoEmpresas"></table>
		<div id="pieEmpresa" class="pie"></div>
	</div>
</div>
<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript"> 

	var idEmpresa;
	var idFila = 0;
	var numFilas = 15;
	var resp = "0";
	
	$(function() {

		$('#listadoEmpresas').jqGrid(
		{
		   	url: getUrlBuscarEmpresas(),
			datatype: "xml",
			colNames : [ '', 'N� Adherente', 'Nombre Empresa', '' ],
			colModel : [						
						{name : 'idEmpresa', index:'idEmpresa', hidden : true}, 
						{name : 'numAdherente', index:'numAdherente', width : 110}, 
						{name : 'nombre', index:'desEmpresa', width : 300, search : true, resizable : false, sortable : true},				
						{name : 'act',index:'act', width : 30, resizable:false,sortable : true, hidden: true}
						],
		   	rowNum: numeroDeFilas,
		   	//height: altoGrilla,
		   	//width: anchoGrilla,
		   	rowList:[10,50,100,200,500],
			xmlReader: {
				root : "filas",
				row: "fila",
				repeatitems: false,
				id: "idEmpresa"
			},
		   	pager: '#pieEmpresa',
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'numAdherente',
		    viewrecords: true,
		    loadonce:true,
		    sortorder: "desc",
		    caption:"Empresas",
		    hoverrows : true,
		    multiselect : false,
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

				$('#listadoEmpresas').jqGrid('setGridWidth', $(this).parent().width());
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
		
		$('#btnBuscar2').click(function()
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
		
		$('#cargaEmpresa').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Empresa": function() {
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
   		jConfirm('� Confirma eliminar el Empresa ?', 'Confirmaci�n', function(res){
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
			rowNum : 10,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarEmpresas()
	{  
		var sData = "Servlet";
		sData += "?accion=seleccionarEmpresas";
		sData += "&nomEmpresa="+$('#nomEmpresa').val();
		sData += "&numAdherente="+$('#numAdherente').val();
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
		sData += '&idEmpresa='+id;
		return sData;
	}

	function getUrlEliminarEmpresa(nIdEmpresa){  
		var sData = 'Servlet';
		sData += '?accion=eliminarEmpresa';
		sData += '&idEmpresa='+nIdEmpresa;
		return sData;
    }
</script>

<div class="mantenedor">
	<div class="filtros">		
		<form id="formEmpresa" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar2" 		name="btnBuscar2" 	value="Buscar" class="boton"/>
			<input type="text" 		id="nomEmpresa" 	name="nomEmpresa"	placeholder="Nombre Empresa" class="text">
			<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="N� Adherente" class="text">
		</form>
	</div> 

	<div id="listadoBusquedaEmpresas" class="listado">
		<table id="listadoEmpresas"></table>
		<div id="pieEmpresa" class="pie"></div>
	</div>
</div>
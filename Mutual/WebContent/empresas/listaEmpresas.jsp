<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  $('select').select2();
</script>
<script type="text/javascript"> 

	var idEmpresa;
	var idFila = 0;
	var numFilas = 15;
	
	$(function() {

		$('#listadoEmpresas').jqGrid(
		{
		   	url: getUrlBuscarEmpresas(),
			datatype: "xml",
			colNames : [ '', 'Nº Adherente', 'Nombre Empresa', '' ],
			colModel : [						
						{name : 'idEmpresa', index:'idEmpresa', hidden : true}, 
						{name : 'numAdherente', index:'numAdherente', width : 110}, 
						{name : 'nombre', index:'desEmpresa', width : 300, search : true, resizable : false, sortable : true},				
						{name : 'act',index:'act', width : 30, resizable:false,sortable : true}
						],
		   	rowNum: numeroDeFilas,
		   	height: altoGrilla,
		   	width: anchoGrilla,
		   	rowList:[10,50,100,200,500],
			xmlReader: {
				root : "filas",
				row: "fila",
				repeatitems: false,
				id: "	"
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
			rowNum : 10,
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
		sData += '&numAdherente='+nIdEmpresa;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaEmpresa" title="Crear Empresa" style="display:none"></div>
	
	<div id="cargaEmpresa" title="Editar Empresa" style="display:none"></div>

	<div class="filtros">		
		<form id="formEmpresa" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="nomEmpresa" 	name="nomEmpresa"	placeholder="Nombre Empresa" class="text">
			<input type="text" 		id="numAdherente" 	name="numAdherente"	placeholder="Nº Adherente" class="text">
		</form>
	</div> 

	<div id="listadoBusquedaEmpresas" class="listado">
		<table id="listadoEmpresas"></table>
		<div id="pieEmpresa" class="pie"></div>
	</div>
</div>
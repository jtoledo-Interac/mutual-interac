<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

	var idPerfil;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoPerfiles').jqGrid(
		{
		   	url: getUrlBuscarPerfiles(),
			datatype: "xml",
			colNames : ['', 'Nombre Perfil',''],
			colModel : [
						{name : 'idPerfil', index:'idPerfil', hidden : true}, 
						{name : 'desPerfil', index : 'desPerfil', width : 80, resizable : false, sortable : true},
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
				id: "idPerfil"
			},
		   	pager: $('#piePerfil'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'idPerfil',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Perfiles",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoPerfiles").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					var idFila = ids[i];

					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarPerfil("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarPerfil("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoPerfiles").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoPerfiles').jqGrid('getRowData',idFila);
				editarPerfil(fila.idPerfil);
			},
		}).navGrid('#piePerfil',{edit:false,add:false,del:false});	

		formatRut();
		
		$('#btnBuscar').click(function()
		{
			buscarPerfiles();
		});

		$('#btnAgregar').click(function()
		{
		    crearPerfil();
		});
		
		$('#agregaPerfil').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Perfil": function() {
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
		
		$('#cargaPerfil').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Perfil": function() {
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
	
	function crearPerfil()
	{
		ajaxCall(getUrlCrearPerfil(), function(response){
			$('#agregaPerfil').html(response).dialog('open');
		});
	}
	
	function editarPerfil(idPerfil)
	{
		ajaxCall(getUrlCargarPerfil(idPerfil), function(response){
			$('#cargaPerfil').html(response).dialog('open');
		});
	}
	
	function eliminarPerfil(idPerfil)
	{  
   		jConfirm('¿ Confirma eliminar el perfil ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarPerfil(idPerfil), function(){
  					jAlert("El perfil ha sido eliminado exitosamente");
  					buscarPerfiles();
   				});
   			}
   		});
	}
	
	function buscarPerfiles() 
	{		
		$('#listadoPerfiles').jqGrid('setGridParam', {
			url : getUrlBuscarPerfiles(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarPerfiles()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarPerfiles";
		sData += "&pNombres="+$('#pNombres').val();
		return sData;
	}

	function getUrlCrearPerfil()
	{
		var sData = "Servlet";
		sData += '?accion=crearPerfil';
		return sData;
	}
	
	function getUrlCargarPerfil(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarPerfil';
		sData += '&idPerfil='+id;
		return sData;
	}

	function getUrlEliminarPerfil(idPerfil){  
		var sData = 'Servlet';
		sData += '?accion=eliminarPerfil';
		sData += '&idPerfil='+idPerfil;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaPerfil" title="Crear perfil" style="display:none"></div>
	
	<div id="cargaPerfil" title="Editar perfil" style="display:none"></div>

	<div class="filtros">		
		<form id="formPerfil" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="pNombres" 		name="pNombres"		placeholder="Nombres">
		</form>
	</div> 

	<div id="listadoBusquedaPerfiles" class="listado">
		<table id="listadoPerfiles"></table>
		<div id="piePerfil" class="pie"></div>
	</div>
</div>
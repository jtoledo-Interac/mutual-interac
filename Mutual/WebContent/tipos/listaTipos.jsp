<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  $('select').select2();
</script>
<script type="text/javascript"> 

	var codTipo;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoTipos').jqGrid(
		{
		   	url: getUrlBuscarTipos(),
			datatype: "xml",
			colNames : ['', 'Nombre Tipo',''],
			colModel : [
						{name : 'codTipo', index:'codTipo', hidden : true}, 
						{name : 'desTipo', index:'desTipo', width : 80, search : true, resizable : false, sortable : true},				
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
				id: "codTipo"
			},
		   	pager: $('#pieTipos'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'codTipos',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Tipos",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoTipos").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					
					var idFila = ids[i];
					console.log("IDFILA: "+idFila);
					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarTipo("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarTipo("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoTipos").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
				console.log("Paso aca: "+idFila);
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoTipos').jqGrid('getRowData',idFila);
				//editarProducto(fila.codProducto);
			},
		}).navGrid('#pieTipo',{edit:false,add:false,del:false});	
		
		$('#btnBuscar').click(function()
		{
			buscarTipos();
		});

		$('#btnAgregar').click(function()
		{
		    crearTipo();
		});
		
		$('#agregaTipo').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Tipo": function() {
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
		
		$('#cargaTipo').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Tipo": function() {
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
	
	function crearTipo()
	{
		ajaxCall(getUrlCrearTipo(), function(response){
			$('#agregaTipo').html(response).dialog('open');
		});
	}
	
	function editarTipo(codTipo)
	{
		console.log("TIPO: "+codTipo);
		
		ajaxCall(getUrlCargarTipo(codTipo), function(response){
			$('#cargaTipo').html(response).dialog('open');
		});
	}
	
	function eliminarTipo(codTipo)
	{  
   		jConfirm('¿ Confirma eliminar el Tipo ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarTipo(codTipo), function(){
  					jAlert("El Tipo ha sido eliminado exitosamente");
  					buscarTipos();
   				});
   			}
   		});
	}
	
	function buscarTipos() 
	{		
		$('#listadoTipos').jqGrid('setGridParam', {
			url : getUrlBuscarTipos(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarTipos()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarTipos";
		sData += "&nomTipo="+$('#nomTipo').val();
		return sData;
	}

	function getUrlCrearTipo()
	{
		var sData = "Servlet";
		sData += '?accion=crearTipo';
		return sData;
	}
	
	function getUrlCargarTipo(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarTipo';
		sData += '&codTipo='+id;
		console.log(sData);
		return sData;
	}

	function getUrlEliminarTipo(id){  
		var sData = 'Servlet';
		sData += '?accion=eliminarTipo';
		sData += '&codTipo='+id;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaTipo" title="Crear Tipo" style="display:none"></div>
	
	<div id="cargaTipo" title="Editar Tipo" style="display:none"></div>

	<div class="filtros">		
		<form id="formTipo" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="nomTipo" 	name="nomTipo"	placeholder="Nombre Tipo" class="text">
		</form>
	</div> 

	<div id="listadoBusquedaTipos" class="listado">
		<table id="listadoTipos"></table>
		<div id="pieTipo" class="pie"></div>
	</div>
</div>
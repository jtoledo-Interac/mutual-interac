<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

	var idMotivo;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoMotivos').jqGrid(
		{
		   	url: getUrlBuscarMotivos(),
			datatype: "xml",
			colNames : ['', 'Nombre Motivo',''],
			colModel : [
						{name : 'idMotivo', index:'idMotivo', hidden : true}, 
						{name : 'desMotivo', index:'desMotivo', width : 80, search : true, resizable : false, sortable : true},				
						{name : 'act',index:'act', width : 30, resizable:false,sortable : true}
						],
		   	rowNum:10,
		   	rowNum: numeroDeFilas,
		   	height: altoGrilla,
		   	width: anchoGrilla,
		   	loadonce:true,
		   	rowList:[10,20,30],
			xmlReader: {
				root : "filas",
				row: "fila",
				repeatitems: false,
				id: "idMotivo"
			},
		   	pager: $('#pieMotivos'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'idMotivos',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Motivos",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoMotivos").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					
					var idFila = ids[i];
					console.log("IDFILA: "+idFila);
					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarMotivo("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarMotivo("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoMotivos").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
				console.log("Paso aca: "+idFila);
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoMotivos').jqGrid('getRowData',idFila);
				//editarProducto(fila.codProducto);
			},
		}).navGrid('#pieMotivo',{edit:false,add:false,del:false});	
		
		$('#btnBuscar').click(function()
		{
			buscarMotivos();
		});

		$('#btnAgregar').click(function()
		{
		    crearMotivo();
		});
		
		$('#agregaMotivo').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Motivo": function() {
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
		
		$('#cargaMotivo').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Motivo": function() {
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
	
	function crearMotivo()
	{
		ajaxCall(getUrlCrearMotivo(), function(response){
			$('#agregaMotivo').html(response).dialog('open');
		});
	}
	
	function editarMotivo(idMotivo)
	{
		console.log("Motivo: "+idMotivo);
		
		ajaxCall(getUrlCargarMotivo(idMotivo), function(response){
			$('#cargaMotivo').html(response).dialog('open');
		});
	}
	
	function eliminarMotivo(idMotivo)
	{  
   		jConfirm('¿ Confirma eliminar el Motivo ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarMotivo(idMotivo), function(){
  					jAlert("El Motivo ha sido eliminado exitosamente");
  					buscarMotivos();
   				});
   			}
   		});
	}
	
	function buscarMotivos() 
	{		
		$('#listadoMotivos').jqGrid('setGridParam', {
			url : getUrlBuscarMotivos(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarMotivos()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarMotivos";
		sData += "&nomMotivo="+$('#nomMotivo').val();
		return sData;
	}

	function getUrlCrearMotivo()
	{
		var sData = "Servlet";
		sData += '?accion=crearMotivo';
		return sData;
	}
	
	function getUrlCargarMotivo(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarMotivo';
		sData += '&idMotivo='+id;
		console.log(sData);
		return sData;
	}

	function getUrlEliminarMotivo(id){  
		var sData = 'Servlet';
		sData += '?accion=eliminarMotivo';
		sData += '&idMotivo='+id;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaMotivo" title="Crear Motivo" style="display:none"></div>
	
	<div id="cargaMotivo" title="Editar Motivo" style="display:none"></div>

	<div class="filtros">		
		<form id="formMotivo" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="nomMotivo" 	name="nomMotivo"	placeholder="Nombre Motivo" class="text">
		</form>
	</div> 

	<div id="listadoBusquedaMotivos" class="listado">
		<table id="listadoMotivos"></table>
		<div id="pieMotivo" class="pie"></div>
	</div>
</div>
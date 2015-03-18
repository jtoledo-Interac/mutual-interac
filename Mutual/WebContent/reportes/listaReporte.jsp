<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  $('select').select2();
</script>
<script type="text/javascript"> 

	var idReporte;
	var idFila = 0;
	var numFilas = 15;
	
	$(function() {

		$('#listadoReportes').jqGrid(
		{
		   	url: getUrlBuscarReportes(),
			datatype: "xml",
			colNames : [ '', 'Nº Adherente', 'Nombre Reporte', '' ],
			colModel : [						
						{name : 'idReporte', index:'idReporte', hidden : true}, 
						{name : 'numAdherente', index:'numAdherente', width : 110}, 
						{name : 'nombre', index:'desReporte', width : 300, search : true, resizable : false, sortable : true},				
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
				id: "idReporte"
			},
		   	pager: '#pieReporte',
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'numAdherente',
		    viewrecords: true,
		    loadonce:true,
		    sortorder: "desc",
		    caption:"Reportes",
		    hoverrows : true,
		    multiselect : false,
			gridComplete: function()
			{
				var ids = $("#listadoReportes").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					var idFila = ids[i];
						
					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarReporte("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarReporte("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoReportes").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
				$(this).closest('.ui-dialog-content').dialog('close');
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoReportes').jqGrid('getRowData',idFila);
				editarReporte(fila.idReporte);
			},
		}).navGrid('#pieReporte',{edit:false,add:false,del:false});	
		
		$('#btnBuscar').click(function()
		{
			buscarReportes();
		});

		$('#btnAgregar').click(function()
		{
		    crearReporte();
		});
		
		$('#agregaReporte').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Reorte": function() {
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
		
		$('#cargaReporte').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Reporte": function() {
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
	
	function crearReporte()
	{
		ajaxCall(getUrlCrearReporte(), function(response){
			$('#agregaReporte').html(response).dialog('open');
		});
	}
	
	/*function editarReporte(idReporte)
	{
		ajaxCall(getUrlCargarReporte(idReporte), function(response){
			$('#cargaReporte').html(response).dialog('open');
		});
	}*/
	
	/*function eliminarReporte(idReporte)
	{  
   		jConfirm('¿ Confirma eliminar el Reporte ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarReporte(idReporte), function(){
  					jAlert("El Reporte ha sido eliminado exitosamente");
  					buscarReportes();
   				});
   			}
   		});
	}*/
	
	function buscarReportes() 
	{		
		$('#listadoReportes').jqGrid('setGridParam', {
			url : getUrlBuscarReportes(),
			page : 1,
			rowNum : 10,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarReportes()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarReportes";
		sData += "&nomEmpresa="+$('#nomEmpresa').val();
		return sData;
	}

	function getUrlCrearReporte()
	{
		var sData = "Servlet";
		sData += '?accion=crearReporte';
		return sData;
	}
	
	function getUrlCargarReporte(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarReporte';
		sData += '&idReporte='+id;
		return sData;
	}

	function getUrlEliminarReporte(nIdReporte){  
		var sData = 'Servlet';
		sData += '?accion=eliminarReporte';
		sData += '&idReporte='+nIdReporte;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaReporte" title="Crear Reporte" style="display:none"></div>
	
	<div id="cargaReporte" title="Editar Reporte" style="display:none"></div>

	<div class="filtros">		
		<form id="formReporte" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="nomEmpresa" 	name="nomEmpresa"	placeholder="Nombre Empresa" class="text">
		</form>
	</div> 

	<div id="listadoBusquedaReportes" class="listado">
		<table id="listadoReportes"></table>
		<div id="pieReporte" class="pie"></div>
	</div>
</div>
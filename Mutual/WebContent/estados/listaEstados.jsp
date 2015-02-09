	<%@ include file="../declaraciones.jsp" %>
	<%@ include file="../encabezado.jsp" %>
	<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
	
	<script type="text/javascript">
 	 //$('select').select2();
	</script>
	
	<script type="text/javascript"> 
	
		var idEstado;
		var idFila = 0;
		var numFilas = 10;
		
		$(function() {
	
			$('#listadoEstados').jqGrid(
			{
			   	url: getUrlBuscarEstados(),
				datatype: "xml",
				colNames : ['', 'Nombre Estado',''],
				colModel : [
							{name : 'idEstado', index:'idEstado', hidden : true}, 
							{name : 'desEstado', index:'desEstado', width : 80, search : true, resizable : false, sortable : true},				
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
					id: "idEstado"
				},
			   	pager: $('#pieEstado'),
			   	pgtext : 'P&aacute;g: {0} de {1}', 
			   	sortname: 'idEstado',
			    viewrecords: true,
			    sortorder: "desc",
			    caption:"Estados",
			    loadonce:true,
			    hoverrows : true,
			    multiselect : false,
				onPaging: function(){
	
				},
				gridComplete: function()
				{
					var ids = $("#listadoEstados").getDataIDs();
					
					for (var i = 0; i < ids.length; i++)
					{
						
						var idFila = ids[i];
						console.log("IDFILA: "+idFila);
						var btnEditar="";
						btnEditar+= "<div id='btnEditar' onclick='editarEstado("+idFila+")'>";
						btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
						btnEditar+= "</div>";
						
						var btnEliminar="";
						btnEliminar+= "<div id='btnEliminar' onclick='eliminarEstado("+idFila+")'>";
						btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
						btnEliminar+= "</div>";
	
						$("#listadoEstados").setRowData(ids[i], {act : btnEditar + btnEliminar});
					}
				},
				onSelectRow : function(rowId, status) 
				{
					idFila = rowId;
					console.log("Paso aca: "+idFila);
				},
				ondblClickRow: function()
				{
					var fila = $('#listadoEstados').jqGrid('getRowData',idFila);
					
				},
			}).navGrid('#pieEstado',{edit:false,add:false,del:false});	
			
			$('#btnBuscar').click(function()
			{
				buscarEstados();
			});
	
			$('#btnAgregar').click(function()
			{
			    crearEstado();
			});
			
			$('#agregaEstado').dialog({
				autoOpen: false,
			    height: 500,
			    width: 650,
			    modal: true,
			    position: 'center',
			    buttons: {
					"Crear Estado": function() {
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
			
			$('#cargaEstado').dialog({
				autoOpen: false,
			    height: 500,
			    width: 650,
			    modal: true,
			    position: 'center',
			    buttons: {
					"Editar Estado": function() {
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
		
		function crearEstado()
		{
			ajaxCall(getUrlCrearEstado(), function(response){
				$('#agregaEstado').html(response).dialog('open');
			});
		}
		
		function editarEstado(idEstado)
		{
			console.log("ESTADO: "+idEstado);
			
			ajaxCall(getUrlCargarEstado(idEstado), function(response){
				$('#cargaEstado').html(response).dialog('open');
			});
		}
		
		function eliminarEstado(idEstado)
		{  
	   		jConfirm('¿ Confirma eliminar el Estado ?', 'Confirmación', function(res){
	   			if (res == true){
	  				ajaxCall(getUrlEliminarEstado(idEstado), function(){
	  					jAlert("El Estado ha sido eliminado exitosamente");
	  					buscarEstados();
	   				});
	   			}
	   		});
		}
		
		function buscarEstados() 
		{		
			$('#listadoEstados').jqGrid('setGridParam', {
				url : getUrlBuscarEstados(),
				page : 1,
				rowNum : numFilas,
				autoencode : false,
				mtype : 'POST',
				datatype : 'xml',
			}).trigger("reloadGrid");
		}
	
		function getUrlBuscarEstados()
		{  
			var sData = "Servlet";
			sData += "?accion=buscarEstados";
			sData += "&nomEstado="+$('#nomEstado').val();
			return sData;
		}
	
		function getUrlCrearEstado()
		{
			var sData = "Servlet";
			sData += '?accion=crearEstado';
			return sData;
		}
		
		function getUrlCargarEstado(id)
		{
			var sData = "Servlet";
			sData += '?accion=cargarEstado';
			sData += '&idEstado='+id;
			console.log(sData);
			return sData;
		}
	
		function getUrlEliminarEstado(id){  
			var sData = 'Servlet';
			sData += '?accion=eliminarEstado';
			sData += '&idEstado='+id;
			return sData;
	    }
	</script>
	
	<div class="mantenedor">
	
		<div id="agregaEstado" title="Crear Estado" style="display:none"></div>
		
		<div id="cargaEstado" title="Editar Estado" style="display:none"></div>
	
		<div class="filtros">		
			<form id="formEstado" action="Servlet" method="post">
				<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
				<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
				<input type="text" 		id="nomEstado" 	name="nomEstado"	placeholder="Nombre Estado" class="text">
			</form>
		</div> 
	
		<div id="listadoBusquedaEstados" class="listado">
			<table id="listadoEstados"></table>
			<div id="pieEstado" class="pie"></div>
		</div>
	</div>
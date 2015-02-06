<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

	var idUsuario;
	var idFila = 0;
	var numFilas = 10;
	
	$(function() {

		$('#listadoUsuarios').jqGrid(
		{
		   	url: getUrlBuscarUsuarios(),
			datatype: "xml",
			colNames : ['', 'Rut', 'Nombre', 'Nombre Usuario', 'Email', 'Telefono', 'Celular',''],
			colModel : [
						{name : 'idUsuario', index:'idUsuario', hidden : true}, 
						{name : 'rut', index : 'rut', width : 80, resizable : false, sortable : true},
						{name : 'nombre', index : 'nombre', width : 150, resizable : false, sortable : true},
						{name : 'nomUsuario', index:'nomUsuario', width : 80, search : true, resizable : false, sortable : true},				
						{name : 'email', index:'email', width: 150, resizable: false, sortable: true},
						{name : 'telefono', index:'telefono', width: 80, resizable: false, sortable: true},
						{name : 'celular', index:'celular', width: 80, resizable: false, sortable: true},
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
				id: "idUsuario"
			},
		   	pager: $('#pieUsuario'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'idUsuario',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Usuarios",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoUsuarios").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					var idFila = ids[i];

					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarUsuario("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarUsuario("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoUsuarios").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoUsuarios').jqGrid('getRowData',idFila);
				editarUsuario(fila.idUsuario);
			},
		}).navGrid('#pieUsuario',{edit:false,add:false,del:false});	

		formatRut();
		
		$('#btnBuscar').click(function()
		{
			buscarUsuarios();
		});

		$('#btnAgregar').click(function()
		{
		    crearUsuario();
		});
		
		$('#agregaUsuario').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Usuario": function() {
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
		
		$('#cargaUsuario').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Usuario": function() {
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
	
	function crearUsuario()
	{
		ajaxCall(getUrlCrearUsuario(), function(response){
			$('#agregaUsuario').html(response).dialog('open');
		});
	}
	
	function editarUsuario(idUsuario)
	{
		ajaxCall(getUrlCargarUsuario(idUsuario), function(response){
			$('#cargaUsuario').html(response).dialog('open');
		});
	}
	
	function eliminarUsuario(idUsuario)
	{  
   		jConfirm('¿ Confirma eliminar al usuario ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarUsuario(idUsuario), function(){
  					jAlert("El usuario ha sido eliminado exitosamente");
  					buscarUsuarios();
   				});
   			}
   		});
	}
	
	function buscarUsuarios() 
	{		
		$('#listadoUsuarios').jqGrid('setGridParam', {
			url : getUrlBuscarUsuarios(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarUsuarios()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarUsuarios";
		sData += "&sRut="+$('#sRut').val();
		sData += "&sNombres="+$('#sNombres').val();
		sData += "&sApePaterno="+$('#sApePaterno').val();
		sData += "&sApeMaterno="+$('#sApeMaterno').val();
		sData += "&sNomUsuario="+$('#sNomUsuario').val();
		return sData;
	}

	function getUrlCrearUsuario()
	{
		var sData = "Servlet";
		sData += '?accion=crearUsuario';
		return sData;
	}
	
	function getUrlCargarUsuario(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarUsuario';
		sData += '&nIdUsuario='+id;
		return sData;
	}

	function getUrlEliminarUsuario(nIdUsuario){  
		var sData = 'Servlet';
		sData += '?accion=eliminarUsuario';
		sData += '&nIdUsuario='+nIdUsuario;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaUsuario" title="Crear usuario" style="display:none"></div>
	
	<div id="cargaUsuario" title="Editar usuario" style="display:none"></div>

	<div class="filtros">		
		<form id="formUsuario" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text"		id="sRut" 			name="sRut" 		placeholder="Rut" class="text" class="rut2" >
			<input type="hidden"	id="sDV" 			name="sDV">
			<input type="text" 		id="sNombres" 		name="sNombres"		placeholder="Nombres" class="text">
			<input type="text" 		id="sApePaterno" 	name="sApePaterno"	placeholder="Apellido Paterno" class="text">
			<input type="text" 		id="sApeMaterno" 	name="sApeMaterno" 	placeholder="Apellido Materno" class="text">
			<input type="text" 		id="sNomUsuario" 	name="sNomUsuario"	placeholder="Nombre Usuario" class="text">
		</form>
	</div> 

	<div id="listadoBusquedaUsuarios" class="listado">
		<table id="listadoUsuarios"></table>
		<div id="pieUsuario" class="pie"></div>
	</div>
</div>
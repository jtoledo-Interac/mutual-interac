<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<script type="text/javascript">
  //$('select').select2();
</script>
<script type="text/javascript"> 

	var idLink;
	var idFila = 0;
	var numFilas = 10;
	function Link(id) {
		
			
	    var row = id.split("=");
	    var row_ID = row[1];
	    var sitename= $("#listadoLinks").getCell(row_ID, 'urlLink');
	    var url = "http://"+sitename; // sitename will be like google.com or yahoo.com

	    window.open(url);


	}
	
	$(function() {
	

		$('#listadoLinks').jqGrid(
		{
		   	url: getUrlBuscarLinks(),
			datatype: "xml",
			colNames : ['', '', 'URL', 'Descripción Link', 'Categoría link' ,''],
			colModel : [
						{name : 'idLink', index:'idLink', hidden : true},
						{name : 'idCategoriaLink', index:'idCategoriaLink', hidden : true},					
						{name : 'urlLink', index:'urlLink', width : 80, search : true, resizable : false, sortable : true,formatter: 'showlink', formatoptions: { baseLinkUrl: 'javascript:', showAction: "Link('", addParam: "');"}},
						{name : 'desLink', index:'desLink', width : 80, search : true, resizable : false, sortable : true},
						{name : 'desCategoriaLink', index:'desCategoriaLink', width : 80, search : true, resizable : false, sortable : true},
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
				id: "idLink"
			},
		   	pager: $('#pieLinks'),
		   	pgtext : 'P&aacute;g: {0} de {1}', 
		   	sortname: 'codLinks',
		    viewrecords: true,
		    sortorder: "desc",
		    caption:"Links de Reclamo",
		    hoverrows : true,
		    multiselect : false,
			onPaging: function(){

			},
			gridComplete: function()
			{
				var ids = $("#listadoLinks").getDataIDs();
				
				for (var i = 0; i < ids.length; i++)
				{
					
					var idFila = ids[i];
					console.log("IDFILA: "+idFila);
					var btnEditar="";
					btnEditar+= "<div id='btnEditar' onclick='editarLink("+idFila+")'>";
					btnEditar+= 	"<img title='editar' class='icono' src='img/btnEditar.png'>";
					btnEditar+= "</div>";
					
					var btnEliminar="";
					btnEliminar+= "<div id='btnEliminar' onclick='eliminarLink("+idFila+")'>";
					btnEliminar+= 	"<img title='eliminar' class='icono' src='img/btnEliminar.png'>";
					btnEliminar+= "</div>";

					$("#listadoLinks").setRowData(ids[i], {act : btnEditar + btnEliminar});
				}
			},
			onSelectRow : function(rowId, status) 
			{
				idFila = rowId;
				console.log("Paso aca: "+idFila);
			},
			ondblClickRow: function()
			{
				var fila = $('#listadoLinks').jqGrid('getRowData',idFila);
				//editarProducto(fila.codProducto);
			},
		}).navGrid('#pieLink',{edit:false,add:false,del:false});	
		
		$('#btnBuscar').click(function()
		{
			buscarLinks();
		});

		$('#btnAgregar').click(function()
		{
		    crearLink();
		});
		
		$('#agregaLink').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Crear Link": function() {
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
		
	
		
		$('#cargaLink').dialog({
			autoOpen: false,
		    height: 500,
		    width: 650,
		    modal: true,
		    position: 'center',
		    buttons: {
				"Editar Link": function() {
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
	
	function crearLink()
	{
		ajaxCall(getUrlCrearLink(), function(response){
			$('#agregaLink').html(response).dialog('open');
		});
	}
	
	function editarLink(idLink)
	{
		console.log("Link: "+idLink);
		
		ajaxCall(getUrlCargarLink(idLink), function(response){
			$('#cargaLink').html(response).dialog('open');
		});
	}
	
	function eliminarLink(idLink)
	{  
   		jConfirm('¿ Confirma eliminar el Link ?', 'Confirmación', function(res){
   			if (res == true){
  				ajaxCall(getUrlEliminarLink(idLink), function(){
  					jAlert("El Link ha sido eliminado exitosamente");
  					buscarLinks();
   				});
   			}
   		});
	}
	
	function buscarLinks() 
	{		
		$('#listadoLinks').jqGrid('setGridParam', {
			url : getUrlBuscarLinks(),
			page : 1,
			rowNum : numFilas,
			autoencode : false,
			mtype : 'POST',
			datatype : 'xml',
		}).trigger("reloadGrid");
	}

	function getUrlBuscarLinks()
	{  
		var sData = "Servlet";
		sData += "?accion=buscarLinks";
		sData += "&nomLink="+$('#nomLink').val();
		sData += "&categoriaLink="+$('#categoriaLink').val();
		return sData;
	}

	function getUrlCrearLink()
	{
		var sData = "Servlet";
		sData += '?accion=crearLink';
		return sData;
	}
	
	function getUrlCargarLink(id)
	{
		var sData = "Servlet";
		sData += '?accion=cargarLink';
		sData += '&idLink='+id;
		console.log(sData);
		return sData;
	}

	function getUrlEliminarLink(id){  
		var sData = 'Servlet';
		sData += '?accion=eliminarLink';
		sData += '&idLink='+id;
		return sData;
    }
</script>

<div class="mantenedor">

	<div id="agregaLink" title="Crear Link" style="display:none"></div>
	
	<div id="cargaLink" title="Editar Link" style="display:none"></div>

	<div class="filtros">		
		<form id="formLink" action="Servlet" method="post">
			<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
			<input type="button" 	id="btnAgregar" 	name="btnAgregar" 	value="Agregar" class="boton"/>
			<input type="text" 		id="nomLink" 	name="nomLink"	placeholder="Descripción Link" class="text" onkeypress="return event.keyCode != 13;">
			
				<select id="idLink" name="idLink" class="select">
				<option value="0" selected>Seleccione categoría</option>
				<c:forEach items="${requestScope.listaCategoriasLink}" var="categoriaLink">
					<option value="${categoriaLink.IdCategoriaLink}" >${categoriaLink.DesCategoriaLink}</option>
				</c:forEach>
			</select> 
		</form>
	</div> 

	<div id="listadoBusquedaLinks" class="listado">
		<table id="listadoLinks"></table>
		<div id="pieLink" class="pie"></div>
	</div>
</div>
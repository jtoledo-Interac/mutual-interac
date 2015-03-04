<%@ page language="java"%>
<%@ include file="declaraciones.jsp" %>
<%@ include file="encabezado.jsp" %>

<%
if( session.getAttribute("user")== null){
	response.sendRedirect("login.jsp");
} 
%>

<script type="text/javascript">

var flag = 1;

$(function()
{	
	$('#cerrar').click(function(){
		$('#accionLogOut').val("logOut");
		$('#logOut').submit();
	});
	
	$('#cargaUsuario').dialog({
		autoOpen: false,
	    height: 500,
	    width: 650,
	    modal: true,
	    position: 'center',
	    buttons: {
			"Editar Usuario": function() {
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

function editarUsuario(idUsuario)
{
	ajaxCall(getUrlCargarUsuario(idUsuario), function(response){
		$('#cargaUsuario').html(response).dialog('open');
	});
}

function getUrlCargarUsuario(id)
{
	var sData = "Servlet";
	sData += '?accion=cargarUsuario';
	sData += '&nIdUsuario='+id;
	return sData;
}
</script>
<div class="linea"> </div>

<div class="banner">
	<div class="banner-left">
		<img src="img/logo_siac.png" height="100%">
	</div>
	<div class="banner-center">
	<br>
	<table>
		<tr>
		<td>
			<p id="contNombre" style="float:right;color: #8d8d8d;"><% out.print(session.getAttribute("nombre") );	%></p>
			<form id="logOut" action="Servlet" method="post">
				<input type="hidden" id="accionLogOut" name="accion">
				<br/><span style="float:right;"><a href="#" id="cerrar">Cerrar Sesión</a></span>
			</form>
		</td>
		<td>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 	
		 	<!--<img src="img/user/usuario_${sessionScope.user.idUsuario}.jpg">
		 	<img src="img/user/usuario_${sessionScope.user.idUsuario}.jpg"  onerror="if (this.src != 'img/user/default.jpg') this.src = 'img/user/default.jpg';">
		 	<img <% %>>
		 	-->
		 	
		 	<a href="#"><img src="img/user/usuario_${sessionScope.user.idUsuario}.jpg"  onerror="if (this.src != 'img/user/default.jpg') this.src = 'img/user/default.jpg';" onclick='editarUsuario("${sessionScope.user.idUsuario}")'></a>
		 	
		</td>
		</tr>
	</table>
	</div>
	<div class="banner-right">
		<img src="img/mutual_logo2.png">
	</div>
</div>

<div id="cargaUsuario" title="Editar usuario" style="display:none"></div>

<div class="contenedor">
	<div id="menuwrapper">	
	    <ul>
	        <li><a href="Servlet?accion=organigrama">Organigrama</a></li>
	        <li><a href="#">Carteras</a>
	        	<ul>
					<li><a href="#">Transporte P&uacute;blico</a>
						<ul>
							<li><a href="Servlet?accion=prodCartera">Productos</a></li>
							<li><a href="Servlet?accion=planesTrabajo">Planes de Trabajo</a></li>
						</ul>
					</li>
					<li><a href="#">Telecomunicaciones y Energ&iacute;a</a>
						<ul>
							<li><a href="Servlet?accion=prodCartera">Productos</a></li>
							<li><a href="Servlet?accion=planesTrabajo">Planes de Trabajo</a></li>
						</ul>
					</li>
					<li><a href="#"> Administraci&oacute;n y Transporte de Carga</a>
						<ul>
							<li><a href="Servlet?accion=prodCartera">Productos</a></li>
							<li><a href="Servlet?accion=planesTrabajo">Planes de Trabajo</a></li>
						</ul>
					</li>
					<li><a href="#"> Transporte de Personas y Bienes</a>
						<ul>
							<li><a href="Servlet?accion=prodCartera">Productos</a></li>
							<li><a href="Servlet?accion=planesTrabajo">Planes de Trabajo</a></li>
						</ul>
					</li>
				</ul>
	        </li>
	       	<li><a href="#">Gestion Interna</a>
	        	<ul>
					<li><a href="Servlet?accion=invalideces">Invalideces</a></li>
					<li><a href="Servlet?accion=sami">SAMI</a></li>
					<li><a href="Servlet?accion=fatales"> Fatales</a></li>
				</ul>
	        </li>
	        <li><a href="Servlet?accion=documentos">Documentos</a></li>
	        <li><a href="Servlet?accion=empresas">Empresas</a></li>
			<!-- <li><a href="#">Reportes</a>
				<ul>
					<li><a href="Servlet?accion=repAccidentados">Accidentados</a></li>
					<li><a href="Servlet?accion=repDias">D&iacute;as Perdidos</a></li>
				</ul>
			</li> -->
			<li><a href="Servlet?accion=reclamos">Reclamos</a></li>
			<li><a href="Servlet?accion=links">Links de interés</a></li>
	        <!-- <li><a href="Servlet?accion=graficar">Graficos Prueba</a></li> -->
	        <%
				java.util.ArrayList<String> perfiles = (java.util.ArrayList<String>)session.getAttribute("perfiles");
				
				String menuAdmin="";
				menuAdmin += "<li><a href='#'>Administraci&oacute;n</a>";
				menuAdmin += "<ul>";
				menuAdmin += "	<li><a href='Servlet?accion=carteras'>Tipos de Cartera</a></li>";
				menuAdmin += "	<li><a href='Servlet?accion=productos'>Tipos de Documento</a></li>";
				menuAdmin += "	<li><a href='Servlet?accion=usuarios'>Usuarios</a></li>";
				menuAdmin += "	<li><a href='Servlet?accion=perfiles'>Perfiles</a></li>";
				menuAdmin += "	<li><a href='Servlet?accion=estados'>Estados Reclamo</a></li>";
				menuAdmin += "	<li><a href='Servlet?accion=medios'>Medios</a></li>";
				menuAdmin += "	<li><a href='Servlet?accion=motivos'>Motivos Reclamo</a></li>";
				menuAdmin += "	<li><a href='Servlet?accion=prioridades'>Prioridades</a></li>";
				menuAdmin += "	<li><a href='Servlet?accion=tipos'>Tipos de Reclamo</a></li>";
				menuAdmin += "	<li><a href='Servlet?accion=categorias'>Cateegoría Link de interés </a></li>";
				menuAdmin += "</ul>";
				menuAdmin += "</li>";
				
				if(perfiles.contains("admin"))out.print(menuAdmin);
			%>
			<br/>
			<li><a href="#">Vídeos tutoriales</a>
				<ul>
					<li><a href="Servlet?accion=ayuda&v=1"> Documentos </a></li>
					<li><a href="Servlet?accion=ayuda&v=2"> Empresas </a></li>
					<li><a href="Servlet?accion=ayuda&v=3"> Reclamo </a></li>
					<li><a href="Servlet?accion=ayuda&v=4"> Usuario</a></li>
					<li><a href="Servlet?accion=ayuda&v=5"> Módulos de Administración</a></li>
				</ul>
			</li>
			<li><a href="Servlet?accion=manual">Descargar Manual</a></li>
	    </ul>
	    
	</div>

	<div class="principal">
		<form id="formMantenedores" action="Servlet" method="post">
			<input type="hidden" id="accion" name="accion">
			
			<div class="listas">
				<c:choose>
					<%-- LOGIN --%>
					<c:when test="${param.accion eq 'login'}">	
						<%@ include file="documentos/listaDocumentos.jsp" %>
					</c:when>
					
					<%-- GRAFICO --%>
					<c:when test="${param.accion eq 'graficar'}">
						<%@ include file="graficos/grafico_bar.jsp" %>
					</c:when>
					
					<%-- ORGANIGRAMA --%>
					<c:when test="${param.accion eq 'organigrama'}">
						<%@ include file="organigrama.jsp" %>
					</c:when>
					
					<%-- DOCUMENTOS --%>
					<c:when test="${param.accion eq 'documentos'}">
						<%@ include file="documentos/listaDocumentos.jsp" %>
					</c:when>
					
					<%-- INVALIDECES --%>
					<c:when test="${param.accion eq 'invalideces'}">
						<%@ include file="documentos/listaDocumentos.jsp" %>
					</c:when>
					
					<%-- SAMI --%>
					<c:when test="${param.accion eq 'sami'}">
						<%@ include file="documentos/listaDocumentos.jsp" %>
					</c:when>
					
					<%-- FATALES --%>
					<c:when test="${param.accion eq 'fatales'}">
						<%@ include file="documentos/listaDocumentos.jsp" %>
					</c:when>
					
					<%-- PRODUCTOS CARTERA --%>
					<c:when test="${param.accion eq 'prodCartera'}">
						<%@ include file="documentos/listaDocumentos.jsp" %>
					</c:when>
					
					<%-- PLANES TRABAJO --%>
					<c:when test="${param.accion eq 'planesTrabajo'}">
						<%@ include file="documentos/listaDocumentos.jsp" %>
					</c:when>
					
					<%-- DOCUMENTOS --%>
					<c:when test="${param.accion eq 'agregarDocumento'}">
						<%@ include file="documentos/listaDocumentos.jsp" %>
					</c:when>
					
					<%-- DOCUMENTOS --%>
					<c:when test="${param.accion eq 'modificarDocumento'}">
						<%@ include file="documentos/listaDocumentos.jsp" %>
					</c:when>
					
					<%-- REPORTES --%>
					<c:when test="${param.accion eq 'reportes'}">
						<%@ include file="reportes/cargaReporte.jsp" %>
					</c:when>
					
					<%-- USUARIOS --%>
					<c:when test="${param.accion eq 'usuarios'}">
						<%@ include file="usuarios/listaUsuarios.jsp" %>
					</c:when>
					
					<%-- PERFILES --%>
					<c:when test="${param.accion eq 'perfiles'}">
						<%@ include file="perfiles/listaPerfiles.jsp" %>
					</c:when>
					
					<%-- CARTERAS --%>
					<c:when test="${param.accion eq 'carteras'}">
						<%@ include file="carteras/listaCarteras.jsp" %>
					</c:when>
					
					<%-- PRODUCTOS --%>
					<c:when test="${param.accion eq 'productos'}">
						<%@ include file="productos/listaProductos.jsp" %>
					</c:when>
					
					<%-- ESTADOS --%>
					<c:when test="${param.accion eq 'estados'}">
						<%@ include file="estados/listaEstados.jsp" %>
					</c:when>
					
					<%-- MEDIOS --%>
					<c:when test="${param.accion eq 'medios'}">
						<%@ include file="medios/listaMedios.jsp" %>
					</c:when>
					
					<%-- MOTIVOS --%>
					<c:when test="${param.accion eq 'motivos'}">
					<%@ include file="motivos/listaMotivos.jsp" %> 
					</c:when>

					<%-- PRIORIDADES --%>
					<c:when test="${param.accion eq 'prioridades'}">
						<%@ include file="prioridades/listaPrioridades.jsp" %>
					</c:when>
					
					<%-- TIPOS --%>
					<c:when test="${param.accion eq 'tipos'}">
						<%@ include file="tipos/listaTipos.jsp" %>
					</c:when>
					
					<%-- EMPRESAS --%>
					<c:when test="${param.accion eq 'empresas'}">
						<%@ include file="empresas/listaEmpresas.jsp" %>
					</c:when>
					
					<%-- REPORTE ACCIDENTADOS --%>
					<c:when test="${param.accion eq 'repAccidentados'}">
						<%@ include file="reportes/reporteAccidentados.jsp" %>
					</c:when>
					
					<%-- REPORTE DIAS PERDIDOS --%>
					<c:when test="${param.accion eq 'repDias'}">
						<%@ include file="reportes/reporteDias.jsp" %>
					</c:when>
					
					<%-- RECLAMOS --%>
					<c:when test="${param.accion eq 'reclamos'}">
						<%@ include file="reclamos/listaReclamos.jsp" %>
					</c:when>
					
					<%-- RECLAMOS --%>
					<c:when test="${param.accion eq 'agregarReclamo'}">
						<%@ include file="reclamos/listaReclamos.jsp" %>
					</c:when>
					
					<%-- RECLAMOS --%>
					<c:when test="${param.accion eq 'modificarReclamo'}">
						<%@ include file="reclamos/listaReclamos.jsp" %>
					</c:when>
					
					<%-- AYUDA --%>
					<c:when test="${param.accion eq 'ayuda'}">
						<%@ include file="video/showVideo.jsp" %>
					</c:when>
					
					<%-- MANUAL --%>
					<c:when test="${param.accion eq 'manual'}">
						<%@ include file="manual/manual.jsp" %>
					</c:when>		
					
					<%-- CATEGORIA LINNK DE INTERÉS --%>
					<c:when test="${param.accion eq 'categorias'}">
						<%@ include file="categoria_link/listaCategoria.jsp" %>
					</c:when>
					
					<%-- CATEGORIA LINNK DE INTERÉS --%>
					<c:when test="${param.accion eq 'links'}">
						<%@ include file="link/listaLinks.jsp" %>
					</c:when>								
					<c:otherwise></c:otherwise>
				</c:choose>
			</div>
		</form>
	</div>
</div>

<%@ include file="footer.jsp" %>
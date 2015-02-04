<%@ page language="java"%>
<%@ include file="declaraciones.jsp" %>
<%@ include file="encabezado.jsp" %>

<%
if( session.getAttribute("user")== null){
	response.sendRedirect("login.jsp");
} 
%>

<script type="text/javascript">
$(function()
{	
	$('#cerrar').click(function(){
		$('#accionLogOut').val("logOut");
		$('#logOut').submit();
	});
	
});
</script>

<div class="banner">

	<div class="logo-banner">
		
	</div>
	
	<div class="info-user">
		<br />
		
		<p id="contNombre" style="float:right;"><% out.print("bienvenido(a): "+session.getAttribute("nombre") );	%></p>
		<form id="logOut" action="Servlet" method="post">
			<input type="hidden" id="accionLogOut" name="accion">
			<br/><span style="float:right;"><a href="#" id="cerrar">Cerrar Sesión</a></span>
		</form>
	</div>
</div>

<div class="contenedor">

	<div id="menuwrapper">	
	    <ul>
	        <li><a href="Servlet?accion=organigrama">Organigrama</a></li>
	        <li><a href="Servlet?accion=documentos">Documentos</a></li>
	        <li><a href="Servlet?accion=empresas">Empresas</a></li>
			<li><a href="#">Reportes</a>
				<ul>
					<li><a href="Servlet?accion=repAccidentados">Accidentados</a></li>
					<li><a href="Servlet?accion=repDias">D&iacute;as Perdidos</a></li>
				</ul>
			</li>
			<li><a href="Servlet?accion=reclamos">Reclamos</a></li>
	        <li><a href="Servlet?accion=graficar">Graficos Prueba</a></li>
	        <li><a href="#">Administraci&oacute;n</a>
	        	<ul>
	        		<li><a href="Servlet?accion=carteras">Tipos de Cartera</a></li>
					<li><a href="Servlet?accion=productos">Productos</a></li>
	        		<li><a href="Servlet?accion=usuarios">Usuarios</a></li>
	        		<li><a href="Servlet?accion=perfiles">Perfiles</a></li>
	        		<li><a href="Servlet?accion=estados">Estados Reclamo</a></li>
					<li><a href="Servlet?accion=medios">Medios</a></li>
					<li><a href="Servlet?accion=motivos">Motivos Reclamo</a></li>
					<li><a href="Servlet?accion=prioridades">Prioridades</a></li>
					<li><a href="Servlet?accion=tipos">Tipos</a></li>
				</ul>
	        </li>
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
					<%--
					<c:when test="${param.accion eq 'perfiles'}">
						<%@ include file="perfiles/listaPerfiles.jsp" %>
					</c:when>
					--%>
					
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
					<c:otherwise></c:otherwise>
				</c:choose>
			</div>
		</form>
	</div>
</div>

<%@ include file="footer.jsp" %>
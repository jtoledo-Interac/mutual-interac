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
	$('#organigrama').click(function(){
		$('.menu-item').removeClass('selected');
		$('#organigrama li').addClass('selected');
		
		$('#accion').val("organigrama");
		$('#formMantenedores').submit();
	});

	$('#documentos').click(function(){
		$('.menu-item').removeClass('selected');
		$('#documentos li').addClass('selected');
		
		$('#accion').val("documentos");
		$('#formMantenedores').submit();
	});
	
	$('#empresas').click(function(){
		$('.menu-item').removeClass('selected');
		$('#empresas li').addClass('selected');
		
		$('#accion').val("empresas");
		$('#formMantenedores').submit();
	});
	
	$('#carteras').click(function(){
		$('.menu-item').removeClass('selected');
		$('#carteras li').addClass('selected');
		
		$('#accion').val("carteras");
		$('#formMantenedores').submit();
	});
	
	$('#productos').click(function(){
		$('.menu-item').removeClass('selected');
		$('#productos li').addClass('selected');
		
		$('#accion').val("productos");
		$('#formMantenedores').submit();
	});
	
	$('#reportes').click(function(){
		$('.menu-item').removeClass('selected');
		$('#reportes li').addClass('selected');
		
		$('#accion').val("reportes");
		$('#formMantenedores').submit();
	});
	
	$('#usuarios').click(function(){
		$('.menu-item').removeClass('selected');
		$('#usuarios li').addClass('selected');
		
		$('#accion').val("usuarios");
		$('#formMantenedores').submit();
	});
	
	$('#reclamos').click(function(){
		$('.menu-item').removeClass('selected');
		$('#reclamos li').addClass('selected');
		
		$('#accion').val("reclamos");
		$('#formMantenedores').submit();
	});
	
	$('#perfiles').click(function(){
		$('.menu-item').removeClass('selected');
		$('#perfiles li').addClass('selected');
		
		$('#accion').val("perfiles");
		$('#formMantenedores').submit();
	});
	
	
	$('#estados').click(function(){
		$('.menu-item').removeClass('selected');
		$('#estados li').addClass('selected');
		
		$('#accion').val("estados");
		$('#formMantenedores').submit();
	});
	
	$('#medios').click(function(){
		$('.menu-item').removeClass('selected');
		$('#medios li').addClass('selected');
		
		$('#accion').val("medios");
		$('#formMantenedores').submit();
	});
	
	$('#motivos').click(function(){
		$('.menu-item').removeClass('selected');
		$('#motivos li').addClass('selected');
		
		$('#accion').val("motivos");
		$('#formMantenedores').submit();
	});
	
	$('#prioridades').click(function(){
		$('.menu-item').removeClass('selected');
		$('#prioridades li').addClass('selected');
		
		$('#accion').val("prioridades");
		$('#formMantenedores').submit();
	});
	
	$('#tipos').click(function(){
		$('.menu-item').removeClass('selected');
		$('#tipos li').addClass('selected');
		
		$('#accion').val("tipos");
		$('#formMantenedores').submit();
	});
	
	$('#grafico').click(function(){
		$('.menu-item').removeClass('selected');
		$('#grafico li').addClass('selected');
		
		$('#accion').val("graficar");
		$('#formMantenedores').submit();
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

	<div class="menu-lateral">
		<ul class="lista-items">
			<a href="#" id="organigrama"><li class="menu-item">ORGANIGRAMA</li></a>
			<a href="#" id="documentos"><li class="menu-item">DOCUMENTOS</li></a>
			<a href="#" id="empresas"><li class="menu-item">EMPRESAS</li></a>
			<a href="#" id="carteras"><li class="menu-item">CARTERAS</li></a>
			<a href="#" id="productos"><li class="menu-item">PRODUCTOS</li></a>
			<!--  <a href="#" id="reportes"><li class="menu-item">REPORTES</li></a>-->
			<a href="#" id="usuarios"><li class="menu-item">USUARIOS</li></a>
			<a href="#" id="reclamos"><li class="menu-item">RECLAMOS</li></a>
			
			<a href="#" id="estados"><li class="menu-item">ESTADOS</li></a>
			<a href="#" id="medios"><li class="menu-item">MEDIOS</li></a>
			<a href="#" id="motivos"><li class="menu-item">MOTIVOS</li></a>
			<a href="#" id="prioridades"><li class="menu-item">PRIORIDADES</li></a>
			<a href="#" id="tipos"><li class="menu-item">TIPOS</li></a>
			
			<!-- <a href="#" id="perfiles"><li class="menu-item">PERFILES</li></a> -->
			<a href="#" id="grafico"> <li class="menu-item">gráfico prueba</li></a>
		</ul>
	</div>
	
	<div class="principal">
		<form id="formMantenedores" action="Servlet" method="post">
			<input type="hidden" id="accion" name="accion">
			
			<div class="listas">
				<c:choose>
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
					<%--
					<c:when test="${param.accion eq 'motivos'}">
						<%@ include file="motivos/listaMotivos.jsp" %>
					</c:when>
					 -->
						<%-- PRODUCTOS --%>
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
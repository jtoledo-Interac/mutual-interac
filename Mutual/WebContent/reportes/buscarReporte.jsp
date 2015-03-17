<%@ include file="../declaraciones.jsp" %>
<%@ include file="../encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<div class="mantenedor">
	<div id="buscarEmpresa" title="Buscar Empresa" style="display:none"></div>
	<div class="filtros">
		<input type="button" 	id="btnBuscar" 		name="btnBuscar" 	value="Buscar" class="boton"/>
		<input type="text" 		id="nomEmpresa" 	name="nomEmpresa"	placeholder="Nombre Empresa" class="text">
	</div>
</div>
<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaUsuarios}" var="usuario">
        <fila>
        	<idUsuario>${usuario.nIdUsuario}</idUsuario>
        	<rut>${usuario.sRutFormat}</rut>
        	<nombre>${usuario.sNombres} ${usuario.sApePaterno} ${usuario.sApeMaterno}</nombre>
        	<nomUsuario>${usuario.sNomUsuario}</nomUsuario>
        	<email>${usuario.sEmail}</email>
        	<telefono>${usuario.sTelefono}</telefono>
        	<celular>${usuario.sCelular}</celular>
        </fila>
     </c:forEach>
</filas>
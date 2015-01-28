<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaUsuarios}" var="usuario">
        <fila>
        	<idUsuario>${usuario.idUsuario}</idUsuario>
        	<rut>${usuario.rutFormat}</rut>
        	<nombre>${usuario.nombres} ${usuario.apePaterno} ${usuario.apeMaterno}</nombre>
        	<nomUsuario>${usuario.nomUsuario}</nomUsuario>
        	<email>${usuario.email}</email>
        	<telefono>${usuario.telefono}</telefono>
        	<celular>${usuario.celular}</celular>
        </fila>
     </c:forEach>
</filas>
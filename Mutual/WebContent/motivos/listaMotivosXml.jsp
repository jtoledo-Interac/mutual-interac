<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaMotivos}" var="motivo">
        <fila>
        	<idMotivo>${motivo.idMotivo}</idMotivo>
        	<desMotivo>${motivo.desMotivo}</desMotivo>
        </fila>
     </c:forEach>
</filas>
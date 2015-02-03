<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaEstados}" var="estado">
        <fila>
        	<codEstado>${estado.codEstado}</codEstado>
        	<desEstado>${estado.desEstado}</desEstado>
        </fila>
     </c:forEach>
</filas>
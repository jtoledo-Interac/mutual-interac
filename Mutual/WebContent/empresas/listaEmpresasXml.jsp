<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaEmpresas}" var="empresa">
        <fila>
        	<codEmpresa>${empresa.codEmpresa}</codEmpresa>
        	<desEmpresa>${empresa.desEmpresa}</desEmpresa>
        </fila>
     </c:forEach>
</filas>
<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaLinks}" var="link">
        <fila>
        	<idLink>${link.idLink}</idLink>
        	<idCategoriaLink>${link.idCategoriaLink}</idCategoriaLink>
        	<urlLink><a href='${link.urlLink}'>${link.urlLink}</a></urlLink>
        	<desLink>${link.desLink}</desLink>
        	<desCategoriaLink>${link.desCategoriaLink}</desCategoriaLink>
        </fila>
     </c:forEach>
</filas>
<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaProductos}" var="producto">
        <fila>
        	<codProducto>${producto.codProducto}</codProducto>
        	<desProducto>${producto.desProducto}</desProducto>
        </fila>
     </c:forEach>
</filas>
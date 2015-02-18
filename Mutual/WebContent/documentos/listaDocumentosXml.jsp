<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaDocumentos}" var="documento">
    	<fila>
       		<idDocumento>${documento.idDocumento}</idDocumento>
       		<numAdherente>${documento.numAdherente}</numAdherente>
       		<numFolio>${documento.numFolio}</numFolio>
       		<nombre>${documento.nombre}</nombre>
       		<desCartera>${documento.desCartera}</desCartera>
       		<desProducto>${documento.desProducto}</desProducto>
       		<fecCreacion>${documento.fecCreacion}</fecCreacion>
       		<desArea>${documento.desArea}</desArea>
       </fila>
	</c:forEach>
</filas>
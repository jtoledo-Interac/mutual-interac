<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaReclamos}" var="reclamo">
    	<fila>
       		<idReclamo>${reclamo.idReclamo}</idReclamo>
       		<numAdherente>${reclamo.numAdherente}</numAdherente>
       		<numFolio>${reclamo.numFolio}</numFolio>
       		<nombre>${reclamo.nombre}</nombre>
       		<desCartera>${reclamo.desCartera}</desCartera>
       		<desProducto>${reclamo.desProducto}</desProducto>
       		<fecCreacion>12/12/2014</fecCreacion>
       		<desArea>${reclamo.desArea}</desArea>
       </fila>
	</c:forEach>
</filas>
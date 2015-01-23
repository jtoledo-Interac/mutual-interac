<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaReclamos}" var="reclamo">
    	<fila>
       		<idReclamo>${reclamo.idReclamo}</idReclamo>
       		<numAdherente>${reclamo.numAdherente}</numAdherente>
       		<nombreSolicitante>${reclamo.nombreSolicitante}</nombreSolicitante>
       		<codTipo>${reclamo.codTipo}</codTipo>
       		<codMotivo>${reclamo.codMotivo}</codMotivo>
			<codMedio>${reclamo.codMedio}</codMedio>
       		<codEstado>${reclamo.codEstado}</codEstado>
       		<codPrioridad>${reclamo.codPrioridad}</codPrioridad>
       		<diasSistema>${reclamo.diasSistema}</diasSistema>
       		<diasBandeja>${reclamo.diasBandeja}</diasBandeja>
       </fila>
	</c:forEach>
</filas>
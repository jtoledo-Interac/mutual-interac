<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<filas>
    <c:forEach items="${requestScope.listaReclamos}" var="reclamo">
    	<fila>
       		<idReclamo>${reclamo.idReclamo}</idReclamo>
       		<numAdherente>${reclamo.numAdherente}</numAdherente>
       		<nombreSolicitante>${reclamo.nombreSolicitante}</nombreSolicitante>
       		<desTipo>${reclamo.desTipo}</desTipo>
       		<desMotivo>${reclamo.desMotivo}</desMotivo>
			<desMedio>${reclamo.desMedio}</desMedio>
       		<desEstado>${reclamo.desEstado}</desEstado>
       		<desPrioridad>${reclamo.desPrioridad}</desPrioridad>
       		<diasSistema>${reclamo.diasSistema}</diasSistema>
       		<diasBandeja>${reclamo.diasBandeja}</diasBandeja>
       </fila>
	</c:forEach>
</filas>
<%@ page language="java"%>
<%@ include file="declaraciones.jsp" %>
<%@ include file="encabezado.jsp" %>

<% 	out.println(request.getAttribute("msgHeader")); 
	out.println(request.getAttribute("msgBody"));
%>

<a href="<%out.println(request.getAttribute("msgRedirect"));%>">OK :-)</a>
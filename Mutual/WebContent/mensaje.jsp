<%@ page language="java"%>
<%@ include file="declaraciones.jsp" %>
<%@ include file="encabezado.jsp" %>

<% 	out.println("<h2>" + request.getAttribute("msgHeader") + "</h2><hr>"); 
	out.println(request.getAttribute("msgBody"));
%>

<br><br>
<center><a href="${msgRedirect}" style="color:#000000">OK :-)</a></center>
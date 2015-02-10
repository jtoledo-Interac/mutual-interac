<%
if( session.getAttribute("user")== null){
	response.sendRedirect("login.jsp");
}
java.util.ArrayList<String> p = (java.util.ArrayList<String>)session.getAttribute("perfiles");
if(!p.contains("admin"))
	response.sendRedirect("../login.jsp");
%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%
if( session.getAttribute("user")== null){
	response.sendRedirect("login.jsp");
}
java.util.ArrayList<String> p = (java.util.ArrayList<String>)session.getAttribute("perfiles");
if(!p.contains("admin"))
	response.sendRedirect("../login.jsp");
%>
<script type="text/javascript">
  //$('select').select2();
</script>
<form id="formAgrega" action="Servlet" method="post">
	<input type="hidden"	class="input"	id="accion" 		name="accion" 		value="agregarProducto">
	<input type="submit" class="submit" style="display:none;">
	<input type="text" 		id="desProducto" 	name="desProducto"		placeholder="Tipo de Documento" required>
</form>
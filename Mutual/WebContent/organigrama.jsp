<%@ include file="declaraciones.jsp" %>
<%@ include file="encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

</script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="./js/papaparse.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="./js/libs.js"></script>

<link rel = "stylesheet" type = "text/css" href = "./css/styles.css" />
<link rel = "stylesheet" type = "text/css" href = "./css/jquery-ui.css" />
<script type="text/javascript" src="./js/jquery-ui.js"></script>


<div class="mantenedor">
	<div class="organigrama">
		<!--  <img src="img/organigrama.png"> -->
		<div id='columnchart'></div>
		<div id="dialog-modal" title = "Detailed information" align="center"  style="display: none;">
			<img id = "image_detail_info" class = "img_detail_info" src = "" />
			<div id = "employee" class = "employee_text" ></div>
			<div id = "employee_position" class = "employee_position_text" ></div>
		</div>
	</div>
</div>
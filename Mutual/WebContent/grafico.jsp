<%@ page language="java"%>
<%@ include file="declaraciones.jsp" %>
<%@ include file="encabezado.jsp" %>

<%
	Object[][] prueba = {{"dato","valor"},{1,1000},{2,5000},{3,9000},{4,2350},{1,4280000}};
	
%>


<div style="width: 50%">
	<canvas id="canvas" height="450" width="600"></canvas>
</div>
<script>
var barData = {
		labels:["Hola","Chao"],
		datasets :[
	        {
		       	fillColor : "rgba(220,220,220,0.5)",
				strokeColor : "rgba(220,220,220,0.8)",
				highlightFill: "rgba(220,220,220,0.75)",
				highlightStroke: "rgba(220,220,220,1)",
				data : [300,127]
        	},
        	{
		       	fillColor : "rgba(220,220,220,0.5)",
				strokeColor : "rgba(220,220,220,0.8)",
				highlightFill: "rgba(220,220,220,0.75)",
				highlightStroke: "rgba(220,220,220,1)",
				data : [295,155]
        	}
		]
	}
	window.onload = function(){
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myBar = new Chart(ctx).Bar(barChartData, {
			responsive : true
		});
	}
</script>

</body>
</html>
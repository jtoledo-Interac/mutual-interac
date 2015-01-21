
<div style="width: 50%">
	Población chilena por regiones
	<canvas id="canvas" height="450" width="600"></canvas>
</div>

<script>
	var etiquetas = [];
	var datos =[];
	<%
		String[] arreglo = (String[])request.getAttribute("etiquetas");
		for(int i=0;i<arreglo.length;i++){
			%>etiquetas[<%=i%>] = "<%=arreglo[i]%>";<%
		}
		arreglo = (String[])request.getAttribute("datos");
		for(int i=0;i<arreglo.length;i++){
			%>datos[<%=i%>] = "<%=arreglo[i]%>";<%
		}
	%>
	var barData = {
		labels: etiquetas,
		datasets :[
	        {
		       	fillColor : "rgba(220,220,220,0.5)",
				strokeColor : "rgba(220,220,220,0.8)",
				highlightFill: "rgba(220,220,220,0.75)",
				highlightStroke: "rgba(220,220,220,1)",
				data : datos
        	},
		]
	}
	window.onload = function(){
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myBar = new Chart(ctx).Bar(barData, {
			responsive : true
		});
	}
</script>
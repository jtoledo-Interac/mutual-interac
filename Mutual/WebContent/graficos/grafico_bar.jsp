
<div style="width: 50%">
	Población chilena por regiones
	<canvas id="canvas" height="450" width="600"></canvas>
</div>

<script>
	var etiquetas = [];
	var datos = [];
	<%
		String[] d = (String[])request.getAttribute("etiquetas");
		for(int i=1;i<d.length;i++){%>etiquetas[<%=i-1%>] = "<%=d[i]%>";<%}
		d = (String[])request.getAttribute("datos");
		for(int i=1;i<d.length;i++){%>datos[<%=i-1%>] = "<%=d[i]%>";<%}
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
        	}
		]
	}
	window.onload = function(){
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myBar = new Chart(ctx).Bar(barData, {
			responsive : true
		});
	}
</script>
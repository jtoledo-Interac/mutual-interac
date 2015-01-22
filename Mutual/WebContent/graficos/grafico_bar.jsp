
<div style="width: 50%">
	Población chilena por regiones
	<canvas id="canvas" height="450" width="600"></canvas>
</div>

<h2>Otro ...</h2>
<div id="canvas-holder" style="width:5%">
	
	<canvas id="chart-area" width="500" height="500"/>
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
				fillColor : "rgba(151,187,205,0.5)",
				strokeColor : "rgba(151,187,205,0.8)",
				highlightFill : "rgba(151,187,205,0.75)",
				highlightStroke : "rgba(151,187,205,1)",
		       	data : datos
        	}
		]
	}
	
	var doughnutData = [
				{
					value: 300,
					color:"#F7464A",
					highlight: "#FF5A5E",
					label: "Red"
				},
				{
					value: 50,
					color: "#46BFBD",
					highlight: "#5AD3D1",
					label: "Green"
				},
				{
					value: 100,
					color: "#FDB45C",
					highlight: "#FFC870",
					label: "Yellow"
				},
				{
					value: 40,
					color: "#949FB1",
					highlight: "#A8B3C5",
					label: "Grey"
				},
				{
					value: 120,
					color: "#4D5360",
					highlight: "#616774",
					label: "Dark Grey"
				}

			];

			
	window.onload = function(){
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myBar = new Chart(ctx).Bar(barData, {
			responsive : true
		});
		var ctx2 = document.getElementById("chart-area").getContext("2d");
		window.myDoughnut = new Chart(ctx2).Doughnut(doughnutData, {responsive : true});
	};
</script>



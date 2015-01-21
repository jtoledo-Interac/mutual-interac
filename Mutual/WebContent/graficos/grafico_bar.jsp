
<div style="width: 50%">
	Población chilena por regiones
	<canvas id="canvas" height="450" width="600"></canvas>
</div>

<script>
	var hola = [239126, 336769, 622640, 312486, 771085, 1825757, 7314176, 918751, 1042989, 2114286, 989798, 40432, 841123, 164661, 108328,];
	var barData = {
		labels:["XV - Arica y Parinacota", "I - Tarapacá", "II - Antofagasta","III - Atacama",
		        "IV - Coquimbo", "V - Valparaíso","RM - Metropolitana" ,"VI - O'Higgins",
		        "VII - Maule", "VIII - Biobío", "IX - Araucanía", "XIV - Los Riíos", "X - Los Lagos",
		        "XI - Aysén", "XII - Magallanes"],
		datasets :[
	        {
		       	fillColor : "rgba(220,220,220,0.5)",
				strokeColor : "rgba(220,220,220,0.8)",
				highlightFill: "rgba(220,220,220,0.75)",
				highlightStroke: "rgba(220,220,220,1)",
				data : hola
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
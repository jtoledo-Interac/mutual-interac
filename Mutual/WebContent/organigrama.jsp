<%@ include file="declaraciones.jsp" %>
<%@ include file="encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<script type="text/javascript"> 

</script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["orgchart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('string', 'Manager');
        data.addColumn('string', 'ToolTip');

       data.addRows([
			[{v:'CARLA MARIMAN IBARRA', f:'CARLA MARIMAN IBARRA<div style="color:red; font-style:italic">GERENTE DE CLIENTES<div>'}, '', ''],
			[{v:'WISMI VISCARRA HELLIE', f:'WISMI VISCARRA HELLIE<div style="color:red; font-style:italic">ASISTENTE<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'MARIA ALEJANDRA CARIS E.', f:'MARIA ALEJANDRA CARIS E.<div style="color:red; font-style:italic">INGENIERO DE PROYECTOS<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'JOHANNA QUIROZ RODRIGUEZ', f:'JOHANNA QUIROZ RODRIGUEZ<div style="color:red; font-style:italic">MULTIREGIONAL<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'SELVA DANYAU ISLA', f:'SELVA DANYAU ISLA<div style="color:red; font-style:italic">ENFERMERA COORDINADORA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'ANA MARISOL ROSALES LECAROS', f:'ANA MARISOL ROSALES LECAROS<div style="color:red; font-style:italic">ENFERMERA COORDINADORA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'XIMENA ROJAS', f:'XIMENA ROJAS<div style="color:red; font-style:italic">GESTOR COMERCIAL <div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'MANUEL MENA JORQUERA', f:'MANUEL MENA JORQUERA<div style="color:red; font-style:italic">PSICOLOGO GERENCIA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'ANGELICA ZELAYA AHUMADA', f:'ANGELICA ZELAYA AHUMADA<div style="color:red; font-style:italic">DIRECTOR DE CARTERA TRANSPORTE PÚBLICO<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'FRANCISCO FAJARDO ALARCON', f:'FRANCISCO FAJARDO ALARCON<div style="color:red; font-style:italic">EXPERTO<div>'}, 'ANGELICA ZELAYA AHUMADA', ''],
			[{v:'MARIA ANGELICA ACEVEDO ZUÑIGA', f:'MARIA ANGELICA ACEVEDO ZUÑIGA<div style="color:red; font-style:italic">EXPERTO<div>'}, 'ANGELICA ZELAYA AHUMADA', ''],
			[{v:'CRISTIAN LEIVA MEDINA', f:'CRISTIAN LEIVA MEDINA<div style="color:red; font-style:italic">EXPERTO<div>'}, 'ANGELICA ZELAYA AHUMADA', ''],
			[{v:'VERONICA BUSTOS GARRIDO', f:'VERONICA BUSTOS GARRIDO<div style="color:red; font-style:italic">EXPERTO<div>'}, 'ANGELICA ZELAYA AHUMADA', ''],
			[{v:'MAURICIO HERRERA BRAVO', f:'MAURICIO HERRERA BRAVO<div style="color:red; font-style:italic">DIRECTOR DE CARTERA TRANSPORTE DE PERSONAS <div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'JULIO TOLOZA SAEZ', f:'JULIO TOLOZA SAEZ<div style="color:red; font-style:italic">EXPERTO<div>'}, 'MAURICIO HERRERA BRAVO', ''],
			[{v:'JOSE MIGUEL MONTENEGRO LILLO', f:'JOSE MIGUEL MONTENEGRO LILLO<div style="color:red; font-style:italic">EXPERTO<div>'}, 'MAURICIO HERRERA BRAVO', ''],
			[{v:'CARLOS VERA ESPINOZA', f:'CARLOS VERA ESPINOZA<div style="color:red; font-style:italic">EXPERTO<div>'}, 'MAURICIO HERRERA BRAVO', ''],
			[{v:'NATALIA URREA SOTO', f:'NATALIA URREA SOTO<div style="color:red; font-style:italic">DIRECTOR DE CARTERA TRANSPORTE DE CARGA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'FRANCO ALIAGA GALVEZ', f:'FRANCO ALIAGA GALVEZ<div style="color:red; font-style:italic">EXPERTO<div>'}, 'NATALIA URREA SOTO', ''],
			[{v:'HUGO HERNANDEZ MIRANDA', f:'HUGO HERNANDEZ MIRANDA<div style="color:red; font-style:italic">EXPERTO<div>'}, 'NATALIA URREA SOTO', ''],
			[{v:'ELIANA CONTRERAS ROMAN', f:'ELIANA CONTRERAS ROMAN<div style="color:red; font-style:italic">EXPERTO<div>'}, 'NATALIA URREA SOTO', ''],
			[{v:'MICHAEL SWANECK S.', f:'MICHAEL SWANECK S.<div style="color:red; font-style:italic">DIRECTOR CARTERA TELECOMUNICACIONES Y ENERGÍA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'XIMENA ALFARO SANCHEZ', f:'XIMENA ALFARO SANCHEZ<div style="color:red; font-style:italic">EXPERTO<div>'}, 'MICHAEL SWANECK S.', ''],
			[{v:'FRANCISCO VALENCIA  HERNANDEZ', f:'FRANCISCO VALENCIA  HERNANDEZ<div style="color:red; font-style:italic">EXPERTO<div>'}, 'MICHAEL SWANECK S.', ''],
			[{v:'JAIME SOTO ORTEGA', f:'JAIME SOTO ORTEGA<div style="color:red; font-style:italic">EXPERTO<div>'}, 'MICHAEL SWANECK S.', '']
	
        ]);

        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
        chart.draw(data, {allowHtml:true});
      }
   </script>


<div class="mantenedor">
	<div class="organigrama">
		<div id="chart_div" style="overflow: scroll; padding: 10px;"></div>
	</div>
</div>
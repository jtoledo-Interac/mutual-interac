<%@ include file="declaraciones.jsp" %>
<%@ include file="encabezado.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@page import="com.google.gson.Gson"%>
<%@page import="cl.antartis.interac.beans.OrgEntry"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript"> 

</script>
<style>
.maman {
	border: 1px solid #BBB;
	text-align: center;
	background: rgba(170,200,50,0.5);
	border-radius: 5px;
	margin: 5px;
}
</style>
<!--<script type="text/javascript" src="https://www.google.com/jsapi"></script>-->
<script src="js/jsapi.js"></script>
	<script type="text/javascript">
		function
	</script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["orgchart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('string', 'Manager');
        data.addColumn('string', 'ToolTip');

       data.addRows([
			[{v:'CARLA MARIMAN IBARRA', f:'<div style="color:black; font-style:bold">CARLA MARIMAN IBARRA</div><div style="color:#555555; font-style:italic">GERENTE DE CLIENTES<div>'}, '', ''],
			[{v:'WISMI VISCARRA HELLIE', f:'<div style="color:black; font-style:bold">WISMI VISCARRA HELLIE</div><div style="color:#555555; font-style:italic">ASISTENTE<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'MARIA ALEJANDRA CARIS E.', f:'<div style="color:black; font-style:bold">MARIA ALEJANDRA CARIS E.</div><div style="color:#555555; font-style:italic">INGENIERO DE PROYECTOS<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'JOHANNA QUIROZ RODRIGUEZ', f:'<div style="color:black; font-style:bold">JOHANNA QUIROZ RODRIGUEZ</div><div style="color:#555555; font-style:italic">MULTIREGIONAL<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'SELVA DANYAU ISLA', f:'<div style="color:black; font-style:bold">SELVA DANYAU ISLA</div><div style="color:#555555; font-style:italic">ENFERMERA COORDINADORA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'ANA MARISOL ROSALES LECAROS', f:'<div style="color:black; font-style:bold">ANA MARISOL ROSALES LECAROS</div><div style="color:#555555; font-style:italic">ENFERMERA COORDINADORA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'XIMENA ROJAS', f:'<div style="color:black; font-style:bold">XIMENA ROJAS</div><div style="color:#555555; font-style:italic">GESTOR COMERCIAL <div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'MANUEL MENA JORQUERA', f:'<div style="color:black; font-style:bold">MANUEL MENA JORQUERA</div><div style="color:#555555; font-style:italic">PSICOLOGO GERENCIA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'ANGELICA ZELAYA AHUMADA', f:'<div style="color:black; font-style:bold">ANGELICA ZELAYA AHUMADA</div><div style="color:#555555; font-style:italic">DIRECTOR DE CARTERA TRANSPORTE PÚBLICO<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'FRANCISCO FAJARDO ALARCON', f:'<div style="color:black; font-style:bold">FRANCISCO FAJARDO ALARCON</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'ANGELICA ZELAYA AHUMADA', ''],
			[{v:'MARIA ANGELICA ACEVEDO ZUÑIGA', f:'<div style="color:black; font-style:bold">MARIA ANGELICA ACEVEDO ZUÑIGA</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'ANGELICA ZELAYA AHUMADA', ''],
			[{v:'CRISTIAN LEIVA MEDINA', f:'<div style="color:black; font-style:bold">CRISTIAN LEIVA MEDINA</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'ANGELICA ZELAYA AHUMADA', ''],
			[{v:'VERONICA BUSTOS GARRIDO', f:'<div style="color:black; font-style:bold">VERONICA BUSTOS GARRIDO</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'ANGELICA ZELAYA AHUMADA', ''],
			[{v:'MAURICIO HERRERA BRAVO', f:'<div style="color:black; font-style:bold">MAURICIO HERRERA BRAVO</div><div style="color:#555555; font-style:italic">DIRECTOR DE CARTERA TRANSPORTE DE PERSONAS <div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'JULIO TOLOZA SAEZ', f:'<div style="color:black; font-style:bold">JULIO TOLOZA SAEZ</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'MAURICIO HERRERA BRAVO', ''],
			[{v:'JOSE MIGUEL MONTENEGRO LILLO', f:'<div style="color:black; font-style:bold">JOSE MIGUEL MONTENEGRO LILLO</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'MAURICIO HERRERA BRAVO', ''],
			[{v:'CARLOS VERA ESPINOZA', f:'<div style="color:black; font-style:bold">CARLOS VERA ESPINOZA</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'MAURICIO HERRERA BRAVO', ''],
			[{v:'NATALIA URREA SOTO', f:'<div style="color:black; font-style:bold">NATALIA URREA SOTO</div><div style="color:#555555; font-style:italic">DIRECTOR DE CARTERA TRANSPORTE DE CARGA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'FRANCO ALIAGA GALVEZ', f:'<div style="color:black; font-style:bold">FRANCO ALIAGA GALVEZ</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'NATALIA URREA SOTO', ''],
			[{v:'HUGO HERNANDEZ MIRANDA', f:'<div style="color:black; font-style:bold">HUGO HERNANDEZ MIRANDA</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'NATALIA URREA SOTO', ''],
			[{v:'ELIANA CONTRERAS ROMAN', f:'<div style="color:black; font-style:bold">ELIANA CONTRERAS ROMAN</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'NATALIA URREA SOTO', ''],
			[{v:'MICHAEL SWANECK S.', f:'<div style="color:black; font-style:bold">MICHAEL SWANECK S.</div><div style="color:#555555; font-style:italic">DIRECTOR CARTERA TELECOMUNICACIONES Y ENERGÍA<div>'}, 'CARLA MARIMAN IBARRA', ''],
			[{v:'XIMENA ALFARO SANCHEZ', f:'<div style="color:black; font-style:bold">XIMENA ALFARO SANCHEZ</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'MICHAEL SWANECK S.', ''],
			[{v:'FRANCISCO VALENCIA  HERNANDEZ', f:'<div style="color:black; font-style:bold">FRANCISCO VALENCIA  HERNANDEZ</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'MICHAEL SWANECK S.', ''],
			[{v:'JAIME SOTO ORTEGA', f:'<div style="color:black; font-style:bold">JAIME SOTO ORTEGA</div><div style="color:#555555; font-style:italic">EXPERTO<div>'}, 'MICHAEL SWANECK S.', '']
	
        ]);

        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
        chart.draw(data, {allowHtml:true, nodeClass:'maman'});
        
      }
   </script>


<div class="mantenedor">
	<div class="organigrama">
		<div id="chart_div" style="overflow: scroll; padding: 10px;"></div>
		<!-- ENTRIES!!!!  -->
		<!-- <c:forEach items="${OrgEntries}" var="oEntry"> -->
		<!-- 			<option value="${oEntry.nombre}" >${oEntry.cargo}</option> -->
		<!-- </c:forEach> -->
	</div>
</div>
<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage="/error.jsp"%>
<%@ page import="mcm.dao.*"%>
<%@ page import="mcm.dto.*"%>
<%@ page import="mcm.constant.*"%>
<%!ContextDAO contextDAO = new ContextDAO();%>
<%
	MemberDTO memberDTO = (MemberDTO) session
			.getAttribute("MEMBER_INFO");
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mobile Context Monitor</title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/dojo/dijit/themes/claro/claro.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/dojo/dojox/widget/Portlet/Portlet.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/dojo/dojox/layout/resources/GridContainer.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/dojo/dojox/widget/Calendar/Calendar.css" />
<link href="../css/3DGraph.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.dndDropIndicator {
	border: 2px dashed #99BBE8;
	cursor: default;
	margin-bottom: 5px
}

.gridContainerTable {
	width: 100%;
	border: 0px solid #BFBFBF;
}

.claro .dijitContentPane {
	padding: 0px;
	border: 0px solid #BFBFBF;
}

.gridContainerZone,.gridContainer {
	border: 0px solid #BFBFBF;
}
</style>
<script src="../lib/dojo/dojo/dojo.js"
	data-dojo-config="isDebug: true, parseOnLoad: true"></script>
<script src="../lib/RGraph/RGraph.common.core.js"></script>
<script src="../lib/RGraph/RGraph.common.context.js"></script>
<script src="../lib/RGraph/RGraph.common.annotate.js"></script>
<script src="../lib/RGraph/RGraph.common.tooltips.js"></script>
<script src="../lib/RGraph/RGraph.common.zoom.js"></script>
<script src="../lib/RGraph/RGraph.common.resizing.js"></script>
<script src="../lib/RGraph/RGraph.line.js"></script>
<script src="../lib/RGraph/RGraph.hprogress.js"></script>
<script src="../lib/json2.js"></script>
<script type="text/javascript"
	src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript" src="../js/Graph3D.js"></script>
<script type="text/javascript" src="../js/ProgressGraph.js"></script>
<script type="text/javascript" src="../js/Map.js"></script>
<script type="text/javascript" src="../js/ProximityFigure.js"></script>
<script type="text/javascript" src="../js/Cube3D.js"></script>
<script type="text/javascript">
	/************************************************************/
	dojo.require("dijit.dijit");
	dojo.require("dijit.layout.BorderContainer");
	dojo.require("dijit.layout.TabContainer");
	dojo.require("dijit.layout.ContentPane");
	dojo.require("dojox.widget.Portlet");
	dojo.require("dojox.widget.FeedPortlet");
	dojo.require("dojox.layout.GridContainer");
	dojo.require("dojox.widget.Calendar");
	/************************************************************/
	/************************************************************/
	function getContext() {
		var httpRequest = null;
		if (window.XMLHttpRequest)
			httpRequest = new XMLHttpRequest();
		// else if (window.ActiveXObject) var httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
		httpRequest.onreadystatechange = function() {
			if (httpRequest.readyState == 4 && httpRequest.status == 200) {
				//document.getElementById("v").innerHTML += json.id;
				var jsons = eval('(' + this.responseText + ')');
				for ( var i = 0; jsons.length; i++) {
					var json = jsons[i];
					var sensorType = json.sensor_type;
					switch (sensorType) {
					case 0:
						drawMap(json.value0, json.value1);
						break;
					case 1:
						accelerometerGraph.draw(json.value0, json.value1, json.value2);
						break;
					case 10:
						linearAccelerationGraph.draw(json.value0, json.value1, json.value2);
						break;
					case 5:
						//values[sensorType][0] = json.value0;
						//redrawGraph(sensorType);
						//drawProgressGraph("graph5", "lux", [300,700,1000], ['brown', 'orange', 'yellow', 'red'], 2000, json.value0);
						lightGraph.draw(json.value0);
						break;
					/* case 6:
						//drawProgressGraph("graph6", "Pa", [100,500,1000], ['green', 'blue', 'orange', 'red'], 20000, json.value0);
						pressureGraph.draw(json.value0);
						break;
					case 7:
						//drawProgressGraph("graph7", "°C", [100,500,1000], ['green', 'blue', 'orange', 'red'], 100, json.value0);
						temperatureGraph.draw(json.value0);
						break; */
					case 8:
						//drawProgressGraph("graph8", "cm", [100,500,1000], ['green', 'blue', 'orange', 'red'], 10, json.value0);
						proximityFigure.draw(json.value0);
						break;
					case 11:
						/* rotationVectorCube.draw(json.value0, json.value1,
								json.value2); */
						break;
					case 3:
						orientationCube.draw(json.value0, json.value1,
								json.value2);
						break;
					default:
						/* values[sensorType][0].push(json.value0);
						values[sensorType][1].push(json.value1);
						values[sensorType][2].push(json.value2);
						redrawGraph(sensorType); */
						break;
					}
				}
			}
		};
		httpRequest.open('GET', "/MobileContextMonitor/ContextRetriever", true);
		httpRequest.send();
	}
	/************************************************************/
	var sleepTime = 300;
	function run() {
		getContext();
		setTimeout(run, sleepTime);
	}
	/************************************************************/
	function resize() {
		/* var big = window.innerWidth/2-window.innerWidth/30;
		var small = big/2-big/30;
		map_canvas.width = big;
		graph1.width = big;
		graph2.width = big;
		graph3.width = big;
		graph4.width = big;
		graph5.width = small;
		graph6.width = small;
		graph7.width = small;
		graph8.width = small;
		graph9.width = big;
		graph10.width = big;
		graph11.width = big;
		 */

		graph1.width = document.getElementById("container1").offsetWidth / 1.1;
		graph2.width = document.getElementById("container2").offsetWidth / 1.1;
		graph3.width = document.getElementById("container3").offsetWidth / 1.1;
		graph4.width = document.getElementById("container4").offsetWidth / 1.1;
		graph5.width = document.getElementById("container5").offsetWidth / 1.1;
		/* graph6.width = document.getElementById("container6").offsetWidth / 1.1;
		graph7.width = document.getElementById("container7").offsetWidth / 1.1; */
		graph8.width = document.getElementById("container8").offsetWidth / 1.1;
		graph9.width = document.getElementById("container9").offsetWidth / 1.1;
		graph10.width = document.getElementById("container10").offsetWidth / 1.1;
		/* graph11.width = document.getElementById("container11").offsetWidth / 1.1; */
	}
	var proximityFigure = null;
	var lightGraph = null;
	/* var temperatureGraph = null;
	var pressureGraph = null; */
	var rotationVectorCube = null;
	var orientationCube = null;
	var accelerometerGraph = null;
	var linearAccelerationGraph = null;
	function init() {
		drawMap();
		// See 3DGraph.js
		//draw3DGraph("graph1");
		accelerometerGraph = new Graph3D("graph1", "A", "m/s^2", 15);
		accelerometerGraph.draw();
		linearAccelerationGraph = new Graph3D("graph10", "A", "m/s^2", 15);
		linearAccelerationGraph.draw();
		// See progressGraph.js
		/* drawProgressGraph("graph5", "lux", [100,500,1000], ['green', 'blue', 'orange', 'red'], 5000);
		drawProgressGraph("graph6", "Pa", [100,500,1000], ['green', 'blue', 'orange', 'red'], 20000);
		drawProgressGraph("graph7", "°C", [100,500,1000], ['green', 'blue', 'orange', 'red'], 100);
		 */
		//drawProgressGraph("graph8", "cm", [100,500,1000], ['green', 'blue', 'orange', 'red'], 10);
		proximityFigure = new ProximityFigure("graph8", 10);
		proximityFigure.draw(0);
		lightGraph = new ProgressGraph("graph5", "lux", 2000, [ '#E8E773',
				'#FFE800', '#FFCC00', '#FFA215', '#E81B05' ]);
		lightGraph.draw(0);
		/* pressureGraph = new ProgressGraph("graph6", "Pa", 20000, [ '#E8E773',
				'#FFE800', '#FFCC00', '#FFA215', '#E81B05' ]);
		pressureGraph.draw(0);
		temperatureGraph = new ProgressGraph("graph7", "°C", 100, [ '#E8E773',
				'#FFE800', '#FFCC00', '#FFA215', '#E81B05' ]);
		temperatureGraph.draw(0); */
		//rotationVectorCube = new Cube3D("graph11");
		//rotationVectorCube.draw(0, 0, 0);
		orientationCube = new Cube3D("graph3");
		orientationCube.draw(0, 0, 0);
	}

	/************************************************************/
	window.onresize = resize;
	window.onload = function() {
		resize();
		init();
		run();
	};
	/************************************************************/
	/************************************************************/
	/************************************************************/
	/************************************************************/
	/************************************************************/
	/************************************************************/
</script>
</head>
<body class=" claro " style="margin-top: 0px">
	<jsp:include page="../menu.jsp" />
	<div id="content" class="  center shadow background-white ">
		<div dojoType="dijit.layout.ContentPane" region="center">
			<div dojoType="dojox.layout.GridContainer" id="rootContainer"
				hasResizableColumns="false" opacity="0.3" nbZones="3"
				isAutoOrganized="true" allowAutoScroll="false" withHandles="true"
				handleClasses="dijitTitlePaneTitle" region="center"
				minChildWidth="0" minColWidth="0" isLayoutContainer="true">
				<div dojoType="dojox.widget.Portlet" column="2" title="Location"
					id="sensorType0">
					<div style="height: 300px">
						<div id="map_canvas" style="width: 100%; height: 100%"
							class="center"></div>
					</div>
				</div>
				<div dojoType="dojox.widget.Portlet" title="Light" id="container5">
					<canvas id="graph5" width="100%" height="50">Wait...</canvas>
				</div>
				<!-- <div dojoType="dojox.widget.Portlet" title="Pressure"
					id="container6">
					<canvas id="graph6" width="100%" height="50">Wait...</canvas>
				</div> -->
				<!-- <div dojoType="dojox.widget.Portlet" title="Temperature"
					id="container7">
					<canvas id="graph7" width="100%" height="50">Wait...</canvas>
				</div> -->
				<div dojoType="dojox.widget.Portlet" title="Proximity"
					id="container8">
					<canvas id="graph8" width="100%" height="150">Wait...</canvas>
				</div>
				<div dojoType="dojox.widget.Portlet" title="Accelerometer"
					id="container1">
					<canvas id="graph1" width="100%" height="200"></canvas>
				</div>
				<div dojoType="dojox.widget.Portlet" title="Linear Acceleration"
					id="container10">
					<canvas id="graph10" width="100%" height="200">Wait...</canvas>
				</div>
				<div dojoType="dojox.widget.Portlet" title="Gyroscope"
					id="container4">
					<canvas id="graph4" width="100%" height="90">Wait...</canvas>
				</div>
				<div dojoType="dojox.widget.Portlet" title="Orientation"
					id="container3">
					<canvas id="graph3" width="100%" height="200">Wait...</canvas>
				</div>
				<!-- <div dojoType="dojox.widget.Portlet" title="Rotation Vector"
					id="container11">
					<canvas id="graph11" width="100%" height="200">Wait...</canvas>
				</div> -->
				<div dojoType="dojox.widget.Portlet" title="Gravity" id="container9">
					<canvas id="graph9" width="100%" height="90">Wait...</canvas>
				</div>
				<div dojoType="dojox.widget.Portlet" title="Magnetic Field"
					id="container2">
					<canvas id="graph2" width="100%" height="90">Wait...</canvas>
				</div>
			</div>
		</div>
	</div>
	<div dojoType="dijit.layout.ContentPane" region="bottom"><jsp:include
			page="../footer.jsp" /></div>
</body>
</html>
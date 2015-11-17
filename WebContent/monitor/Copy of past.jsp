<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage="/MobileContextMonitor/error.jsp"%>
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
<link rel="stylesheet" type="text/css" href="/MobileContextMonitor/css/style.css" />

<link rel="stylesheet" type="text/css"
	href="/MobileContextMonitor/lib/dojo/dijit/themes/claro/claro.css" />
<link rel="stylesheet" type="text/css"
	href="/MobileContextMonitor/lib/dojo/dojox/widget/Portlet/Portlet.css" />
<link rel="stylesheet" type="text/css"
	href="/MobileContextMonitor/lib/dojo/dojox/layout/resources/GridContainer.css" />
<link rel="stylesheet" type="text/css"
	href="/MobileContextMonitor/lib/dojo/dojox/widget/Calendar/Calendar.css" />

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
<script src="/MobileContextMonitor/lib/dojo/dojo/dojo.js"
	data-dojo-config="isDebug: true, parseOnLoad: true"></script>
<script src="/MobileContextMonitor/lib/RGraph/RGraph.common.core.js"></script>
<script src="/MobileContextMonitor/lib/RGraph/RGraph.common.context.js"></script>
<script src="/MobileContextMonitor/lib/RGraph/RGraph.common.annotate.js"></script>
<script src="/MobileContextMonitor/lib/RGraph/RGraph.common.tooltips.js"></script>
<script src="/MobileContextMonitor/lib/RGraph/RGraph.common.zoom.js"></script>
<script src="/MobileContextMonitor/lib/RGraph/RGraph.common.resizing.js"></script>
<script src="/MobileContextMonitor/lib/RGraph/RGraph.line.js"></script>
<script src="/MobileContextMonitor/lib/RGraph/RGraph.hprogress.js"></script>
<script src="/MobileContextMonitor/lib/json2.js"></script>
<script type="text/javascript"
	src="http://maps.google.com/maps/api/js?sensor=false"></script>
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
	var values = new Array(12);
	for ( var sensorType = 0; sensorType < 12; sensorType++) {
		values[sensorType] = new Array(3);
		for ( var j = 0; j < 3; j++) {
			values[sensorType][j] = new Array(300);
			for ( var i = 0; i < 300; ++i) {
				values[sensorType][j][i] = null;
			}
		}
	}
	/************************************************************/
	 var map = null;
	 var marker = null;
	function drawMap() {
		if(map != null) {
			var location = new google.maps.LatLng(values[0][0], values[0][1]);
			map.panTo(location);
			if(marker == null) {
				marker = new google.maps.Marker({
				      position: location,
				      title:"Here!"
				  });
				  marker.setMap(map);
			} else {
				marker.setPosition(location);
				marker.setMap(map);
			}
		} else {
			var location = new google.maps.LatLng(137.507, 126.952);
			var options = {
				    zoom: 12,
				    center: location,
				    mapTypeId: google.maps.MapTypeId.ROADMAP
				  };
			map = new google.maps.Map(document.getElementById("map_canvas"), options);
		}
	}
	/************************************************************/
	function getGraph(t) {
		if (values[t][0].length > 300) {
			values[t][0] = RGraph.array_shift(values[t][0]);
			values[t][1] = RGraph.array_shift(values[t][1]);
			values[t][2] = RGraph.array_shift(values[t][2]);
		}
		var graph = null;
		switch (t) {
		case 2:
		case 3:
		case 4:
		case 9:
		case 10:
		case 11:
			graph = new RGraph.Line("graph" + t, values[t][0],
					values[t][1], values[t][2]);
			graph.Set('chart.background.barcolor1', 'white');
			graph.Set('chart.background.barcolor2', 'white');
			graph.Set('chart.background.barcolor3', 'white');
			graph.Set('chart.background.grid', true);
			graph.Set('chart.linewidth', 1);
			graph.Set('chart.gutter.left', 40);
			graph.Set('chart.gutter.right', 40);
			graph.Set('chart.gutter.top', 10);
			graph.Set('chart.gutter.bottom', 10);
			if (RGraph.isIE9up()) {
				graph.Set('chart.shadow', true);
			}
			graph.Set('chart.tickmarks', null);
			//graph.Set('chart.units.post', 'k');
			graph.Set('chart.ylabels.count', 3);
			graph.Set('chart.xticks', 8);
			graph.Set('chart.colors', [ 'red', 'green', 'blue' ]);
			graph.Set('chart.key.halign', 'left');
			graph.Set('chart.key.shadow', true);
			graph.Set('chart.key.shadow.offsetx', 0);
			graph.Set('chart.key.shadow.offsety', 0);
			graph.Set('chart.key.shadow.blur', 15);
			graph.Set('chart.key.shadow.color', '#ddd');
			graph.Set('chart.key.rounded', true);
			graph.Set('chart.key.position', 'graph');
			graph.Set('chart.key.position.x',
					(graph.canvas.width)-graph.Get('chart.gutter.right')+5);
			graph.Set('chart.key.position.y', graph.Get('chart.gutter.top'));
			graph.Set('chart.xaxispos', 'center');
			graph.Set('chart.background.grid.autofit', true);
			graph.Set('chart.background.grid.autofit.numhlines', 10);
			switch (t) {
			case 1:
				//graph.Set('chart.title', 'Accelerometer');
				graph.Set('chart.key', [ 'x (m/s^2)', 'y', 'z' ]);
				break;
			case 2:
				//graph.Set('chart.title', 'Magnetic Field');
				break;
			case 3:
				//graph.Set('chart.title', 'Orientation');
				break;
			case 4:
				//graph.Set('chart.title', 'Gyroscope');
				break;
			case 9:
				//graph.Set('chart.title', 'Gravity');
				break;
			case 10:
				//graph.Set('chart.title', 'Linear Acceleromter');
				break;
			case 11:
				//graph.Set('chart.title', 'Rotation Vector');
				break;
			}
			graph.Set('chart.curvy', true);
			graph.Set('chart.curvy.factor', 0.25);
			return graph;
		case 5:
		case 6:
		case 7:
		case 8:
			var curr = values[t][0];
			switch (t) {
			case 5:
				graph = new RGraph.HProgress("graph" + t, curr, 10000);
				//graph.Set('chart.title', 'Light');
				graph.Set('chart.key', [ 'lux' ]);
		    	graph.Set('chart.colors', ['gray']);	
				if(curr >= 1000) {
			    	graph.Set('chart.colors', ['red']);	
			    } else if(curr < 1000 && curr >= 500) {
			    	graph.Set('chart.colors', ['orange']);
			    } else if(curr < 500) {
			    	graph.Set('chart.colors', ['green']);
			    }
				break;
			case 6:
				graph = new RGraph.HProgress("graph" + t, curr, 20000);
				//graph.Set('chart.title', 'Pressure');
				graph.Set('chart.key', [ 'Pa' ]);
		    	graph.Set('chart.colors', ['gray']);
				if(curr >= 80) {
			    	graph.Set('chart.colors', ['red']);	
			    } else if(curr < 80 && curr >= 50) {
			    	graph.Set('chart.colors', ['orange']);
			    } else if(curr < 50) {
			    	graph.Set('chart.colors', ['green']);
			    }
				break;
			case 7:
				graph = new RGraph.HProgress("graph" + t, curr, 100);
				//graph.Set('chart.title', 'Temperature');
				graph.Set('chart.key', [ '°C' ]);
		    	graph.Set('chart.colors', ['gray']);
				if(curr >= 80) {
			    	graph.Set('chart.colors', ['red']);	
			    } else if(curr < 80 && curr >= 50) {
			    	graph.Set('chart.colors', ['orange']);
			    } else if(curr < 50) {
			    	graph.Set('chart.colors', ['green']);
			    }
				break;
			case 8:
				graph = new RGraph.HProgress("graph" + t, curr, 10);
				//graph.Set('chart.title', 'Proximity');
				graph.Set('chart.key', [ 'cm' ]);
		    	graph.Set('chart.colors', ['gray']);
				if(curr >= 5) {
			    	graph.Set('chart.colors', ['red']);	
			    } else if(curr < 5 && curr >= 2) {
			    	graph.Set('chart.colors', ['orange']);
			    } else if(curr < 2) {
			    	graph.Set('chart.colors', ['green']);
			    }
				break;
			}
			graph.Set('chart.gutter.left', 5);
			graph.Set('chart.gutter.right', 20);
			graph.Set('chart.gutter.bottom', 20);
			graph.Set('chart.key.position.x', graph.canvas.width-graph.Get('chart.gutter.right')*3);
			graph.Set('chart.key.position.y', graph.Get('chart.gutter.top')/2);
			graph.Set('chart.numticks', 5);
			/* graph.Set('chart.tooltips', ['Light']); */
			/* graph.Set('chart.units.post', 'lux'); */
			graph.Set('chart.tickmarks.zerostart', true);
			return graph;
		}
	}
	/************************************************************/
	function drawGraph(sensorType) {
		var graph = getGraph(sensorType);
		graph.Draw();
	}
	/************************************************************/
	function redrawGraph(sensorType) {
        RGraph.Clear(document.getElementById("graph"+sensorType));
        drawGraph(sensorType);
	}
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
				for(var i = 0; jsons.length; i++) {
					var json = jsons[i];
					var sensorType = json.sensor_type;
					switch (sensorType) {
					case 0:
						if(values[sensorType][0] != json.value0 || values[sensorType][1] != json.value1) {
							values[sensorType][0] = json.value0;
							values[sensorType][1] = json.value1;
							drawMap();
						}
						break;
					case 1:
						if(values[sensorType][0] != json.value0 || values[sensorType][1] != json.value1) {
							singleBarDraw("graph1", json.value0, json.value1, json.value2);
						}
						break;
					case 5:
					case 6:
					case 7:
					case 8:
						values[sensorType][0] = json.value0;
						redrawGraph(sensorType);
						break;
					default:
						values[sensorType][0].push(json.value0);
						values[sensorType][1].push(json.value1);
						values[sensorType][2].push(json.value2);
						redrawGraph(sensorType);
						break;
					}					
				}
			}
		};
		httpRequest.open('GET', "/MobileContextMonitor/ContextRetriever", true);
		httpRequest.send();
	}
	/************************************************************/
	var sleepTime = 50;
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

		graph1.width = document.getElementById("container1").offsetWidth / 2;
		graph2.width = document.getElementById("container2").offsetWidth / 1.1;
		graph3.width = document.getElementById("container3").offsetWidth / 1.1;
		graph4.width = document.getElementById("container4").offsetWidth / 1.1;
		graph5.width = document.getElementById("container5").offsetWidth / 1.1;
		graph6.width = document.getElementById("container6").offsetWidth / 1.1;
		graph7.width = document.getElementById("container7").offsetWidth / 1.1;
		graph8.width = document.getElementById("container8").offsetWidth / 1.1;
		graph9.width = document.getElementById("container9").offsetWidth / 1.1;
		graph10.width = document.getElementById("container10").offsetWidth / 1.1;
		graph11.width = document.getElementById("container11").offsetWidth / 1.1;
		drawMap();
		singleBarDraw("graph1");
		for ( var t = 2; t < 12; t++) {
			drawGraph(t);
		};
	}
	/************************************************************/
	window.onresize = resize;
	window.onload = function() {	
		resize();
		run();
	};
	/************************************************************/
	/************************************************************/
	/************************************************************/
	/************************************************************/
	/************************************************************/
	/************************************************************/
</script>
<link href="/MobileContextMonitor/css/graph.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/MobileContextMonitor/js/3DGraph.js"></script>
<script type="text/javascript" src="/MobileContextMonitor/js/3DGraphData.js"></script>
</head>
<body class=" claro " style="margin-top: 0px">
	<jsp:include page="/MobileContextMonitor/menu.jsp" />
	<div dojoType="dijit.layout.ContentPane" region="center">
		<div dojoType="dojox.layout.GridContainer" id="rootContainer"
			hasResizableColumns="false" opacity="0.3" nbZones="3"
			isAutoOrganized="true" allowAutoScroll="true" withHandles="true"
			handleClasses="dijitTitlePaneTitle" region="center" minChildWidth="0"
			minColWidth="0" isLayoutContainer="true">
			<div dojoType="dojox.widget.Portlet" title="Location"
				id="sensorType0">
				<div style="height: 300px">
					<div id="map_canvas" style="width: 100%; height: 100%"
						class="center"></div>
				</div>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Light" id="container5">
				<canvas id="graph5" width="100%" height="50">Wait...</canvas>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Pressure" id="container6">
				<canvas id="graph6" width="100%" height="50">Wait...</canvas>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Temperature"
				id="container7">
				<canvas id="graph7" width="100%" height="50">Wait...</canvas>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Proximity"
				id="container8">
				<canvas id="graph8" width="100%" height="50">Wait...</canvas>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Accelerometer"
				id="container1">
				<!-- <canvas id="graph1" width="100%" height="90">Wait...</canvas> -->
				<table class="size-width-max">
				<tr><td>
				<canvas id="graph1" width="200" height="200"></canvas>
				<!-- 	<div style="font-size: 12px; font-family: Arial; color: #000000; margin: 20px 0px 0px 0px;"> -->
				<!-- 		Current Acceleration Values</div> -->
				</td><td>
				<div>
					<div
						style="font-size: 12px; font-family: Tahoma; color: #000000; margin: 5px 0px 0px 0px;">
						Ax = <input type="text" value="10" class="num-input" id="x-input" />
						m/s^2
					</div>
					<div
						style="font-size: 12px; font-family: Tahoma; color: #000000; margin: 5px 0px 0px 0px;">
						Ay = <input type="text" value="10" class="num-input" id="y-input" />
						m/s^2
					</div>
					<div
						style="font-size: 12px; font-family: Tahoma; color: #000000; margin: 5px 0px 0px 0px;">
						Az = <input type="text" value="10" class="num-input" id="z-input" />
						m/s^2
					</div>

					<input type="button" value="Draw Bar" onclick="singleBarDraw(); " />
				</div></td></tr>
				</table>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Linear Acceleration"
				id="container10">
				<canvas id="graph10" width="100%" height="90">Wait...</canvas>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Gyroscope"
				id="container4">
				<canvas id="graph4" width="100%" height="90">Wait...</canvas>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Orientation"
				id="container3">
				<canvas id="graph3" width="100%" height="90">Wait...</canvas>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Rotation Vector"
				id="container11">
				<canvas id="graph11" width="100%" height="90">Wait...</canvas>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Gravity" id="container9">
				<canvas id="graph9" width="100%" height="90">Wait...</canvas>
			</div>
			<div dojoType="dojox.widget.Portlet" title="Magnetic Field"
				id="container2">
				<canvas id="graph2" width="100%" height="90">Wait...</canvas>
			</div>
		</div>
	</div>
	<div dojoType="dijit.layout.ContentPane" region="bottom"><jsp:include
			page="/MobileContextMonitor/footer.jsp" /></div>
</body>
</html>
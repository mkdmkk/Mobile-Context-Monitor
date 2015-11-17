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
	href="../lib/dojo/dijit/themes/tundra/tundra.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/dojo/dijit/themes/soria/soria.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/dojo/dijit/themes/nihilo/nihilo.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/dojo/dojox/widget/Portlet/Portlet.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/dojo/dojox/layout/resources/GridContainer.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/dojo/dojox/widget/Calendar/Calendar.css" />
<style type="text/css">
@import url("../lib/dojo/dojox/layout/resources/ExpandoPane.css");
</style>
<link href="../css/3DGraph.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.dndDropIndicator {
	border: 2px dashed #99BBE8;
	cursor: default;
	margin-bottom: 5px
}

.gridContainerTable {
	width: 100%;
	height: 100%;
	border: 0px solid #BFBFBF;
}

.claro .dijitContentPane {
	padding: 0px;
	border: 0px solid #BFBFBF;
}

.gridContainerZone,.gridContainer {
	border: 0px solid #BFBFBF;
}

#rootContainer,#mainContainer {
	width: 100%;
	height: 100%;
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
}

#menubarContainer,#toolbarContainer,#footerContainer {
	width: 100%;
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
}

.claro .dojoxExpandoTitle {
	text-align: center;
	font-weight: bold;
	font-size: 0.9em;
	background-color: #EFEFEF;
	background-repeat: repeat-x;
	border: 1px solid #B5BCC7;
	border-right: 0px solid #B5BCC7;
	border-top: 0px solid #B5BCC7;
	min-height: 15px;
	margin-bottom: 5px;
	padding: 3px 7px 2px 7px;
}

.claro .dojoxExpandoClosed .dojoxExpandoTitle {
	text-align: center;
	font-weight: bold;
	font-size: 0.9em;
	padding: 0px 2px 0px 2px;
}

.dojoxExpandoBottom .dojoxExpandoIcon,.dojoxExpandoTop .dojoxExpandoIcon,.dojoxExpandoLeft .dojoxExpandoIcon
	{
	float: right;
	margin-right: 6px;
}

.claro .dojoxExpandoRight .dojoxExpandoTitle,.claro .dojoxExpandoLeft .dojoxExpandoTitle,.claro .dojoxExpandoClosed .dojoxExpandoTitle
	{
	text-align: center;
	font-weight: bold;
	font-size: 0.9em;
}

#treeContainer {
	
}

#toolbar {
	margin-top: 0px;
	margin-bottom: 0px;
	padding-top: 0px;
}

.claro .dijitSplitterH,.claro .dijitGutterH {
	background: none;
	border: 0;
	height: 0px;
}

.gridContainerZone>* {
	margin: 0px !important;
}

.claro .dijitSplitterV,.claro .dijitGutterV {
	background: none;
	border: 0;
	border-right: 1px solid #B5BCC7;
	width: 0px;
	margin: 0;
}

.claro .dijitTextBox {
	margin: 3px;
}
</style>

<script type="text/javascript"
	src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="../lib/dojo/dojo/dojo.js"
	data-dojo-config="isDebug: true, parseOnLoad: true"></script>
<script src="../lib/RGraph/RGraph.common.core.js"></script>
<script src="../lib/RGraph/RGraph.common.context.js"></script>
<script src="../lib/RGraph/RGraph.common.annotate.js"></script>
<script src="../lib/RGraph/RGraph.common.tooltips.js"></script>
<script src="../lib/RGraph/RGraph.common.zoom.js"></script>
<script src="../lib/RGraph/RGraph.common.resizing.js"></script>
<script src="../lib/RGraph/RGraph.common.effects.js"></script>
<script src="../lib/RGraph/RGraph.line.js"></script>
<script src="../lib/RGraph/RGraph.hprogress.js"></script>
<script src="../lib/RGraph/RGraph.odo.js"></script>
<script src="../lib/json2.js"></script>
<script type="text/javascript" src="../js/Graph3D.js"></script>
<script type="text/javascript" src="../js/ProgressGraph.js"></script>
<script type="text/javascript" src="../js/Map.js"></script>
<script type="text/javascript" src="../js/ProximityFigure.js"></script>
<script type="text/javascript" src="../js/Cube3D.js"></script>
<script type="text/javascript" src="../js/Compass.js" charset="utf-8"></script>
<script type="text/javascript">
	/****************************************************************
	 * Required Codes for Dojo 
	 ****************************************************************/
	dojo.require("dijit.dijit");

	dojo.require("dijit.layout.BorderContainer");
	dojo.require("dijit.layout.TabContainer");
	dojo.require("dijit.layout.ContentPane");
	dojo.require("dojox.layout.ExpandoPane");

	dojo.require("dijit.form.TimeTextBox");
	dojo.require("dijit.form.DateTextBox");
	dojo.require("dijit.form.Button");
	dojo.require("dijit.form.Select");
	dojo.require("dijit.form.TextBox");
	dojo.require("dijit.form.FilteringSelect");

	dojo.require('dijit.Tree');
	dojo.require("dijit.Toolbar");

	dojo.require("dojox.widget.Portlet");
	dojo.require("dojox.widget.FeedPortlet");
	dojo.require("dojox.widget.Calendar");

	dojo.require("dojox.layout.GridContainer");
	dojo.require("dojox.data.JsonRestStore");

	dojo.require("dojo.parser");
	dojo.require("dojo.data.ItemFileReadStore");

	/****************************************************************
	 * Initial Tree Data
	 ****************************************************************/
	var data = [ {
		label : 'MKK\'s N1',
		id : '1',
		type : 'File'
	}, {
		label : 'Member 002',
		id : '2',
		type : 'File',
	}, {
		label : 'Member 003',
		id : '3',
		type : 'File',
	}, {
		label : 'Member 004',
		id : '4',
		type : 'File',
	}, {
		label : 'Member 005',
		id : '5',
		type : 'File',
	}, {
		label : 'Member 006',
		id : '6',
		type : 'File',
	}, {
		label : 'Member 007',
		id : '7',
		type : 'File',
	}, {
		label : 'Member 008',
		id : '8',
		type : 'File',
	} ];

	/****************************************************************
	 * Initializing tree
	 ****************************************************************/
	var selectedPath;
	var selectedType;
	function initTree() {
		if (dijit.byId("tree")) {
			// Destroy the widget
			dijit.byId("tree").destroyRecursive();
		}

		var store = new dojo.data.ItemFileReadStore({
			query : {
				type : 'continent'
			},
			data : {
				identifier : 'id',
				label : 'label',
				items : data
			}
		});

		var treeModel = new dijit.tree.ForestStoreModel({
			store : store
		});

		treeContainer.innerHTML = "<div id='tree'></div>";
		var treeControl = new dijit.Tree({
			model : treeModel,
			showRoot : false,
			_createTreeNode : function(args) {
				var tnode = new dijit._TreeNode(args);
				tnode.labelNode.innerHTML = args.label;
				return tnode;
			},
			onClick : function(item) {

			}
		}, "tree");
	}

	/****************************************************************
	 * Requesting context (JSON Format) to Servlet
	 ****************************************************************/
	function getContext() {
		var httpRequest = null;
		if (window.XMLHttpRequest)
			httpRequest = new XMLHttpRequest();
		// else if (window.ActiveXObject) var httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
		httpRequest.onreadystatechange = function() {
			if (httpRequest.readyState == 4 && httpRequest.status == 200) {
				var jsons = eval('(' + this.responseText + ')');
				for ( var i = 0; jsons.length; i++) {
					var json = jsons[i];
					var sensorType = json.sensor_type;
					switch (sensorType) {
					case 0:
						map.draw(json.value0, json.value1);
						break;
					case 1:
						accelerometerGraph.draw(json.value0, json.value1,
								json.value2);
						break;
					case 10:
						linearAccelerationGraph.draw(json.value0, json.value1,
								json.value2);
						break;
					case 5:
						lightGraph.draw(json.value0);
						break;
					case 8:
						proximityFigure.draw(json.value0);
						break;
					case 11:
						break;
					case 3:
						orientationCube.draw(json.value0, json.value1,
								json.value2);
						compass.draw(json.value0);
						break;
					default:
						break;
					}
				}
			}
		};
		httpRequest.open('GET', "/MobileContextMonitor/ContextRetriever", true);
		httpRequest.send();
	}

	/****************************************************************
	 * Repeated Work
	 ****************************************************************/
	var sleepTime = 300;
	function run() {
		getContext();
		setTimeout(run, sleepTime);
	}

	/****************************************************************
	 * Resizing when browser's size is changed. 
	 ****************************************************************/
	function resize() {
		graph1.width = document.getElementById("container1").offsetWidth / 1.1;
		graph2.width = document.getElementById("container2").offsetWidth / 1.1;
		graph3.width = document.getElementById("container3").offsetWidth / 1.1;
		//graph4.width = document.getElementById("container4").offsetWidth / 1.1;
		graph5.width = document.getElementById("container5").offsetWidth / 1.1;
		graph8.width = document.getElementById("container8").offsetWidth / 1.1;
		//graph9.width = document.getElementById("container9").offsetWidth / 1.1;
		graph10.width = document.getElementById("container10").offsetWidth / 1.1;
	}

	/****************************************************************
	 * Drawing Graphes
	 ****************************************************************/
	var map = null;
	var proximityFigure = null;
	var lightGraph = null;
	var rotationVectorCube = null;
	var orientationCube = null;
	var accelerometerGraph = null;
	var linearAccelerationGraph = null;
	var compass = null;
	function initGraphes() {
		map = new Map("map");
		map.draw();
		accelerometerGraph = new Graph3D("graph1", "A", "m/s^2", 15);
		accelerometerGraph.draw();
		linearAccelerationGraph = new Graph3D("graph10", "A", "m/s^2", 15);
		linearAccelerationGraph.draw();
		proximityFigure = new ProximityFigure("graph8", 10);
		proximityFigure.draw(0);
		lightGraph = new ProgressGraph("graph5", "lux", 2000, [ '#E8E773',
				'#FFE800', '#FFCC00', '#FFA215', '#E81B05' ]);
		lightGraph.draw(0);
		orientationCube = new Cube3D("graph3");
		orientationCube.draw(0, 0, 0);
		compass = new Compass("graph2");
		compass.draw(0);
	}

	/****************************************************************
	 * Onload and Onresize 
	 ****************************************************************/
	window.onresize = resize;
	window.onload = function() {
		resize();
		dijit.defaultDuration = 0;
		initTree();
		initGraphes();
		run();
	};
</script>
</head>
<body class="claro">
	<div id="rootContainer" dojoType="dijit.layout.BorderContainer"
		design="sidebar" gutters="true" liveSplitters="true">
		<div id="menubarContainer" dojoType="dijit.layout.ContentPane"
			region="top">
			<jsp:include page="../menu.jsp" />
		</div>
		<div id="toolbarContainer" dojoType="dijit.layout.ContentPane"
			region="top">
			<div id="toolbar" dojoType="dijit.Toolbar">
				<input id="sdate" dojoType="dijit.form.DateTextBox"> <input
					id="stime" dojoType="dijit.form.TimeTextBox"
					dojoProps="
                constraints: {
                    timePattern: 'HH:mm:ss',
                    clickableIncrement: 'T00:15:00',
                    visibleIncrement: 'T00:15:00',
                    visibleRange: 'T01:00:00'
                },
                required:true,
                invalidMessage:'Invalid time.'">
			</div>
		</div>
		<div id="mainContainer" dojoType="dijit.layout.BorderContainer"
			design="sidebar" gutters="true" liveSplitters="true" region="center">
			<div id="asideContainer" dojoType="dojox.layout.ExpandoPane"
				title="Member List" maxWidth="30%" splitter="true" region="leading"
				style="width: 15%;">
				<div id="treeContainer" dojoType="dijit.layout.ContentPane"></div>
			</div>
			<div id="contentContainer" dojoType="dijit.layout.ContentPane"
				splitter="true" region="center">
				<div dojoType="dojox.layout.GridContainer" id="content"
					hasResizableColumns="false" opacity="0.3" nbZones="3"
					isAutoOrganized="true" allowAutoScroll="false" withHandles="true"
					handleClasses="dijitTitlePaneTitle" region="center"
					minChildWidth="0" minColWidth="0" isLayoutContainer="true">
					<div dojoType="dojox.widget.Portlet" title="Location"
						id="sensorType0">
						<div style="height: 300px">
							<div id="map" style="width: 100%; height: 100%" class="center"></div>
						</div>
					</div>
					<div dojoType="dojox.widget.Portlet" title="Light" id="container5">
						<canvas id="graph5" width="100%" height="50">Wait...</canvas>
					</div>
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
					<!-- <div dojoType="dojox.widget.Portlet" title="Gyroscope"
						id="container4">
						<canvas id="graph4" width="100%" height="90">Wait...</canvas>
					</div> -->
					<div dojoType="dojox.widget.Portlet" title="Orientation"
						id="container3">
						<canvas id="graph3" width="100%" height="200">Wait...</canvas>
					</div>
					<!-- <div dojoType="dojox.widget.Portlet" title="Gravity"
						id="container9">
						<canvas id="graph9" width="100%" height="90">Wait...</canvas>
					</div> -->
					<div dojoType="dojox.widget.Portlet" title="Magnetic Field"
						id="container2">
						<canvas id="graph2" width="100%" height="200">Wait...</canvas>
					</div>
				</div>
			</div>
		</div>
		<div id="footerContainer" dojoType="dijit.layout.ContentPane"
			region="bottom">
			<jsp:include page="../footer.jsp" />
		</div>
	</div>
</body>
</html>
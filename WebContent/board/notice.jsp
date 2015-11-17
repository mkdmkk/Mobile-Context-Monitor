<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage="errorPage.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board</title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
<link rel="stylesheet" href="../lib/dojo/dijit/themes/claro/claro.css" />
<style type="text/css">
.claro .dijitContentPane {
	padding: 0px;
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

.claro .dijitSplitterH,.claro .dijitGutterH {
	background: none;
	border: 0;
	height: 0px;
}
</style>
<script src="../lib/dojo/dojo/dojo.js"
	data-dojo-config="isDebug: true, parseOnLoad: true"></script>
<script>
	dojo.require("dijit.dijit");
	
	dojo.require("dijit.Editor");
	dojo.require('dijit.Tree');
	dojo.require("dijit.Toolbar");
	
	dojo.require("dojo.parser");
	dojo.require("dojo.data.ItemFileReadStore");
	
	dojo.require("dijit.layout.TabContainer");
	dojo.require("dijit.layout.BorderContainer");
	dojo.require("dijit.layout.ContentPane");
	
	dojo.require("dijit._editor.plugins.TextColor");
	dojo.require("dijit._editor.plugins.LinkDialog");
	dojo.require("dijit._editor.plugins.FullScreen");
	dojo.require("dijit._editor.plugins.ViewSource");
	dojo.require("dijit._editor.plugins.NewPage");
	dojo.require("dijit._editor.plugins.FontChoice");
	dojo.require("dijit._editor.plugins.Print");
	dojo.require("dijit.form.Textarea");
	dojo.require("dijit.layout.LayoutContainer");
	
	dojo.require("dojox.layout.ExpandoPane");

	dojo.require("dojox.form.BusyButton");
	dojo.require("dijit.form.TimeTextBox");
	dojo.require("dijit.form.DateTextBox");
	dojo.require("dijit.form.Button");
	dojo.require("dijit.form.Select");
	dojo.require("dijit.form.TextBox");
	dojo.require("dijit.form.FilteringSelect");

	dojo.require("dojox.widget.Portlet");
	dojo.require("dojox.widget.FeedPortlet");
	dojo.require("dojox.widget.Calendar");

	dojo.require("dojox.layout.GridContainer");
	dojo.require("dojox.data.JsonRestStore");

	
	function checkValues() {
		var editor = dijit.byId("editor");
		document.getElementById("contentContainer").innerHTML = editor
				.get("value");
	}
	dojo.require('dijit.ProgressBar');
	dojo.addOnLoad(function() {
		loadingContainer.style.display = "hide";
		loadingContainer.style.height = "0";
		rootContainer.style.display = "show";
	});
</script>
</head>
<body class=" claro ">
	<div id="loadingContainer" dojoType="dijit.layout.ContentPane"
		style="width: 100%; height: 100%">
		<div style="text-align: center">
			<img src="../res/loading.gif">
		</div>
	</div>
	<div id="rootContainer" dojoType="dijit.layout.BorderContainer"
		design="sidebar" gutters="true" liveSplitters="true" display="hide">
		<div id="menubarContainer" dojoType="dijit.layout.ContentPane"
			region="top">
			<jsp:include page="../menu.jsp" />
		</div>
		<div id="toolbarContainer" dojoType="dijit.layout.ContentPane"
			region="top">
			<div id="toolbar" dojoType="dijit.Toolbar">
                <input type="button" value="" id="queryButton" dojoType="dojox.form.BusyButton" 
				label="Write" busyLabel="Writing" timeout="2000" />
			</div>
		</div>
		<div dojoType="dijit.layout.ContentPane" region="center">
			<div id="contentContainer"></div>
			<div id="editorContainter" dojoType="dijit.layout.ContentPane"
				style="width: 100%; height: 100%;">
				<div id="editor" dojoType="dijit.Editor" height="100%"
					extraPlugins="['dijit._editor.plugins.AlwaysShowToolbar', '|', 'fontName', 'fontSize', '|', 'foreColor', 'hiliteColor', '|', 'createLink', 'insertImage', '|', 'viewsource', 'print']">
				</div>
			</div>
		</div>
		<div dojoType="dijit.layout.ContentPane" region="bottom"><jsp:include
				page="../footer.jsp" /></div>
	</div>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage="error.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mobile Context Monitor</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" href="lib/dojo/dijit/themes/claro/claro.css" />
<link rel="stylesheet"
	href="lib/dojo/dojox/form/resources/BusyButton.css" />
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
<script type="text/javascript" src="lib/jquery.js"></script>
<script src="lib/dojo/dojo/dojo.js"
	data-dojo-config="isDebug: true, parseOnLoad: true"></script>
<script>
	dojo.require('dojox.validate');
	dojo.require('dojox.validate.us');
	dojo.require('dojox.validate.web');
	dojo.require('dojox.validate.check');

	dojo.require("dijit.layout.BorderContainer");
	dojo.require("dijit.layout.TabContainer");
	dojo.require("dijit.layout.ContentPane");
	dojo.require("dojox.layout.ExpandoPane");
	
	/* basic dijit classes */
	dojo.require('dijit.form.CheckBox');
	dojo.require('dijit.form.Textarea');
	dojo.require('dijit.form.FilteringSelect');
	dojo.require('dijit.form.TextBox');
	dojo.require('dijit.form.ValidationTextBox');
	dojo.require('dijit.form.DateTextBox');
	dojo.require('dijit.form.TimeTextBox');
	dojo.require('dijit.form.Button');
	dojo.require('dijit.form.RadioButton');
	dojo.require('dijit.form.Form');
	dojo.require('dijit.form.DateTextBox');

	/* basic dojox classes */
	dojo.require('dojox.form.BusyButton');
	dojo.require('dojox.form.CheckedMultiSelect');

	function signIn() {
		var isValid = true;
		if (email.value == "") {
			errorMessage.innerHTML += "You forgot e-mail address.<br>";
			isValid = false;
		}
		if (pw.value == "") {
			errorMessage.innerHTML += "You forgot password.<br>";
			isValid = false;
		}
		if (isValid)
			signForm.submit();
	}
	
	dojo.require('dijit.ProgressBar');
	dojo.addOnLoad(function(){
		loadingContainer.style.display = "hide";
		loadingContainer.style.height = "0";
		rootContainer.style.display = "show";
	});
</script>
</head>
<body class=" claro ">
	<div id="loadingContainer" dojoType="dijit.layout.ContentPane" style="width: 100%; height:100%">
		<div style="text-align: center"><img src="res/loading.gif"></div>
	</div>
	<div id="rootContainer" dojoType="dijit.layout.BorderContainer"
		design="sidebar" gutters="true" liveSplitters="true" display="hide">
		<div id="headerContainer" dojoType="dijit.layout.ContentPane"
			region="top">
			<jsp:include page="header.jsp" />
		</div>
		<div id="menubarContainer" dojoType="dijit.layout.ContentPane"
			region="top">
			<jsp:include page="menu.jsp" />
		</div>
		<div id="mainContainer" dojoType="dijit.layout.ContentPane"
			region="center">
			<section class=" background-white">
				<article>
					<form id="signForm" action="MemberManager?actionType=signIn"
						dojoType="dijit.form.Form" method="post">
						<div style="width: 70%"
							class="margin-top-small margin-bottom-small center">
							<table class="size-width-max">
								<tr>
									<td colspan="2"><input type="text" required="true"
										name="email" id="email" placeholder="E-mail Address*"
										dojoType="dijit.form.ValidationTextBox" style="width: 100%"
										missingMessage="Ooops! You forgot e-mail address!" /></td>
								</tr>
								<tr>
									<td colspan="2"><input type="password" required="true"
										name="pw" id="pw" placeholder="Password*"
										dojoType="dijit.form.ValidationTextBox" style="width: 100%"
										missingMessage="Ooops! You forgot password!" /></td>
								</tr>
								<tr>
									<td width="50%">
										<table>
											<tr>
												<td><input type="checkbox" id="remember"
													dojoType="dijit.form.CheckBox" /></td>
												<td><label class="">Remember me</label></td>
											</tr>
										</table>
									</td>
									<td align="right"><input type="submit" value="Sign-in"
										onClick="javascript:signIn()" id="signIn" class="float-right"
										dojoType="dojox.form.BusyButton" label="Sign-in"
										busyLabel="Signing-in..." timeout="2000" /></td>
								</tr>
								<tr>
									<td>
										<div id="errorMessage" class="color-red"></div>
									</td>
									<td><a href="signup.jsp"
										class="float-right margin-right-small">Sign-up</a></td>
								</tr>
							</table>
						</div>
					</form>
				</article>
			</section>
		</div>
		<div id="footerContainer" dojoType="dijit.layout.ContentPane"
			region="bottom">
			<jsp:include page="footer.jsp" />
		</div>
</body>
</html>
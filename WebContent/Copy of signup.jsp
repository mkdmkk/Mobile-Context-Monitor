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
	
	dojo.require('dijit.ProgressBar');

	function signUp() {
		var isValid = true;
		if (email.value == "") {
			errorMessage.innerHTML += "You forgot e-mail address.\n";
			isValid = false;
		}
		if (pw.value == "" || pwConf.value == "") {
			errorMessage.innerHTML += "Error! You forgot password.\n";
			isValid = false;
		}
		if (isValid)
			signForm.submit();
	}
	
	dojo.addOnLoad(function(){
		loadingContainer.style.display = "hide";
		rootContainer.style.display = "show";
	});
</script>
</head>
<body class=" claro ">
	<div id="loadingContainer" dojoType="dijit.layout.ContentPane" style="height:100%">
		asdf
	</div>
	<div id="rootContainer" dojoType="dijit.layout.BorderContainer"
		design="sidebar" gutters="true" liveSplitters="true" style="display: hide">
		<div id="menubarContainer" dojoType="dijit.layout.ContentPane"
			region="top">
			<jsp:include page="menu.jsp" />
		</div>
		<div id="mainContainer" dojoType="dijit.layout.ContentPane"
			region="center">
			<section class=" background-white">
			<article>
				<form action="MemberController?actionType=signUp" method="post"
					id="signForm">
					<table class="size-width-half center">
						<tbody>
							<tr>
								<td><input type="email" name="email"
									placeholder="E-mail address*" required="true"
									dojoType="dijit.form.ValidationTextBox" style="width: 100%"
									missingMessage="Ooops! You forgot e-mail address!"></input></td>
								<td><input type="email" name="emailConfirm" required="true"
									placeholder="Confirm e-mail address*"
									dojoType="dijit.form.ValidationTextBox" style="width: 100%"
									missingMessage="Ooops! You forgot e-mail address!"></input></td>
							</tr>
							<tr>
								<td><input type="text" name="pw" placeholder="Password*"
									required="true" dojoType="dijit.form.ValidationTextBox"
									style="width: 100%"
									missingMessage="Ooops! You forgot password!"></input></td>
								<td><input type="text" name="pwConfirm" required="true"
									placeholder="Confirm password*"
									dojoType="dijit.form.ValidationTextBox" style="width: 100%"
									missingMessage="Ooops! You password!"></input></td>
							</tr>
							<tr>
								<td colspan="2"><input type="text" name="name"
									placeholder="Name" dojoType="dijit.form.ValidationTextBox"
									style="width: 100%" missingMessage="Ooops! You forgot name!"></input>
								</td>
							</tr>
							<tr>
								<td>
									<div id="errorMessage" class="color-red"></div></td>
								<td><input type="submit" value="Sign-up"
									onClick="javascript:signUp()" id="signUp" class="float-right"
									dojoType="dojox.form.BusyButton" label="Sign-up"
									busyLabel="Signing-up..." timeout="2000" /></input></td>
							</tr>
						</tbody>
					</table>
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
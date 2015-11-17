<div dojoType="dijit.MenuBar">
	<!-- <div dojoType="dijit.MenuBarItem" onclick="javascript:moveTo('/MobileContextMonitor/')"><img src="/MobileContextMonitor/res/mcm.png" style="height: 10px"></div> -->
	<div dojoType="dijit.PopupMenuBarItem">
		<span>Monitor</span>
		<div dojoType="dijit.Menu">
			<div dojoType="dijit.MenuItem"
				onclick="javascript:moveTo('/MobileContextMonitor/monitor/current.jsp')">Current</div>
			<div dojoType="dijit.MenuItem"
				onclick="javascript:moveTo('/MobileContextMonitor/monitor/past.jsp')">Past</div>
		</div>
	</div>
	<div dojoType="dijit.PopupMenuBarItem">
		<span>Board</span>
		<div dojoType="dijit.Menu">
			<div dojoType="dijit.MenuItem"
				onclick="javascript:moveTo('/MobileContextMonitor/board/notice.jsp')">Notice</div>
		</div>
	</div>
	<div dojoType="dijit.MenuBarItem"
		onclick="javascript:moveTo('/MobileContextMonitor/support.jsp')">Support</div>
	<div dojoType="dijit.MenuBarItem"
		onclick="javascript:moveTo('/MobileContextMonitor/setting.jsp')">Setting</div>
	<div dojoType="dijit.PopupMenuBarItem">
		<span>Account</span>
		<div dojoType="dijit.Menu">
			<div dojoType="dijit.MenuItem" onClick="">Update</div>
			<div dojoType="dijit.MenuItem" onClick="">Sign-out</div>
		</div>
	</div>

	<script type="text/javascript">
			dojo.require("dijit.MenuBar");
			dojo.require("dijit.PopupMenuBarItem");
			dojo.require("dijit.MenuBarItem");
			dojo.require("dijit.Menu");
			dojo.require("dijit.MenuItem");
			function moveTo(url) {
				window.location.href = url;
			}
		</script>
</div>
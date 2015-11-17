<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Canvas 3D Graph</title>
<link href="css/graph.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="js/Cube3D.js"></script>
<script>

	var cube;
	var angle = 0;
	function run() {
		cube.draw(20, 3, 3);
		//setTimeout(run, 33);
	}
	
	window.onload=function(){
		cube = new Cube3D("cube");
		run();
	};
</script>
</head>


<body>
	<canvas id="cube" width="400" height="250"></canvas>
</body>
</html>
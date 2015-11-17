ProximityFigure = function(cid, max) {
	this.c = document.getElementById(cid);
	this.ctx = this.c.getContext('2d');
	this.dist = -1;
	this.draw = function(dist) {
//		if(this.dist != dist) {
			this.dist = dist;

			var w = this.c.width;
			var h = this.c.height;
			var unitX = w/16; // x unit
			var unitY = h/16; // y unit

			this.ctx.clearRect(0, 0, w, h);
			dist = dist * unitX/2;

			var mobMarginTop = unitY; // margin top
			var mobMarginBottom = 0; // margin bottom
			var mobMarginLeft = unitX*3; // margin left
			var mobWidth = unitX; // component width;
			var mobTiltUnit = 2; // tilt unit
			var mobHeight = h-mobMarginTop-mobMarginBottom-mobTiltUnit*unitY*2; // component height;

			var brickTiltUnit = 1; // tilt unit
			var brickMarginTop = unitY*2; // margin top
			var brickMarginBottom = unitY*2; // margin bottom
			var brickWidth = unitX*2; // component width;
			var brickMarginLeft = mobMarginLeft-brickWidth+unitX/2; // margin left
			var brickHeight = h-brickMarginTop-brickMarginBottom-brickTiltUnit*unitY*2; // component height;

			var startX;
			/****************************************
			 * Draw mobile device
			 ****************************************/

			this.ctx.strokeStyle = "black";
			this.ctx.fillStyle = "#eeeeee";

			startX = mobMarginLeft+dist;
			this.ctx.beginPath();
			this.ctx.moveTo(startX, mobMarginTop);
			this.ctx.lineTo(startX+mobWidth, mobMarginTop);
			this.ctx.lineTo(startX+mobWidth+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit);
			this.ctx.lineTo(startX+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit);
			this.ctx.lineTo(startX, mobMarginTop);
			this.ctx.stroke();
			this.ctx.fill();
			this.ctx.closePath();

			this.ctx.beginPath();
			this.ctx.moveTo(startX, mobMarginTop);
			this.ctx.lineTo(startX+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit);
			this.ctx.lineTo(startX+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit+mobHeight);
			this.ctx.lineTo(startX, mobMarginTop+mobHeight);
			this.ctx.lineTo(startX, mobMarginTop);
			this.ctx.stroke();
			this.ctx.fill();
			this.ctx.closePath();

			this.ctx.beginPath();
			this.ctx.moveTo(startX+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit);
			this.ctx.lineTo(startX+mobWidth+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit);
			this.ctx.lineTo(startX+mobWidth+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit+mobHeight);
			this.ctx.lineTo(startX+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit+mobHeight);
			this.ctx.lineTo(startX+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit);
			this.ctx.stroke();
			this.ctx.fill();
			this.ctx.closePath();

			this.ctx.strokeStyle = "rgba(100, 100, 100, 0.3)";
			this.ctx.beginPath();
			this.ctx.moveTo(startX+mobWidth, mobMarginTop);
			this.ctx.lineTo(startX+mobWidth, mobMarginTop+mobHeight);
			this.ctx.lineTo(startX+mobWidth+unitX*mobTiltUnit, mobMarginTop+unitY*mobTiltUnit+mobHeight);
			this.ctx.moveTo(startX+mobWidth, mobMarginTop+mobHeight);
			this.ctx.lineTo(startX, mobMarginTop+mobHeight);
			this.ctx.stroke();
			this.ctx.closePath();

			/****************************************
			 * Draw distance line
			 ****************************************/
			this.ctx.strokeStyle = "red";
			this.ctx.fillStyle = "#CC3910";

			startX = brickMarginLeft+brickWidth+unitX*brickTiltUnit/2;
			this.ctx.beginPath();
			this.ctx.moveTo(startX, h/2);
			this.ctx.lineTo(startX+dist, h/2);
			this.ctx.stroke();
			this.ctx.closePath();

			this.ctx.beginPath();
			this.ctx.arc(startX+dist, h/2, unitX/8, 0, 2*Math.PI, false);
			this.ctx.fill();
			this.ctx.closePath();

			var arrowRateX = 5;
			var arrowRateY = 3;
			this.ctx.beginPath();
			this.ctx.moveTo(startX-unitX/arrowRateX, h/2);
			this.ctx.lineTo(startX, h/2-unitY/arrowRateY);
			this.ctx.lineTo(startX, h/2+unitY/arrowRateY);
			this.ctx.lineTo(startX-unitX/arrowRateX, h/2);
			this.ctx.fill();
			this.ctx.closePath();

			/****************************************
			 * Draw brick
			 ****************************************/
			this.ctx.strokeStyle = "black";
			this.ctx.fillStyle = "rgba(201, 163, 146, 0.9)";

			this.ctx.beginPath();
			this.ctx.moveTo(brickMarginLeft, brickMarginTop);
			this.ctx.lineTo(brickMarginLeft+brickWidth, brickMarginTop);
			this.ctx.lineTo(brickMarginLeft+brickWidth+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit);
			this.ctx.lineTo(brickMarginLeft+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit);
			this.ctx.lineTo(brickMarginLeft, brickMarginTop);
			this.ctx.stroke();
			this.ctx.fill();
			this.ctx.closePath();

			this.ctx.beginPath();
			this.ctx.moveTo(brickMarginLeft, brickMarginTop);
			this.ctx.lineTo(brickMarginLeft+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit);
			this.ctx.lineTo(brickMarginLeft+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit+brickHeight);
			this.ctx.lineTo(brickMarginLeft, brickMarginTop+brickHeight);
			this.ctx.lineTo(brickMarginLeft, brickMarginTop);
			this.ctx.stroke();
			this.ctx.fill();
			this.ctx.closePath();

			this.ctx.beginPath();
			this.ctx.moveTo(brickMarginLeft+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit);
			this.ctx.lineTo(brickMarginLeft+brickWidth+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit);
			this.ctx.lineTo(brickMarginLeft+brickWidth+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit+brickHeight);
			this.ctx.lineTo(brickMarginLeft+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit+brickHeight);
			this.ctx.lineTo(brickMarginLeft+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit);
			this.ctx.stroke();
			this.ctx.fill();
			this.ctx.closePath();

			this.ctx.strokeStyle = "rgba(50, 50, 50, 0.3)";
			this.ctx.beginPath();
			this.ctx.moveTo(brickMarginLeft+brickWidth, brickMarginTop);
			this.ctx.lineTo(brickMarginLeft+brickWidth, brickMarginTop+brickHeight);
			this.ctx.lineTo(brickMarginLeft+brickWidth+unitX*brickTiltUnit, brickMarginTop+unitY*brickTiltUnit+brickHeight);
			this.ctx.moveTo(brickMarginLeft+brickWidth, brickMarginTop+brickHeight);
			this.ctx.lineTo(brickMarginLeft, brickMarginTop+brickHeight);
			this.ctx.stroke();
			this.ctx.closePath();

			/****************************************
			 * Draw text
			 ****************************************/
			this.ctx.textBaseline = "top";
			this.ctx.font = "bold 11pt Courier New";
			this.ctx.fillStyle = "#CC3910";
			this.ctx.fillText(roundXL(this.dist, 2)+" cm", brickMarginLeft+brickTiltUnit*unitX+brickWidth/4, brickMarginTop+brickHeight+brickTiltUnit*unitY+brickMarginBottom/4);
//		}
	};
};

function roundXL(n, digits) {
	if (digits >= 0) return parseFloat(n.toFixed(digits));

	digits = Math.pow(10, digits);
	var t = Math.round(n * digits) / digits;

	return parseFloat(t.toFixed(0));
}

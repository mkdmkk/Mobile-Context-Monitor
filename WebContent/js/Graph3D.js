Graph3D = function(cid, label, unit, range) {
	// initialise
	this.c = document.getElementById(cid);
	this.ctx = this.c.getContext('2d');
	var sizeAll = 0;
	if (this.c.width >= this.c.height) {
		sizeAll = this.c.height;
	} else if(this.c.height > this.c.width) {
		sizeAll = this.c.width;
	}
	this.ctx.clearRect(0, 0, sizeAll*2, sizeAll*2);
	//define some constants
	this.containerWidth = sizeAll; 	//default
	this.containerHeight = sizeAll;	//default  
	this.padding=10;
	this.xMid=this.containerWidth/2;
	this.yMid=this.containerHeight/2;
	this.startX=this.xMid-this.containerWidth/8;
	this.startY=this.yMid+this.containerWidth/8;
	this.gray1="#c1c1c1";
	this.gray2="#f1f1f1	";
	this.gray3="#787878";
	this.stepX=this.xMid/10;

	// min - max range, defalut value
	this.xMin=-range;
	this.xMax=range;
	this.yMin=-range;
	this.yMax=range;
	this.zMin=-range;
	this.zMax=range;

	this.label = label;
	this.unit = unit;
	this.range = range;

	this.factor=(this.stepX / 1.5);
	this.perspectiveFactor = 1.2;

	// Draw XYZ AXIS 
//	this.drawAxis();
//	if(info == undefined){
//	this.drawInfo('gInfo');
//	}else{
//	this.drawInfo(info);
//	}	

};

Graph3D.prototype.drawAxis=function(){

	this.ctx.fillStyle = this.gray1;
	this.ctx.strokeStyle= this.gray1;

	//draw Z-axis
	this.ctx.beginPath();
	this.ctx.moveTo((this.startX),(this.startY));
	this.ctx.lineTo(this.padding,this.containerHeight-this.padding);
	this.ctx.stroke();
	this.ctx.closePath();
	//draw Y-axis	
	this.ctx.fillRect(this.startX,this.padding,1,(this.startY-this.padding));
	//draw X-axis
	this.ctx.fillRect(this.startX,this.startY,(this.startY-this.padding),1);

	this.yHeight = this.startY - (2 * this.stepX);

	sx=this.startX;
	markH=this.containerHeight/100;
	sy=this.startY;
	this.ctx.strokeStyle=this.ctx.fillStyle = this.gray3;
	xx=sx;
	yy=sy;

	this.marginX=this.padding + this.startY - (10*this.stepX) - (this.padding);	
	for(var i=0;i<12;i++){

		sx=sx+this.stepX;
		sy=sy-(this.stepX);

		xx=xx-this.factor;
		yy=yy+this.factor;
		this.ctx.strokeStyle=this.ctx.fillStyle = "rgba(200,200,200,0.5)";

		//Draw mark on Axis
		this.ctx.strokeStyle=this.ctx.fillStyle = this.gray3;	

		this.ctx.fillRect(sx,this.startY-(markH/2),1,markH);
		this.ctx.fillRect(this.startX-(markH/2),sy,markH,1);

		this.ctx.beginPath();
		this.ctx.moveTo(xx-(markH/2),yy-(markH/2));
		this.ctx.lineTo(xx,yy);
		this.ctx.stroke(); 
	}
};

Graph3D.prototype.draw = function(x,y,z) {
	this.ctx.clearRect(0, 0, this.c.width, this.c.height);
	this.drawAxis();
	
	if (x == undefined) {
		x = 0, y = 0, z = 0;
	}
	
	var graph_step_x=(this.xMax-this.xMin)/10;
	var graph_step_y=(this.yMax-this.yMin)/10;
	var graph_step_z=(this.zMax-this.zMin)/10;

	var pcyz = ((y/this.yMin*10) * this.factor * this.perspectiveFactor - (y/this.yMax*(10/this.perspectiveFactor)) * this.perspectiveFactor) * (z/this.zMax*1) ;
	var pcx = ((x/this.xMax*10) * this.factor * this.perspectiveFactor  - (x/this.xMax*(10/this.perspectiveFactor)) * this.perspectiveFactor) * (z/this.zMax*1); 

	y_height_scaled=(y * this.stepX/graph_step_y) + pcyz;
	x_width_scaled=(x * this.stepX/graph_step_x) + pcx;
	z_len_scaled=(z * this.factor/graph_step_z);

	x_scaled=this.startX + x_width_scaled ;
	y_scaled=this.startY - y_height_scaled;

	//x_3d and y_3d are 2D representation of any  3D XYZ Coordinates within given range (xyz max - min )
	x_3d=x_scaled-z_len_scaled;
	y_3d=y_scaled+z_len_scaled;

	//main color
	this.ctx.fillStyle = "rgba(0,0,0,0.7)";
//	this.ctx.fillRect(x_3d,y_3d,1,y_height_scaled);


	calibriatedX = (this.containerWidth-this.startX-this.padding-5)*x/(this.xMax-0);
	calibriatedY = -(this.startY-this.padding-5)*y/(this.yMax-0);
	calibriatedZ = z*(this.startX-this.padding)/(this.zMax-0);

	this.ctx.fillStyle = "rgba(127,127,127,0.3)";
	// X
	this.ctx.fillRect(this.startX,this.startY-2.5,calibriatedX,3);
	// Y
	this.ctx.fillRect(this.startX -2.5,this.startY, 3, calibriatedY);
	// Z
	this.ctx.beginPath();
	this.ctx.moveTo((this.startX-1.5),(this.startY-1.5));
	this.ctx.lineTo(this.startX-1.5-calibriatedZ,this.startY-1.5+calibriatedZ);
	this.ctx.strokeStyle = "rgba(127,127,127,0.3)";
	this.ctx.stroke();
	this.ctx.closePath();

	this.ctx.beginPath();
	this.ctx.moveTo((this.startX-1.0),(this.startY-1.0));
	this.ctx.lineTo(this.startX-1.0-calibriatedZ,this.startY-1.0+calibriatedZ);
	this.ctx.strokeStyle = "rgba(127,127,127,0.3)";
	this.ctx.stroke();
	this.ctx.closePath();

	this.ctx.beginPath();
	this.ctx.moveTo((this.startX-0.5),(this.startY-0.5));
	this.ctx.lineTo(this.startX-0.5-calibriatedZ,this.startY-0.5+calibriatedZ);
	this.ctx.strokeStyle = "rgba(127,127,127,0.3)";
	this.ctx.stroke();
	this.ctx.closePath();

	this.ctx.beginPath();
	this.ctx.moveTo((this.startX+calibriatedX-calibriatedZ),(this.startY+calibriatedY+calibriatedZ));
	this.ctx.lineTo(this.startX +calibriatedX,this.startY+calibriatedY);
	this.ctx.strokeStyle = "rgba(127,127,127,0.3)";
	this.ctx.stroke();
	this.ctx.closePath();

	this.ctx.beginPath();
	this.ctx.moveTo((this.startX),(this.startY+calibriatedY));
	this.ctx.lineTo(this.startX-calibriatedZ,this.startY+calibriatedZ+calibriatedY);
	this.ctx.strokeStyle = "rgba(127,127,127,0.3)";
	this.ctx.stroke();
	this.ctx.closePath();

	this.ctx.beginPath();
	this.ctx.moveTo((this.startX+calibriatedX),(this.startY));
	this.ctx.lineTo(this.startX+calibriatedX-calibriatedZ,this.startY+calibriatedZ);
	this.ctx.strokeStyle = "rgba(127,127,127,0.3)";
	this.ctx.stroke();
	this.ctx.closePath();


	this.ctx.fillStyle = "rgba(127,127,127,0.1)";
	this.ctx.fillRect(this.startX,this.startY+calibriatedY,calibriatedX,1);
	this.ctx.fillRect(this.startX +calibriatedX,this.startY, 1, calibriatedY);
	this.ctx.fillRect(this.startX-calibriatedZ,this.startY+calibriatedZ, calibriatedX, 1);
	this.ctx.fillRect(this.startX-calibriatedZ,this.startY+calibriatedZ+calibriatedY, calibriatedX, 1);
	this.ctx.fillRect(this.startX-calibriatedZ,this.startY+calibriatedZ, 1, calibriatedY);
	this.ctx.fillRect(this.startX-calibriatedZ+calibriatedX,this.startY+calibriatedZ, 1, calibriatedY);

	this.ctx.beginPath();
	this.ctx.moveTo(this.startX,this.startY);

	this.ctx.lineTo(this.startX+calibriatedX-calibriatedZ, this.startY+calibriatedY+calibriatedZ);
	this.ctx.linewidth = 15.0;
	this.ctx.lineCap = 'round';
	this.ctx.strokeStyle = "rgba(255,0,0,1)";
	this.ctx.stroke();
	this.ctx.closePath();

	var total = Math.sqrt(x*x+y*y+z*z);
	var totalresult = total.toFixed(1);
	var xNumber = new Number(x);
	var yNumber = new Number(y);
	var zNumber = new Number(z);
	
//	if(yNumber >= 0 ){
//		this.ctx.textBaseline = "top";
//		this.ctx.font = "8pt arial";
//		this.ctx.fillStyle = "black";
//		this.ctx.fillText ("0", this.startX, this.startY+5);
//		this.ctx.fillText (this.range, 0, this.containerHeight*9/10);
//		this.ctx.fillText (this.range, this.containerWidth*9/10 , this.startY*9/10);
//		this.ctx.fillText (this.range, this.startX-20, 5);
//		this.ctx.fillText (this.label+"x",this.containerWidth*9/10, this.startY*41/40);
//		this.ctx.fillText (this.label+"y", this.startX, 0);
//		this.ctx.fillText (this.label+"z", 18, this.containerHeight*9/10);
//
//		this.ctx.fillText (this.label+"x:",this.containerWidth-140, this.containerHeight-43);
//		this.ctx.fillText (this.label+"y:",this.containerWidth-140, this.containerHeight-32);
//		this.ctx.fillText (this.label+"z:",this.containerWidth-140, this.containerHeight-21);
//		this.ctx.fillStyle = "black";
//
//		this.ctx.fillText (xNumber.toFixed(1), this.containerWidth-45, this.containerHeight-43);
////		result = y.toFixed(2);
//		this.ctx.fillText (yNumber.toFixed(1), this.containerWidth-45, this.containerHeight-32);
////		result = z.toFixed(2);
//		this.ctx.fillText (zNumber.toFixed(1), this.containerWidth-45, this.containerHeight-21);
//
//
//
//		this.ctx.fillText (this.unit,this.containerWidth-25, this.containerHeight-43);
//		this.ctx.fillText (this.unit,this.containerWidth-25, this.containerHeight-32);
//		this.ctx.fillText (this.unit,this.containerWidth-25, this.containerHeight-21);
//		this.ctx.fillStyle = "red";
//		this.ctx.fillText (this.label+":",this.containerWidth-140, this.containerHeight-10);	
//		this.ctx.fillText (totalresult, this.containerWidth-40, this.containerHeight-10);
//		this.ctx.fillText (this.unit,this.containerWidth-25, this.containerHeight-10);
//		this.ctx.fillStyle = "black";
//		this.ctx.font = "5pt arial";
////		this.ctx.fillText ("2",this.containerWidth-4, this.containerHeight-45);
////		this.ctx.fillText ("2",this.containerWidth-4, this.containerHeight-34);
////		this.ctx.fillText ("2",this.containerWidth-4, this.containerHeight-23);
//		this.ctx.fillStyle = "red";
////		this.ctx.fillText ("2",this.containerWidth-4, this.containerHeight-12);
//	} else {
		this.ctx.textBaseline = "top";
		this.ctx.font = "8pt arial";
		this.ctx.fillStyle = "black";
		this.ctx.fillText ("0", this.startX, this.startY+5);
		this.ctx.fillText (this.range, 0, this.containerHeight*9/10);
		this.ctx.fillText (this.range, this.containerWidth*9/10 , this.startY*9/10);
		this.ctx.fillText (this.range, this.startX-20, 5);
		this.ctx.fillText (this.label+"x", this.containerWidth*9/10, this.startY*41/40);
		this.ctx.fillText (this.label+"y", this.startX+5, 5);
		this.ctx.fillText (this.label+"z", this.containerWidth/10, this.containerHeight*9/10);

		this.ctx.fillText (this.label+"x:",this.c.width*7/10, 21);
		this.ctx.fillText (this.label+"y:",this.c.width*7/10, 32);
		this.ctx.fillText (this.label+"z:",this.c.width*7/10, 43);
		this.ctx.fillStyle = "black";

		this.ctx.fillText (xNumber.toFixed(1), this.c.width*7/10+20, 21);
//		result = y.toFixed(2);
		this.ctx.fillText (yNumber.toFixed(1), this.c.width*7/10+20, 32);
//		result = z.toFixed(2);
		this.ctx.fillText (zNumber.toFixed(1), this.c.width*7/10+20, 43);

		this.drawUnit(this.c.width*7/10+50, 21);
		this.drawUnit(this.c.width*7/10+50, 32);
		this.drawUnit(this.c.width*7/10+50, 43);
		
		//this.ctx.fillText (this.unit,this.c.width*7/10+50, 21);
//		this.ctx.fillText (this.unit,this.c.width*7/10+50, 32);
//		this.ctx.fillText (this.unit,this.c.width*7/10+50, 43);
		
		this.ctx.fillStyle = "red";
		this.ctx.fillText (this.label+":",this.c.width*7/10, 10);	
		this.ctx.fillText (totalresult, this.c.width*7/10+20, 10);
		this.drawUnit(this.c.width*7/10+50, 10);
		//this.ctx.fillText (this.unit, this.c.width*7/10+50, 10);
		this.ctx.fillStyle = "black";
		this.ctx.font = "5pt arial";
//		this.ctx.fillText ("2",this.containerWidth-4, 19);
//		this.ctx.fillText ("2",this.containerWidth-4, 30);
//		this.ctx.fillText ("2",this.containerWidth-4, 41);
		this.ctx.fillStyle = "red";
//		this.ctx.fillText ("2",this.containerWidth-4, 8);
//	}
};


Graph3D.prototype.drawUnit = function(x, y) {
	var indexOfSquare = this.unit.indexOf("^2");
	if(indexOfSquare != -1) {
		var unit = this.unit.substring(0, indexOfSquare);
		this.ctx.fillText (unit, x, y);
		var prevFont = this.ctx.font;
		this.ctx.font = "5pt arial";
		this.ctx.fillText ("2", x+20, y);
		this.ctx.font = prevFont;
	} else {
		this.ctx.fillText (this.unit, x, y);	
	}
};

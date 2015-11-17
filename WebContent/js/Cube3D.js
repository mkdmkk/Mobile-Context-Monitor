Point3D = function(x, y, z) {
	this.x = x;
	this.y = y;
	this.z = z;

	this.rotateX = function(angle) {
		var rad, cosa, sina, y, z;
		rad = angle * Math.PI / 180;
		cosa = Math.cos(rad);
		sina = Math.sin(rad);
		y = this.y * cosa - this.z * sina;
		z = this.y * sina + this.z * cosa;
		return new Point3D(this.x, y, z);
	};

	this.rotateY = function(angle) {
		var rad, cosa, sina, x, z;
		rad = angle * Math.PI / 180;
		cosa = Math.cos(rad);
		sina = Math.sin(rad);
		z = this.z * cosa - this.x * sina;
		x = this.z * sina + this.x * cosa;
		return new Point3D(x,this.y, z);
	};

	this.rotateZ = function(angle) {
		var rad, cosa, sina, x, y;
		rad = angle * Math.PI / 180;
		cosa = Math.cos(rad);
		sina = Math.sin(rad);
		y = this.x * sina - this.y * cosa;
		x = this.x * cosa + this.y * sina;
		return new Point3D(x, y, this.z);
	};

	this.project = function(viewWidth, viewHeight, fov, viewDistance) {
//		var factor, x, y;
//		factor = fov / (viewDistance + this.z);
//		x = this.x * factor + viewWidth / 2;
//		y = this.y * factor + viewHeight / 2;
//		return new Point3D(x, y, this.z);
		var factor, x, y;
		factor = fov / (viewDistance + this.z);
		x = this.x * factor + viewWidth / 3;
		y = this.y * factor + viewHeight / 2;
		return new Point3D(x, y, this.z);
	};

	this.rotate = function(xsin,ysin,zsin) {

	};
};

Cube3D = function(cid) {
	var x = 0.5;
	var y = 1;
	var z = 0.2;
	this.vertices = [
//new Point3D(-x,y,-z),
//new Point3D(x,y,-z),
//new Point3D(x,-y,-z),
//new Point3D(-x,-y,-z),
//new Point3D(-x,y,z),
//new Point3D(x,y,z),
//new Point3D(x,-y,z),
//new Point3D(-x,-y,z)
new Point3D(-x,y,-z),
new Point3D(x,y,-z),
new Point3D(x,-y,-z),
new Point3D(-x,-y,-z),
new Point3D(-x,y,z),
new Point3D(x,y,z),
new Point3D(x,-y,z),
new Point3D(-x,-y,z)
];

	// Define the vertices that compose each of the 6 faces. These numbers are
	// indices to the vertex list defined above.
	this.faces  = [[0,1,2,3],[1,5,6,2],[5,4,7,6],[4,0,3,7],[0,4,5,1],[3,2,6,7]];

	// Define the colors for each face.
	//this.colors = [[204,103,93],[148,178,0],[174,210,255],[211,190,255],[233,255,126],[250,231,126]];
	this.colors = ["#FFD9C3", "#FFD79E", "#FFFCB6", "#E0FFA4", "#D9F8FF", "#DAD1FF"];

	this.cid = cid;
	this.c = document.getElementById(cid);
	this.ctx = this.c.getContext('2d');

	/* Constructs a CSS RGB value from an array of 3 elements. */
	this.arrayToRGB = function(arr) {
		if( arr.length == 3 ) {
			return "rgb(" + arr[0] + "," + arr[1] + "," + arr[2] + ")";
		}
		return "rgb(0,0,0)";
	};

	this.draw = function(ax, ay, az) {
		var t = new Array();

		this.ctx.clearRect(0,0,this.c.width,this.c.height);

		for( var i = 0; i < this.vertices.length; i++ ) {
			var v = this.vertices[i];
			var r = v.rotateX(ay).rotateY(az).rotateZ(ax);
			var p = r.project(this.c.width,this.c.height,200,4);
			t.push(p);
		}

		if(t[0].z < t[1].z) {
			this.drawAxis(t[4], t[3], t[5], t[2], 0, 0.6, "x");
		} else {
			this.drawAxis(t[4], t[3], t[5], t[2], 0.6, 0);
		}
		if(t[0].z > t[3].z) {
			this.drawAxis(t[3], t[6], t[0], t[5], 0, 0.3, "y");
		} else {
			this.drawAxis(t[3], t[6], t[0], t[5], 0.3, 0);
		}
		if(t[0].z > t[4].z) {
			this.drawAxis(t[5], t[7], t[1], t[3], 0, 1.2, "z");
		} else {
			this.drawAxis(t[5], t[7], t[1], t[3], 1.2, 0);
		}
		
		var avg_z = new Array();

		for( var i = 0; i < this.faces.length; i++ ) {
			var f = this.faces[i];
			avg_z[i] = {"index":i, "z":(t[f[0]].z + t[f[1]].z + t[f[2]].z + t[f[3]].z) / 4.0};
		}
		avg_z.sort(function(a,b) {
			return b.z - a.z;
		});

		for( var i = 0; i < this.faces.length; i++ ) {
			var f = this.faces[avg_z[i].index];

			//this.ctx.fillStyle = this.arrayToRGB(this.colors[avg_z[i].index]);
			this.ctx.fillStyle = this.colors[avg_z[i].index];
			this.ctx.strokeStyle = "rgb(200, 200, 200)";
			this.ctx.beginPath();
			this.ctx.moveTo(t[f[0]].x,t[f[0]].y);
			this.ctx.lineTo(t[f[1]].x,t[f[1]].y);
			this.ctx.lineTo(t[f[2]].x,t[f[2]].y);
			this.ctx.lineTo(t[f[3]].x,t[f[3]].y);
			this.ctx.closePath();
			this.ctx.stroke();
			this.ctx.fill();
		}

		if(t[0].z < t[1].z) {
			this.drawAxis(t[4], t[3], t[5], t[2], 0.6, 0);
		} else {
			this.drawAxis(t[4], t[3], t[5], t[2], 0, 0.6, "x");
		}
		if(t[0].z > t[3].z) {
			this.drawAxis(t[3], t[6], t[0], t[5], 0.3, 0);
		} else {
			this.drawAxis(t[3], t[6], t[0], t[5], 0, 0.3, "y");
		}
		if(t[0].z > t[4].z) {
			this.drawAxis(t[5], t[7], t[1], t[3], 1.2, 0);
		} else {
			this.drawAxis(t[5], t[7], t[1], t[3], 0, 1.2, "z");
		}

//		this.ctx.textBaseline = "top";
//		this.ctx.font = "bold 11pt Courier New";
//		this.ctx.fillStyle = "CC3910";
//		this.ctx.fillText("1", t[0].x, t[0].y);
//		this.ctx.fillText("2", t[1].x, t[1].y);
//		this.ctx.fillText("3", t[2].x, t[2].y);
//		this.ctx.fillText("4", t[3].x, t[3].y);
//		this.ctx.fillText("5", t[4].x, t[4].y);
//		this.ctx.fillText("6", t[5].x, t[5].y);
//		this.ctx.fillText("7", t[6].x, t[6].y);
//		this.ctx.fillText("8", t[7].x, t[7].y);

		this.ctx.textBaseline = "top";
		this.ctx.font = "bold 9pt Courier New";
		this.ctx.fillStyle = "#CC3910";
		this.ctx.fillText("Azimuth:	"+roundXL(ax, 2), this.c.width-100, 15);
		this.ctx.fillText("Pitch:	"+roundXL(ay, 2), this.c.width-100, 30);
		this.ctx.fillText("Roll:	"+roundXL(az, 2), this.c.width-100, 45);
	};

	this.drawAxis = function(a, b, c, d, m, n, label) {
		var x1 = Math.abs(a.x+(b.x-a.x)/2);
		var y1 = Math.abs(a.y+(b.y-a.y)/2);
		var x2 = Math.abs(c.x+(d.x-c.x)/2);
		var y2 = Math.abs(c.y+(d.y-c.y)/2);
		var xe = Math.abs(x1-x2);
		var ye = Math.abs(y1-y2);
		var endX;
		var endY;

		this.ctx.strokeStyle = "rgba(50, 50, 50, 0.3)";
		this.ctx.beginPath();

		if(x1 < x2) {
			if(y1 < y2) {
				endX = x2+xe*n;
				endY = y2+ye*n;
				this.ctx.moveTo(x1, y1);
				this.ctx.lineTo(x1-xe*m, y1-ye*m);
				this.ctx.moveTo(x2, y2);
				this.ctx.lineTo(x2+xe*n, y2+ye*n);
			} else {
				endX = x2+xe*n;
				endY = y2-ye*n;
				this.ctx.moveTo(x1, y1);
				this.ctx.lineTo(x1-xe*m, y1+ye*m);
				this.ctx.moveTo(x2, y2);
				this.ctx.lineTo(x2+xe*n, y2-ye*n);
			}
		} else {
			if(y1 < y2) {
				endX = x2-xe*n;
				endY = y2+ye*n;
				this.ctx.moveTo(x1, y1);
				this.ctx.lineTo(x1+xe*m, y1-ye*m);
				this.ctx.moveTo(x2, y2);
				this.ctx.lineTo(x2-xe*n, y2+ye*n);
			} else {
				endX = x2-xe*n;
				endY = y2-ye*n;
				this.ctx.moveTo(x1, y1);
				this.ctx.lineTo(x1+xe*m, y1+ye*m);
				this.ctx.moveTo(x2, y2);
				this.ctx.lineTo(x2-xe*n, y2-ye*n);
			}
		}
		
		if(label != undefined) {
			this.ctx.textBaseline = "top";
			this.ctx.font = "bold 11pt Courier New";
			this.ctx.fillStyle = "#CC3910";
			this.ctx.fillText(label, endX, endY);
		}
		
		this.ctx.closePath();
		this.ctx.stroke();
	};
};


function roundXL(n, digits) {
	if (digits >= 0) return parseFloat(n.toFixed(digits));

	digits = Math.pow(10, digits);
	var t = Math.round(n * digits) / digits;

	return parseFloat(t.toFixed(0));
}

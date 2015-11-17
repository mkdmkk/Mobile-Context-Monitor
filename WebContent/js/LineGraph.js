/**
 * 
 */

LineGraph = function(cid, label, unit) {

	this.c = document.getElementById(cid);
	this.rg;
	this.cid = cid;
	this.unit = unit;
	this.ctx = this.c.getContext('2d');
	this.label = label;
	for(var i = 0; i < label.length; i++) {
		label[i] = label[i]+' ('+this.unit[i]+')';
	}
	
	this.draw = function(v) {
		this.ctx.clearRect(0, 0, this.c.width, this.c.height);
		switch(this.label.length) {
		case 1:
			this.rg = new RGraph.Line(this.cid, v[0]);
			this.rg.Set('chart.background.barcolor1', 'white');
			break;
		case 2:
			this.rg = new RGraph.Line(this.cid, v[0], v[1]);
			this.rg.Set('chart.background.barcolor1', 'white');
			this.rg.Set('chart.background.barcolor2', 'white');
			break;
		case 3:
			this.rg = new RGraph.Line(this.cid, v[0], v[1], v[2]);
			this.rg.Set('chart.background.barcolor1', 'white');
			this.rg.Set('chart.background.barcolor2', 'white');
			this.rg.Set('chart.background.barcolor3', 'white');
			break;
		}
		this.rg.Set('chart.background.grid', true);
		this.rg.Set('chart.linewidth', 1);
		this.rg.Set('chart.gutter.left', 30);
		this.rg.Set('chart.gutter.right', 5);
		this.rg.Set('chart.gutter.top', 20);
		this.rg.Set('chart.gutter.bottom', 5);
		this.rg.Set('chart.text.size', 8);
		if (RGraph.isIE9up()) {
			this.rg.Set('chart.shadow', true);
		}
		this.rg.Set('chart.tickmarks', null);
		//this.rg.Set('chart.units.post', this.unit);
		this.rg.Set('chart.ylabels.count', 3);
		this.rg.Set('chart.xticks', 8);
		this.rg.Set('chart.colors', [ 'red', 'green', 'blue' ]);
		this.rg.Set('chart.key.halign', 'left');
		this.rg.Set('chart.key.shadow', true);
		this.rg.Set('chart.key.shadow.offsetx', 0);
		this.rg.Set('chart.key.shadow.offsety', 0);
		this.rg.Set('chart.key.shadow.blur', 15);
		this.rg.Set('chart.key.shadow.color', '#ddd');
		this.rg.Set('chart.key.rounded', true);
		this.rg.Set('chart.key.position', 'gutter');
		this.rg.Set('chart.key.position.x',
				this.rg.Get('chart.gutter.left'));
		this.rg.Set('chart.key.position.y', 5);
		this.rg.Set('chart.xaxispos', 'center');
		this.rg.Set('chart.background.grid.autofit', true);
		this.rg.Set('chart.background.grid.autofit.numhlines', 10);
		this.rg.Set('chart.key', this.label);
		this.rg.Set('chart.curvy', true);
		this.rg.Set('chart.curvy.factor', 0.25);
		this.rg.Draw();	
	};
};

/**
 * 
 */

ProgressGraph = function(cid, unit, max, colors) {

	this.c = document.getElementById(cid);
	this.rg;
	this.cid = cid;
	this.curr = 0;
	this.unit = unit;
	this.max = max;
	this.ctx = this.c.getContext('2d');
	this.colors = colors;
//	this.crad = this.ctx.createLinearGradient(0, 0, this.c.width, 0);
//	for(var i = 0; i < colors.length; i++) {
//		this.crad.addColorStop(1.0/colors.length*i, colors[i]);
//	}
	
	this.draw = function(curr){
		RGraph.Clear(this.c);
		if(curr == undefined) {
			this.rg = new RGraph.HProgress(this.cid, 0, this.max);
			this.rg.Set('chart.colors', ['gray']);
		} else {
			this.rg = new RGraph.HProgress(this.cid, curr, this.max);
			var idx = curr/(this.max/this.colors.length);
			this.rg.Set('chart.colors', [ this.colors[parseInt(idx)] ]);
		}
		//graph.Set('chart.title', 'Light');
		this.rg.Set('chart.key', [ this.unit ]);
		this.rg.Set('chart.gutter.left', 5);
		this.rg.Set('chart.gutter.right', 20);
		this.rg.Set('chart.gutter.bottom', 20);
		this.rg.Set('chart.key.position.x', this.c.width-this.rg.Get('chart.gutter.right')*3);
		this.rg.Set('chart.key.position.y', this.rg.Get('chart.gutter.top')/2);
		this.rg.Set('chart.numticks', 5);
		/* graph.Set('chart.tooltips', ['Light']); */
		/* graph.Set('chart.units.post', 'lux'); */
		this.rg.Set('chart.tickmarks.zerostart', true);
		this.rg.Draw();	
	};
};

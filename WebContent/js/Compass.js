/**
 * 
 */

Compass = function(cid) {

	this.c = document.getElementById(cid);
	this.rg;
	this.cid = cid;
	this.ctx = this.c.getContext('2d');
	
	this.draw = function(curr){
		RGraph.Clear(this.c);
		if(curr == undefined) {
			this.rg = new RGraph.Odometer(this.cid, 0, 360, 0);
		} else {
			this.rg = new RGraph.Odometer(this.cid, 0, 360, curr);
		}
		this.rg.Set('chart.needle.color', 'black');
		this.rg.Set('chart.needle.tail', false);
        this.rg.Set('chart.label.area', 25);
        this.rg.Set('chart.border', false);
		this.rg.Set('chart.labels', ['N','NE','E','SE','S','SW','W','NW']);
		this.rg.Set('chart.value.text', true);
		this.rg.Set('chart.value.units.post', '°');
		
		this.rg.Set('chart.yellow.color', this.rg.Get("chart.green.color"));
		this.rg.Set('chart.red.color', this.rg.Get("chart.green.color"));
        
		this.rg.Draw();	
	};
};

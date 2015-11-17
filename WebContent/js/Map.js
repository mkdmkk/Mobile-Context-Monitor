/*
 * <script type="text/javascript"
	src="http://maps.google.com/maps/api/js?sensor=false"></script>

 */

Map = function(cid) {
	this.marker = null;
	this.posit = new google.maps.LatLng(137.507, 126.952);
	this.options = {
			zoom: 16,
			center: this.posit,
			mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	this.map = new google.maps.Map(document.getElementById(cid), this.options);
};

Map.prototype.draw = function(lat, lng) {
	if(lat == undefined) {
	} else {
		lat = lat.toFixed(5);
		lng = lng.toFixed(5);
		if(this.map != null) {
			if(this.posit.lat() != lat || this.posit.lng() != lng) {
//				alert(this.posit.lat() +" "+lat+" "+this.posit.lng()+" "+lng);
				this.posit = new google.maps.LatLng(lat, lng);
				this.map.panTo(this.posit);
				if(this.marker == null) {
					this.marker = new google.maps.Marker({
						position: this.posit,
//						title:"Here!"
					});
					this.marker.setMap(this.map);
				} else {
					this.marker.setPosition(this.posit);
					this.marker.setMap(this.map);
				}
			}
		}
	}
};

MapForPath = function(cid) {
	this.marker = null;
	this.posit = [new google.maps.LatLng(137.507, 126.952)];
	this.options = {
			zoom: 16,
			center: this.posit[0],
			mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	this.map = new google.maps.Map(document.getElementById(cid), this.options);
	this.path = new google.maps.Polyline();
	this.end = new google.maps.Marker();
	this.start = new google.maps.Marker();
};

MapForPath.prototype.draw = function(lat, lng) {
	if(lat == undefined) {
	} else {
		var cnt = 0;
		if(lat.length > 0) {
			for(var i = 0; i < lat.length; i++) {
				lat[i] = lat[i].toFixed(5);
				lng[i] = lng[i].toFixed(5);
				if(cnt == 0 || this.posit[cnt-1].lat() != lat[i] || this.posit[cnt-1].lng() != lng[i]) {
					this.posit[cnt++] = new google.maps.LatLng(lat[i], lng[i]);
				}
			}
		}

		this.path.setMap(null);
		this.start.setMap(null);
		this.end.setMap(null);
		
		this.path = new google.maps.Polyline({
			path: this.posit,
			strokeColor: "#FF0000",
			strokeOpacity: 0.4,
			strokeWeight: 5
		});

		this.start = new google.maps.Marker({
			position: this.posit[cnt-1],
			title:"Start"
		});

		this.end = new google.maps.Marker({
			position: this.posit[0],
			title:"End"
		});

		this.path.setMap(this.map);
		this.start.setMap(this.map);
		this.end.setMap(this.map);
		
		this.map.panTo(this.posit[0]);
	}
};
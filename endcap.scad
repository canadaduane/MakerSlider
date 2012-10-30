module makerslide(h=100) {
	linear_extrude(file="makerslide_extrusion_profile.dxf", layer="makerslide",height=h, center=true, convexity=10);
	}

plane = 0.001;

module tapercube(width=10, height=10, depth=10, taper=3.0) {
	hull() {
		translate([taper/2,taper/2,0])
			cube([width-taper, height-taper, plane]);
		translate([0,0,taper/2]) {
			translate([0,taper/2])
				cube([width, height-taper, plane]);
			translate([taper/2,0])
				cube([width-taper, height, plane]);
		}

		translate([taper/2,taper/2,depth-plane])
			cube([width-taper, height-taper, plane]);
		translate([0,0,depth-taper/2]) {
			translate([0,taper/2])
				cube([width, height-taper, plane]);
			translate([taper/2,0])
				cube([width-taper, height, plane]);
		}
	}
}

module cap() {
	wiggle = 0.5;
	wigglesq = sqrt(wiggle*wiggle*2);
	difference() {
		translate([-5, -25, 0])
			tapercube(30,50,5, 3);

		translate([0,wiggle]) makerslide(10);
		translate([wigglesq,wigglesq]) makerslide(10);
		translate([wiggle,0]) makerslide(10);
		translate([wigglesq,-wigglesq]) makerslide(10);
		translate([0,-wiggle]) makerslide(10);
		translate([-wigglesq,-wigglesq]) makerslide(10);
		translate([-wiggle,0]) makerslide(10);
		translate([-wigglesq,wigglesq]) makerslide(10);

		translate([10,0,0])
			cube([16,36,10], center=true);
	}
}

cap();
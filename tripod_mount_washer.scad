$fn=64;
fudge_r = 0.3;
long=100;

module mount_washer() {
	bolt_head_h = 5.4;
	spacer_h = 3.6;
	bolt_head_r = 6.25+fudge_r;

	mount_hole_r = 2.5+fudge_r;

	washer_outer_r = 38.1/2 + fudge_r;

	// distance of makerslide slot from center of makerslide (2 slots)
	slot_c = 10.0;

	difference() {
		cylinder(r=washer_outer_r, h=bolt_head_h+spacer_h);
		
		// translate([-long/2, bolt_head_r + 5, -long/2])
		// 	cube([long, long, long]);

		// translate([-long/2, -long - bolt_head_r - 5, -long/2])
		// 	cube([long, long, long]);
		
		// for 1/4"-20 bolt head
		rotate([0, 0, 30])
			cylinder(r=bolt_head_r, h=bolt_head_h, $fn=6);

		// for 5mm bolts that mount the washer + this plastic part to the makerslide
		for (x=[-1,1]) {
			translate([x*slot_c, 0, 0])
				cylinder(r=mount_hole_r, h=long);
		}
	}
}

rotate([0, 180, 0])
	mount_washer();
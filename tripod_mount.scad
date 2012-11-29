//base_neck_w = 35.5;
base_neck_w = 35.3;
base_neck_h = 6.0;
base_h = 2.0;
//base_w = 44.3;
base_w=44.1;
accepter_wall_w = 4.0;
accepter_floor_thickness = 5.0;
bolt_head_h = 3.0;
hole_r = 3.0;
washer_r = 4.8;

full_thickness = accepter_floor_thickness+base_h+base_neck_h;

module base_plate() {
	offset = base_neck_w-base_w;
	cube([base_w, base_w, base_h]);
	translate([0,0,base_h]) {
		hull() {
			cube([base_w, base_w, 0.001]);
			translate([-offset/2, -offset/2, base_neck_h])
				cube([base_neck_w, base_neck_w, 0.001]);
		}
	}
}

module block() {
	w = base_w+accepter_wall_w*2;

	translate([-accepter_wall_w, -accepter_wall_w, -accepter_floor_thickness])
		cube([w, w, accepter_floor_thickness+base_h+base_neck_h]);
}

module hextube(depth=10, height=4, base=6, mid=10) {
	hull() {
		translate([0, 0, -height/2])
			cube([base, depth, 0.001]);
		translate([-(mid-base)/2, 0, 0])
			cube([mid, depth, 0.001]);
		translate([0, 0, height/2])
			cube([base, depth, 0.001]);
	}
}

alu_w = 40.5;
slot_w = 5.8;
slot_c = 10.0;

module tripodmount() {
	translate([base_w/2, (base_w-base_neck_w)/2, base_h+base_neck_h]) {
		translate([-slot_c-slot_w/2, 0, 0]) {
			cube([slot_w, base_neck_w, 2]);
			translate([0, 0, 4])
				hextube(base_neck_w);
		}

		translate([slot_c-slot_w/2, 0, 0]) {
			cube([slot_w, base_neck_w, 2]);
			translate([0, 0, 4])
				hextube(base_neck_w);
		}
	}
	base_plate();
}

difference() {
	tripodmount();

	translate([base_w/2,base_w/2,0]) {
		rotate([0,0,30])
			translate([0,0,1])
				cylinder(r=7, h=full_thickness, $fn=6);
		cylinder(r=3.25, h=full_thickness, $fn=48);

		translate([0,15,0])
			cylinder(r=3, h=5, $fn=48);
	}
}
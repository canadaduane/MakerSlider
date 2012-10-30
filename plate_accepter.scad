base_neck_w = 35.5;
base_neck_h = 6.0;
base_h = 2.0;
base_w = 44.3;
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

module b2() {
translate([0,1.65,-0.01])
scale([0.9,0.93,0.728])
minkowski() {
	block();
	rotate([45,45,0])
		cube([3,3,3]);
}
}


module accepter() {
	difference() {
		b2(); // replace with 'block();' for square
		translate([0, -base_w/4, 0])
			base_plate();
		translate([0, +base_w/4, 0])
			base_plate();

		translate([base_w/2-base_neck_w/2-1, -base_w/2, base_neck_h/2])
			cube([base_neck_w+2, base_w*2, 5]);
		
		translate([base_w/2, base_w/2, -accepter_floor_thickness]) {
			translate([0,0,-0.5])
			cylinder(r=hole_r, h=full_thickness+2, $fn=32);
			translate([0, 0, accepter_floor_thickness-bolt_head_h])
				cylinder(r=washer_r, h=bolt_head_h+0.001, $fn=32);
		}
	}
}

//accepter();

module hextube(base=5, mid=7, height=5, depth=10) {
	hull() {
		translate([0, -height/2, 0])
			cube([base, depth, 0.001]);
		translate([0, 0, 0])
			cube([mid, depth, 0.001]);
		translate([0, height/2, 0])
			cube([base, depth, 0.001]);
	}
}

alu_w = 40.5;
slot_w = 5.8;
slot_c = 10.0;

module tripodmount() {
	translate([base_w/2, (base_w-base_neck_w)/2, base_h+base_neck_h]) {
		translate([-slot_c-slot_w/2, 0, 0])
			cube([slot_w, base_neck_w, 2]);

		translate([slot_c-slot_w/2, 0, 0])
			cube([slot_w, base_neck_w, 2]);
	}
	base_plate();
}

tripodmount();

x += hsp + force.x;
y += vsp + force.y;

if (grabbed) {
	x = target.x + offset * target.image_xscale;
	y = target.y;
}

apply_force();

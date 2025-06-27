
instructions = [];

hsp = 0;
vsp = 0;
force = vec2();

thrown = false;
grabbed = false;
offset = 10;

target = noone;

sprite = sObject_ExplosiveBarrel;

scaleDefault = 1;
scale = 1;
xscale = 1;
yscale = 1;

angle = 0;
color = c_white;

grab = function(t) {
	grabbed = true;
	target = t;
	
	scaleDefault = scale;
	scale *= 1.25;
	
	instructions_clear();
	instructions_add("F to drop", c_navy, c_white);
	instructions_add("MBL to throw", c_yellow, c_black);
}

drop = function() {
	grabbed = false;
	scale = scaleDefault;
	
	instructions_clear();
	instructions_add("F to grab", make_color_rgb(69, 231, 180), c_black);
}

instructions_add("F to grab", make_color_rgb(69, 231, 180), c_black);

depth = -y;

if (floor(fallingTime) <= 0) {
	vsp = 0;
	
	sprite_index = sCoin;
	
	image_xscale = sin((current_time + xscaleOffset) * 0.007) * 1;
	
	force = vec2();
} else {
	sprite_index = sCoinFlipping;
}

image_angle = sin(current_time * 0.001) * 3;


surface_set_target(SurfaceHandler.mainSurface);
draw_self();
surface_reset_target();

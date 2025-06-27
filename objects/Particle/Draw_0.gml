
depth = -999999;

if (sprite == -1) return;

if (getRandomSprite) {
	image_speed = 0;
	image_index = irandom(sprite_get_number(sprite));
	
	getRandomSprite = false;
}

image_alpha = alpha;

image_blend = color;

image_angle = angle + theta;

image_xscale = xscale * scale;
image_yscale = yscale * scale;

sprite_index = sprite;

surface_set_target(SurfaceHandler.particleSurface);
draw_self();
surface_reset_target();


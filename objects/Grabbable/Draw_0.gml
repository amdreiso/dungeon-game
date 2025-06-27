
if (sprite == -1) return;

depth = -y;
	
image_xscale = scale * xscale;
image_yscale = scale * yscale;

image_angle = angle;
image_blend = color;

sprite_index = sprite;

surface_set_target(SurfaceHandler.mainSurface);

draw_self();

surface_reset_target();

if (sprite == -1) return;

sprite_index = sprite;

image_alpha = alpha;
image_speed = spriteSpeed;
image_xscale = scale * xscale;
image_yscale = scale * yscale;
image_angle = angle;
image_blend = color;

if (spriteStopOnLastFrame) {
	on_last_frame(function(){
		spriteSpeed = 0;
	});
}

surface_set_target(SurfaceHandler.mainSurface);

draw_self();

surface_reset_target();


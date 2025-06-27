
scale += 0.0005;

if (dissipate) {
	alpha = lerp(alpha, 0, 0.01);
}

draw_clear_alpha(c_black, alpha / 10);

draw_sprite_ext(
	sSplashScreen, 0, display_get_gui_width() / 2, display_get_gui_height() / 2,
	scale, scale, 0, c_white, alpha
);

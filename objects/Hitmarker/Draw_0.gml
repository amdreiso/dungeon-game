
var s = scale;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed_color(x-s, y+s, str, xscale, yscale, 0, c_black, c_black, c_black, c_black, 1);
draw_text_transformed_color(x+s, y+s, str, xscale, yscale, 0, c_black, c_black, c_black, c_black, 1);
draw_text_transformed_color(x-s, y-s, str, xscale, yscale, 0, c_black, c_black, c_black, c_black, 1);
draw_text_transformed_color(x+s, y-s, str, xscale, yscale, 0, c_black, c_black, c_black, c_black, 1);
draw_text_transformed_color(x-s, y, str, xscale, yscale, 0, c_black, c_black, c_black, c_black, 1);
draw_text_transformed_color(x, y+s, str, xscale, yscale, 0, c_black, c_black, c_black, c_black, 1);
draw_text_transformed_color(x, y-s, str, xscale, yscale, 0, c_black, c_black, c_black, c_black, 1);
draw_text_transformed_color(x+s, y, str, xscale, yscale, 0, c_black, c_black, c_black, c_black, 1);
draw_text_transformed_color(x, y, str, xscale, yscale, 0, color, color, color, color, 1);

if (degrade) {
	var range = 0.009;
	xscale += random_range(-range, range);
	yscale += random_range(-range, range);
}


y -= 0.08;

function draw_label_width(x, y, str, width, maxWidth, scale, backgroundColor, textColor, alpha=1, center=true, offset=4, drawTextOnHalf=true){


if (width > 1) {

draw_rectangle_color(
	x + offset, 
	y + offset, 
	x + width + offset, 
	y + string_height(str) + offset, 
	c_black, c_black, c_black, c_black, false
);

draw_set_alpha(0.5);
draw_rectangle_color(
	x + offset, 
	y + offset, 
	x + width + offset, 
	y + string_height(str) + offset, 
	backgroundColor, backgroundColor, backgroundColor, backgroundColor, false
);
draw_set_alpha(1);

var halign = fa_left;
if (center) halign = fa_center;

draw_set_halign(halign);
draw_set_valign(fa_top);
		
draw_rectangle_color(
	x, y, x + width * scale, y + string_height(str) * scale, 
	backgroundColor, backgroundColor, backgroundColor, backgroundColor, false
);

}

if (width < maxWidth / 2 && drawTextOnHalf) return;

draw_text_transformed_color(
	x + (maxWidth / 2 * center), y, str, scale, scale, 0, 
	textColor, textColor, textColor, textColor, alpha
);


}
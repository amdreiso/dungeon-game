function draw_label_width(x, y, str, width, scale, backgroundColor, textColor, alpha=1, offset=4){

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
		
draw_set_halign(fa_left);
draw_set_valign(fa_top);
		
draw_rectangle_color(
	x, y, x + width, y + string_height(str), 
	backgroundColor, backgroundColor, backgroundColor, backgroundColor, false
);
draw_text_transformed_color(
	x, y, str, scale, scale, 0, 
	textColor, textColor, textColor, textColor, alpha
);


}
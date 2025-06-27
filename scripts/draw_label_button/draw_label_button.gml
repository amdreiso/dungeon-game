function draw_label_button(x, y, str, scale, backgroundColor, textColor, fn=function(){}, alpha=1, offset=4){
	
	draw_set_alpha(0.5);
	draw_rectangle_color(
		x + offset, 
		y + offset, 
		x + string_width(str) + offset, 
		y + string_height(str) + offset, 
		backgroundColor, backgroundColor, backgroundColor, backgroundColor, false
	);
	draw_set_alpha(1);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	draw_rectangle_color(
		x, y, x + string_width(str), y + string_height(str), 
		backgroundColor, backgroundColor, backgroundColor, backgroundColor, false
	);
	draw_text_transformed_color(
		x, y, str, scale, scale, 0, 
		textColor, textColor, textColor, textColor, alpha
	);
	
	var mx = window_mouse_get_x();
	var my = window_mouse_get_y();
	var hover = (mx > x && mx < x + string_width(str) && my > y && my < y + string_height(str));
	if (hover) fn();
	
}
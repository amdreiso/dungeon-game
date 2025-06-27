
var size = 100;
var changeColorOffset = 80;
var changeColorSpd = 0.004;
var changeColorAmp = 80;
var color = sin(current_time * changeColorSpd) * changeColorAmp;

c1 = make_color_hsv(color, 255, 255);
c2 = make_color_hsv(color+changeColorOffset, 255, 255);
c3 = make_color_hsv(color+changeColorOffset*2, 255, 255);
c4 = make_color_hsv(color+changeColorOffset*3, 255, 255);

draw_set_alpha(0.4);

for (var i = 0; i < size; i++) {
	var xSpd = 0.0001, xAmp = 100;
	var xx = sin(current_time * xSpd*5) * xAmp;
	var yy = cos(current_time * xSpd) * xAmp;
	var offset = 10;
		
	var color1 = c1;
	var color2 = c1;
		
	if (i > 0) {
		color1 = c4;
		color2 = c1;
	} else if (i > size/5) {
		color1 = c3;
		color2 = c1;
	} else if (i > size/3) {
		color1 = c3;
		color2 = c1;
	} else if (i > size/2) {
		color1 = c2;
		color2 = c4;
	}
	
	draw_line_color((menuWidth+i*offset)+xx/10, 0, (menuWidth+i*offset)+100, display_get_gui_height(), color1, color2);
	draw_line_color(menuWidth, (i*offset)+xx/2, display_get_gui_width(), (i*offset)*0.2*yy, color2, color1);
	
	
	draw_set_alpha(0.1);
	
	var xx1 = display_get_gui_width()/2;
	var xx2 = display_get_gui_width()/1.25;
	
	draw_line_color(xx1, 0, xx1+xx*100, 0+(i*offset)*yy, color2, color1);
	draw_line_color(xx1, 0, xx1-xx*100, (i*offset)*yy, color2, color1);
	
	draw_line_color(xx2, (i*offset)*yy, xx2+xx*100, HEIGHT, color2, color1);
	draw_line_color(xx2, (i*offset)*yy, xx2-xx*100, HEIGHT, color2, color1);
}

draw_set_alpha(1);


draw_rectangle_color(
	0, 0, menuWidth, HEIGHT,
	menuBackgroundColor, menuBackgroundColor, menuBackgroundColor, menuBackgroundColor,
	false
);


// Title
//draw_set_font(fnt_main3);

//if (titleYscale != 1) {
//	titleYscale = lerp(titleYscale, 1, 0.1);
//}







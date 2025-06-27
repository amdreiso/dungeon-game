function draw_devmenu(){

if (!DevMenu) return;

enum DEV_MENU_PAGE {
	Specs,
	Mod,
}

var ww = WIDTH/1.5;
var wh = HEIGHT/1.5;
var wc = c_black;
var wborder = Style.rainbow;

rect(WIDTH/2, HEIGHT/2, ww, wh, wc, false);
rect(WIDTH/2, HEIGHT/2, ww, wh, wborder, true);

var topleft = vec2((WIDTH/2)-ww/2, (HEIGHT/2)-wh/2);
var height = 32;

var Button = function(name, backgroundColor, textColor, fn=function(){}) {
	var b = {};
	b.name = name;
	b.backgroundColor = backgroundColor;
	b.textColor = textColor;
	b.fn = fn;
	return b;
}

draw_label(topleft.x, topleft.y, "dev menu", 1, wborder, c_black, 1);

var tabbuttons = [
	Button("specs", c_white, c_black, function(){
		window_set_cursor(cr_handpoint);
		
		if (mouse_check_button_pressed(mb_left)) {
			DevMenuPage = DEV_MENU_PAGE.Specs;
		}
	}),
	
	Button("player", c_white, c_black, function(){
		window_set_cursor(cr_handpoint);
		
		if (mouse_check_button_pressed(mb_left)) {
			DevMenuPage = DEV_MENU_PAGE.Mod;
		}
	}),
];


for (var i = 0; i < array_length(tabbuttons); i++) {
	var b = tabbuttons[i];
	var width = string_width(b.name);

	draw_label_button(topleft.x + i * width, topleft.y + height, b.name, 1, b.backgroundColor, b.textColor, b.fn);
}

var xx = topleft.x;
var yy = topleft.y + height * 2;

static fpsGraph = [];

switch (DevMenuPage) {
	case DEV_MENU_PAGE.Specs:
		// fps graph
		array_push(fpsGraph, fps);
		var fpslen = array_length(fpsGraph);
		
		for (var i=0; i<fpslen-1; i++) {
			var fpsBarWidth = 2;
			var x0 = xx + i * fpsBarWidth * 2;
			draw_rectangle_color(x0, yy, x0+fpsBarWidth, yy+(fpsGraph[i]), c_red, c_red, c_red, c_red, false);
		}
		
		if (fpslen > 100) {
			fpsGraph = [];
		}
		
		break;
		
	case DEV_MENU_PAGE.Mod:
		
		
		break;
}


}
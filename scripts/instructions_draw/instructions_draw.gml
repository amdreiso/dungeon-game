function instructions_draw() {
	for (var i = 0; i < array_length(instructions); i++) {
		var str = instructions[i].str;
		var bc = instructions[i].backgroundColor;
		var tc = instructions[i].textColor;
	
		var xx = WIDTH / 2;
		var yy = HEIGHT / 1.5;
	
		var height = 32;
		var scale = 1;
		var width = string_width(str) * scale;
	
		draw_label(
			xx - width / 2, 
			yy + i * (height),
			str, scale, bc, tc, 1, 4
		);
	}
}
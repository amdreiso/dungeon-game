

// keybinds
if (keyboard_check_pressed(vk_rcontrol)) {
	Console = not Console;
	keyboard_string = "";
}

if (keyboard_check(vk_f1)) {
	if (keyboard_check_pressed(ord("D"))) {
		DevMenu = not DevMenu;
	}
}


// sound
handleSound();


// style
if (rainbowIndexDirection == 0) {
	rainbowIndex += rainbowSpeed;
	
	if (round(rainbowIndex) >= 255) {
		rainbowIndexDirection = 1;
	}
} else if (rainbowIndexDirection == 1) {
	rainbowIndex -= rainbowSpeed;
	
	if (round(rainbowIndex) <= 0) {
		rainbowIndexDirection = 0;
	}
}

Style.rainbow = make_color_hsv(rainbowIndex, rainbowSaturation, rainbowValue);


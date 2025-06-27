
if (place_meeting(x, y, Player)) {
	if (keyboard_check_pressed(ord("F"))) {
		room_goto(rmDebug);
		Level.getRoomSize();
		Level.roomUpdate = true;
	}
}

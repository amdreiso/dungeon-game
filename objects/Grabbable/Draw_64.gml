
if (grabbed) {
	instructions_draw();
}

if (place_meeting(x, y, Player) && !grabbed) {
	instructions_draw();
}
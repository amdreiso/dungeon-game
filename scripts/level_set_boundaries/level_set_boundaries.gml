function level_set_boundaries(){
	x = clamp(x, (room_width / 2) - Level.width / 2, (room_width / 2) + Level.width / 2);
	y = clamp(y, (room_height / 2) - Level.height / 2, (room_height / 2) + Level.height / 2);
}
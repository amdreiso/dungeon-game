
busy = (room != rmDebug && room != rmInfinite);

if (busy) return;

layer_background_blend(layer_background_get_id("Background"), color_darkness(Style.rainbow, 220));
	
if (!instance_exists(Player)) {
	instance_create_depth(0, 0, depth, Player);
}

if (!isInfinite) {
	
	// LEVEL MODE
	
	if (roomUpdate) {
		array_delete(layout, 0, 1);
		player_set_position(room_width/2, room_height/2);
		roomUpdate = false;
	}
	
	if (instance_number(Enemy) == 0) {
		if (!instance_exists(Portal)) {
			var xx = room_width / 2;
			var yy = (room_height / 2) - height / 2;
			instance_create_depth(xx, yy + 20, depth, Portal);
		}
	}
	
} else {
	
	// INFINITE MODE
	
	if (roomUpdate) {
		setRoomSize(false, 2);
		
		player_set_position(room_width / 2, room_height / 2);
		roomUpdate = false;
	}
	
	infiniteMode();
	
}



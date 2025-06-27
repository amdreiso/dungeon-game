function player_set_position(x, y, cam=true) {
	if (!instance_exists(Player)) return;
	Player.x = x;
	Player.y = y;
	
	if (cam && instance_exists(Camera)) {
		Camera.x = x;
		Camera.y = y;
	}
}
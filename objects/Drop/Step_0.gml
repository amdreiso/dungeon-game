
take = DROP.get(dropID).fn;

if (place_meeting(x, y, Player)) {
	take();
	instance_destroy();
}

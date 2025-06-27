
hsp = 0;
vsp = 0;
force = vec2();

fallingTime = random_range(5, 20);

xscaleOffset = irandom(1000);

collected = false;
collect = function() {
	if (!collected) return;
	
	var pos = vec2(
		Player.x - Camera.size.width * Camera.zoom / 1.75,
		Player.y - Camera.size.height * Camera.zoom / 1.75
	);
	
	x = lerp(x, pos.x, 0.1);
	y = lerp(y, pos.y, 0.06);
	
	if (floor(x) == floor(pos.x)) {
		instance_destroy();
	}
}

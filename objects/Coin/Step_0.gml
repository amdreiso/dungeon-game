
force.x = lerp(force.x, 0, 0.1);
force.y = lerp(force.y, 0, 0.1);

x += (hsp + force.x) * GameSpeed;
y += (vsp + force.y) * GameSpeed;

if (floor(fallingTime) > 0) {
	fallingTime -= GameSpeed;
} else if (floor(fallingTime <= 0)) {
	collect();
}

vsp += 0.1;



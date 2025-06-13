
x += hsp;
y += vsp;

if (gravityApply) {
	vsp += gravityForce;
}

tick += GameSpeed;

if (tick >= destroyTime) {
	instance_destroy();
}

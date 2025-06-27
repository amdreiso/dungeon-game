
x += hsp;
y += vsp;

if (gravityApply) {
	vsp += gravityForce;
}

tick += GameSpeed;

if (tick >= destroyTime || alpha < 0.05) {
	instance_destroy();
}

if (fadeOut) {
	alpha = max(0, alpha - fadeOutSpeed * GameSpeed);
}

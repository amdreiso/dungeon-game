
if (instance_number(Particle) >= Settings.graphics.maxParticlesOnScreen) {
	instance_destroy();
}

hsp = 0;
vsp = 0;

gravityApply = false;
gravityForce = 0.1;

tick = 0;
destroyTime = 1000;

xscale = 1;
yscale = 1;
scale = 1;

image_angle = irandom(360);

sprite = -1;
getRandomSprite = false;




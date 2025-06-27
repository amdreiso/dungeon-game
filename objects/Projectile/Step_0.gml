
if (destroy || alpha < 0.05) instance_destroy();

speed = spd;

if (fadeOut) {
	alpha = max(0, alpha - fadeOutSpeed * GameSpeed);
}

damage = max(0, damage - damageLossOvertime);

effects_apply(self);

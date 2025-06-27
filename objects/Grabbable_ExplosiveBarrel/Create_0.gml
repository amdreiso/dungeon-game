
event_inherited();

sprite = sObject_ExplosiveBarrel;

range = 30;
damage = 175;

explode = function() {
	explosion_set(x, y, range, damage, 20);
	instance_destroy();
}

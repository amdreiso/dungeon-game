event_inherited();

damageLossOvertime = 0;

sprite = sProjectile_Scythe;
spd = 2.548;

spriteSpeed = 0;

destructible = true;
scale = random_range(1.00, 1.10);

tick = 0;
angle = 0;

xscale = 1;
if (mouse_x < Player.x) xscale = -1;

hp = 99999;
hit = function(){};

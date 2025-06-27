event_inherited();

damageLossOvertime = 0.008;

sprite = sProjectile_Flamethower;
spd = 1.66;

color = choose(c_red, c_yellow, c_orange);

spriteSpeed = 0;
image_index = irandom(sprite_get_number(sprite));

fadeOut = true;

destructible = false;
scale = random_range(0.50, 1.70);

angle = irandom(360);

xscale = choose(-1, 1);
yscale = choose(-1, 1);

fadeOutSpeed = 0.01;

hp = 99999;
hit = function(){};
effect_add(EFFECT_ID.Burn, 2 * 60);

event_inherited();

damageLossOvertime = 0.01;

sprite = sProjectile_Paintgun;
spd = 2.19;

color = choose(c_red, c_yellow, c_orange, c_aqua, c_fuchsia, c_lime);

spriteSpeed = 0;
image_index = irandom(sprite_get_number(sprite));

destructible = true;
scale = random_range(1.50, 1.80);

angle = irandom(360);

hp = 99999;
hit = function(){};

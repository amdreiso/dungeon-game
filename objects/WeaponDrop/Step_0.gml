
colliding = place_meeting(x, y, Player);

x += hsp + force.x;
y += vsp + force.y;
apply_force();

pickup();

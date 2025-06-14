function projectile_create(x, y, depth, sprite, spd = 1, knockback = 0, dir = point_direction(x, y, mouse_x, mouse_y)){
	var proj = instance_create_depth(x, y, depth, Projectile);
	proj.sprite = sprite;
	proj.direction = dir;
	proj.speed = spd;
	proj.knockback = knockback;
}
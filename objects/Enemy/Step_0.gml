
busy = (Paused);
sleep = max(0, sleep - GameSpeed);

depth = -y;
color = c_white;


if (instance_exists(Player)) target = Player;


// Movement
handleMovement();


// Health
handleHealth();

if (place_meeting(x, y, Projectile) && hitCooldown == 0) {
	var p = instance_nearest(x, y, Projectile);
	var damage = p.damage;
	
	if (!p.attacked) {
		hit(p.damage, Player, 0, p.stun);
		p.attacked = true;
		
		var dir = point_direction(x, y, Player.x, Player.y);
		
		force.x -= lengthdir_x(p.knockback, dir);
		force.y -= lengthdir_y(p.knockback, dir);
		
		effects_transfer(p);
		
		if (p.destructible && floor(p.gracePeriod) <= 0) {
			p.destroy = true;
		}
		
		Player.killCount ++;
	}
}


// Effects
effects_apply(self);

with (Enemy) {
  if (id != other.id) {
		var dist = point_distance(x, y, other.x, other.y);
    
		if (dist < 14) {
      var angle = point_direction(other.x, other.y, x, y);
			var pushValue = 0.25;
			
      force.x += lengthdir_x(pushValue, angle);
      force.y += lengthdir_y(pushValue, angle);
    }
  }
}

level_set_boundaries();



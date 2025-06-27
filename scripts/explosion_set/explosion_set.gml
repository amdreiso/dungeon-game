function explosion_set(x, y, range, damage, knockback = 10){
	// Create Explosion Particles
	repeat ( 30 ) {
		var pos = irandvec2(x, y, range);
		
		with (instance_create_depth(pos.x, pos.y, depth, Particle)) {
			gravityApply = false;
			destroyTime = random_range(120, 220) / 3;
			sprite = sParticle_Explosion;
			
			color = choose(c_dkgray, c_yellow, c_orange, c_red);
			getRandomSprite = true;
			
			hsp += random_range(-0.20, 0.20);
			vsp -= random_range(0.20, 0.80);
			
			fadeOut = true;
			fadeOutSpeed = 0.001;
			
			theta = random_range(-0.10, 0.10);
			
		}
	}
	
	// Set damage
	with (Enemy) {
		var dist = point_distance(self.x, self.y, x, y);
		var dir = point_direction(self.x, self.y, Player.x, Player.y);
		var damageFactor = 1;
		var r = range * 5;
		
		var knockbackRange = range * 2;
		
		if (dist <= r) {
			damageFactor = 1 - (dist / r);
			hit(round(damage * damageFactor), Player);
		}
		
		// Knockback
		if (dist <= knockbackRange) {
			var knockbackFactor = 1 - (dist / knockbackRange);
			
			force = vec2();
			
			force.x -= lengthdir_x(knockback * knockbackFactor, dir);
			force.y -= lengthdir_y(knockback * knockbackFactor, dir);
		}
	}
	
	camera_shake(20 - (point_distance(x, y, Player.x, Player.y) / 10));
	
	var snd = choose(snd_explosion1, snd_explosion1);
	sound3D(-1, x, y, snd, false, 1, [0.80, 1.00]);
}


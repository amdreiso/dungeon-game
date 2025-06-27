function particle_create_blood(minval, maxval){
	repeat (irandom_range(minval, maxval)) {
		with (instance_create_depth(x, y, depth, Particle)) {
			var big = random_range(1.00, 2.00);
			
			sprite = other.destroyParticles;
			
			getRandomSprite = true;
			color = choose(c_white, c_ltgray, c_gray);
			hsp = random_range(-1.00, 1.00) * big;
			vsp -= random(2.30) * big;
			destroyTime = irandom_range(10, 40);
			gravityApply = true;
			gravityForce = 0.05;
			
			xscale = choose(-1, 1) * big;
			yscale = choose(-1, 1) * big;
		}
	}
}
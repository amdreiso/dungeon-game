
sprite_index = sObject_Portal;
draw_self();

repeat (choose(0,0,0,0,1)) {
	var pos = irandvec2(x, y, sprite_get_width(sprite_index) / 2);
	with (instance_create_depth(pos.x, pos.y, depth, Particle)) {
		sprite = sParticle_Portal;
		getRandomSprite = true;
		
		hsp = sin(current_time * 0.001) * 0.1;
		vsp -= random_range(0.20, 0.60) * 2;
		
		scale = random_range(0.80, 1.20);
		
		color = choose(c_aqua, c_blue, c_navy);
		
		fadeOut = true;
		fadeOutSpeed = 0.001;
		destroyTime = irandom_range(2, 8) * 60;
	}
}

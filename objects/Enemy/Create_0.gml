

busy = false;
sleep = 0;

destroyParticles = sParticle_Blood;


// Movement
allowMovement = true;
defaultSpd = 0.65;
spd = defaultSpd;
hsp = 0;
vsp = 0;
force = vec2();
isMoving = false;

target = noone;
damage = 15;
knockback = 5;

effects = [];
effectColor = true;

handleMovement = function() {
	if (target == noone || busy) return;
	
	spd = defaultSpd;
	isMoving = (hsp != 0 || vsp != 0);
	
	var dir = point_direction(x, y, target.x, target.y);
	
	hsp = lengthdir_x(spd, dir);
	vsp = lengthdir_y(spd, dir);
	
	force.x = lerp(force.x, 0, 0.1);
	force.y = lerp(force.y, 0, 0.1);
	
	
	if (allowMovement) {
		x += hsp + force.x;
		y += vsp + force.y;
	}
	
	if (sleep > 0) {
		hsp = 0;
		vsp = 0;
	}
}

count = 0;

// Health
hpMax = 100;
hp = 100;
isHit = false;
hitCooldown = 0;
isDead = false;
showHitmarker = true;
killedByPlayer = false;

xp = 5;
xpHit = 0;

showHealthbar = 0;

checkDead = function() {
	if (hp <= 0) {
		isDead = true;
		killedByPlayer = true;
	}
}

handleHealth = function() {
	if (hitCooldown > 0) {
		hitCooldown -= GameSpeed;
	} else {
		hitCooldown = 0;
		isHit = false;
	}
	
	if (isDead) {
		instance_destroy();
	}
}

hit = function(damage, e, shake = 0.8, stun = 5) {
	if (isHit) return;
	
	hp -= damage;
	camera_shake(shake);
	
	hitCooldown = 20;
	isHit = true;
	sleep = stun;
	
	checkDead();
	
	particle_create_blood(1, 2);
	
	hitmarker_create(damage);
	sound3D(-1, x, y, snd_hit1, false, 0.20, random_range(1.00, 1.50), 0.1);
}


// Draw
angleTilt = 14;
color = c_white;

spriteState = {
	idle: sDefault,
	move: sDefault,
}

timeOffset = irandom(100) * 100;

draw = function(){
	depth = -y;
	
	var sprite = spriteState.idle;

	image_angle = 0;
	
	if (isMoving) {
		sprite = spriteState.move;
		var time = current_time + timeOffset;
		image_angle = sin(time * 0.02) * angleTilt;
	} else {
	}
	
	if (hsp != 0) {
		image_xscale = sign(hsp);
	}
	
	image_blend = color;
	
	sprite_index = sprite;
	
	gpu_set_fog((hitCooldown > 0), c_white, 0, 1);
	
	draw_self();
	
	gpu_set_fog(false, c_white, 0, 1);
}


projectileStats = {
	burn: {
		active: false,
		time: 180,
	},
	
	explosive: {
		active: false,
		damage: 0,
		range: 0,
	},
}

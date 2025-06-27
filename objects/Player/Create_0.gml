

// Player
busy = false;

killCount = 0;
effects = [];
effectColor = true;

reach = 10;
dropReach = 25;

coins = 1000;

//ini_open(SAVE_FILE);
//if (ini_key_exists("PlayerData", "Coins")) {
//  coins = ini_read_real("PlayerData", "Coins", 0);
//}
//ini_close();


// health
defaultHp = 100;
hp = defaultHp;
isHit = false;
hitCooldown = 0;
isDead = false;

handleHealth = function() {
	hp = round(clamp(hp, 0, defaultHp));
	
	hitCooldown = max(0, hitCooldown - GameSpeed);
	isHit = (hitCooldown > 0);
}

hit = function(damage, e, shake = 7.8) {
	if (isHit) return;
	
	hp -= damage;
	camera_shake(shake);
	
	hitCooldown = 2 * 60;
	isHit = true;
	
	checkDead();
	
	if (e != -1) effects_transfer(e);
	
	hitmarker_create(damage);
	
	audio_play_sound(snd_hit1, 0, false, 0.9, 0, random_range(0.80, 1.00));
}

checkDead = function(){
	isDead = (hp <= 0);
}


// movement
defaultSpd = 1.5;
spd = defaultSpd;
hsp = 0;
vsp = 0;
force = vec2();
dashSpd = 1.75;
isDashing = false;
isMoving = false;

movement = function() {
	if (busy) return;
	
	var up = keyboard_check(ord("W"));
	var left = keyboard_check(ord("A"));
	var down = keyboard_check(ord("S"));
	var right = keyboard_check(ord("D"));
	
	x += hsp + force.x;
	y += vsp + force.y;
	
	isMoving = (hsp != 0 || vsp != 0);
	
	apply_force();
	
	var dir = point_direction(0, 0, right-left, down-up);
	var len = (right-left != 0 || down-up != 0);
	
	hsp = lengthdir_x(spd * len, dir);
	vsp = lengthdir_y(spd * len, dir);
	
	// dash
	isDashing = max(0, isDashing - 0.01);
	
	if (keyboard_check_pressed(vk_space) && !isDashing) {
		isDashing = 1;
		dash();
	}
}

dash = function() {
	force.x += (hsp * dashSpd);
	force.y += (vsp * dashSpd);
	
	camera_shake(4);
	
	// dust
	repeat(10) {
		var pos = randvec2(x, y, 4);
		with (instance_create_depth(pos.x, pos.y, depth, Particle)) {
			var big = 0.1;
			
			sprite = sParticle_Dust;
			getRandomSprite = true;
			
			image_blend = choose(c_white, c_ltgray);
			
			hsp = random_range(-1.00, 1.00) * big;
			vsp -= random(0.70) * big;
			destroyTime = irandom_range(10, 30) * 3;
			gravityApply = false;
			
			scale = 10.00;
			image_angle += 0.05 * xscale;
			
			fadeOut = true;
			fadeOutSpeed = 0.01;
		
			xscale = choose(-1, 1) * big;
			yscale = choose(-1, 1) * big;
		}
	}
}


// collisions
collisions = function() {
	
	if (place_meeting(x + hsp + force.x, y, Collision)) {
		while (!place_meeting(x + sign(hsp + force.x), y, Collision)) {
			x = x + sign(hsp + force.x);
		}
		hsp = 0;
		force.x = 0;
	}
	
	if (place_meeting(x, y + vsp + force.y, Collision)) {
		while (!place_meeting(x, y + sign(vsp + force.y), Collision)) {
			y = y + sign(vsp + force.y);
		}
		vsp = 0;
		force.y = 0;
	}
	
	if (place_meeting(x, y, Enemy)) {
		var inst = instance_nearest(x, y, Enemy);
		hit(inst.damage, inst);
	}
	
	// coin
	if (distance_to_object(Coin) < dropReach) {
		var coin = instance_nearest(x, y, Coin);
	
		if (!coin.collected && instance_exists(Level)) {
			coin_add(1);
		
			audio_play_sound(snd_coin, 0, false, 0.8, 0.06, random_range(0.70, 0.90));
		}
	
		coin.collected = true;
	}
	
	
	// grabbable
	if (place_meeting(x, y, Grabbable)) {
		var inst = instance_nearest(x, y, Grabbable);
		
		if (keyboard_check_pressed(ord("F")) && !inst.grabbed && !holdingGrabbable) {
			inst.grab(self);
			
			holdingGrabbable = true;
			holdingGrabbableInstance = inst;
			holdingCooldown = 2;
		}
	}
}


// draw
angleTilt = 14;


// skin
skin = {};
setSkin = function(skinID) {
	var sprIdle, sprMove;
	
	var skinfetch = SKIN.getPlayer(skinID);
	if (!skinfetch) return;
	
	skin = skinfetch;
}

setSkin(SKIN_PLAYER_ID.Death);

angle = 0;

draw = function() {
	depth = -y;
	
	var sprite = skin.spriteState.idle;
	angle = 0;
	
	if (isMoving) {
		sprite = skin.spriteState.move;
		angle = sin(current_time * 0.02) * angleTilt;
	}
	
	if (hsp != 0) image_xscale = sign(hsp);
	
	sprite_index = sprite;
	
	surface_set_target(SurfaceHandler.mainSurface);
	//draw_self();
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, image_blend, image_alpha);
	surface_reset_target();
}


// inventory
var hand = function(itemID, ammo=0) {
	return {
		itemID: itemID,
		ammo: ammo,
	};
}

hands = [ hand(ITEM_ID.Pistol), hand(-1) ];
handIndex = 0;

setHand = function(handID, itemID) {
	hands[handID].itemID = itemID;
}

getHand = function() {
	return hands[handIndex];
}

handleInventory = function() {
	if (busy) return;
	
	handIndex -= (mouse_wheel_up() && handIndex > 0) ? 1 : 0;
	handIndex += (mouse_wheel_down() && handIndex < array_length(hands)-1) ? 1 : 0;
	
	if (keyboard_check_pressed(ord("1"))) handIndex = 0;
	if (keyboard_check_pressed(ord("2"))) handIndex = 1;
}



// grabbable
holdingGrabbable = false;
holdingGrabbableInstance = noone;
holdingCooldown = 0;

handleGrabbable = function() {
	if (!holdingGrabbable) return;
	
	holdingCooldown = max(0, holdingCooldown - GameSpeed);
	
	// drop
	if (keyboard_check_pressed(ord("F")) && holdingCooldown == 0) {
		holdingGrabbable = false;
		
		holdingGrabbableInstance.drop();
	}
	
	
	// throw
	if (mouse_check_button_released(mb_left)) {
		holdingGrabbable = false;
		
		holdingGrabbableInstance.drop();
		
		with (holdingGrabbableInstance) {
			grabbed = false;
			thrown = true;
			
			var angle = point_direction(x, y, mouse_x, mouse_y);
			var throwForce = 2.2;
			
			hsp = lengthdir_x(throwForce, angle);
			vsp = lengthdir_y(throwForce, angle);
		}
	}
}






////// LIMBO BELOW BE CAREFUL TRAVELING THERE ////////


// weapons
weaponRecoil = 0;
weaponRecoilRecoverSpeed = 0.75;
shootCooldown = 0;
weaponSound = -1;

attack = function() {
	if (busy) return;
	
	var item = getHand().itemID;
	if (item == -1) return;
	
	var type = ITEM.getType(item);
	var comps = ITEM.get(item).components;
	var angle = point_direction(x, y, mouse_x, mouse_y);
	
	switch (type) {
		case ITEM_TYPE.Weapon:
		
			shootCooldown = max(0, shootCooldown - GameSpeed);
			
			// shoot
			if (mouse_check_button(mb_left) && shootCooldown == 0 && !holdingGrabbable) {
				var xx = x + lengthdir_x(comps.projectileSpawnOffset, angle);
				var yy = y + lengthdir_y(comps.projectileSpawnOffset, angle);
				
				repeat (comps.projectileCount) {
					var proj = instance_create_depth(xx, yy, depth, comps.projectile);
					proj.direction = angle + random_range(-comps.precision, comps.precision);
					proj.damage = comps.damage;
					proj.knockback = comps.knockback;
				}
				
				shootCooldown = comps.shootCooldown;
				weaponRecoil = comps.recoil;
				
				// camera
				Camera.x += lengthdir_x(comps.cameraOffset, angle);
				Camera.y += lengthdir_y(comps.cameraOffset, angle);
				camera_shake(comps.cameraShake);
				
				// player
				force.x -= lengthdir_x(comps.playerRecoil, angle);
				force.y -= lengthdir_y(comps.playerRecoil, angle);
				
				// audio
				if (comps.audio.sound != -1) {
					if (!audio_is_playing(comps.audio.sound) || comps.audio.overlap) {
						weaponSound = audio_play_sound(comps.audio.sound, 0, false, 0, 0, random_array_argument(comps.audio.pitch));
					}
				
					audio_sound_gain(weaponSound, 0.8, comps.audio.fadeIn);
				}
			} else {
				if (audio_is_playing(weaponSound) && !comps.audio.overlap) {
					audio_stop_sound(weaponSound);
				}
			}
			break;
	}
}

drawWeapon = function() {
	var item = getHand();
	var type = ITEM.getType(item.itemID);
	
	if (type != ITEM_TYPE.Weapon) return;
	
	var weapon = ITEM.get(item.itemID);
	var name = weapon.name;
	var sprite = weapon.components.sprite;
	var scale = 1;
	var yscale = 1;
	var angle = 0;
	var recoil = weaponRecoil;
	
	weaponRecoil = max(0, weaponRecoil - GameSpeed * weaponRecoilRecoverSpeed);
	
	if (mouse_x < x) yscale = -1;
	
	angle = point_direction(x, y, mouse_x, mouse_y);
	
	var xx = x - lengthdir_x(recoil, angle);
	var yy = y - lengthdir_y(recoil, angle);
	
	surface_set_target(SurfaceHandler.mainSurface);
	draw_sprite_ext(sprite, 0, xx, yy, scale, scale * yscale, angle, c_white, 1);
	surface_reset_target();
}

drawWeaponGUI = function() {
	// item slots
	var str;
	var color;
	var text;
	var background;
	var cringenumberfuck = 0.0;
	var margin = 5;
	var height = 32;
	
	for (var i = 0; i < array_length(hands); i++) {
		var item = hands[i].itemID;
		if (item != -1) {
			str = ITEM.get(item).name;
			color = ITEM.getRarityColor(item);
			text = color.text;
			background = color.background;
		} else {
			str = "none";
			text = c_dkgray;
			background = c_white;
		}
		
		var alpha = 1;
		var scale = 1;
		
		if (i == handIndex) {
			alpha = 1;
			str = string_insert("[ ", str, 0);
			str = string_insert(str, " ]", 0);
			cringenumberfuck = 0.5;
		} else {
			cringenumberfuck = 0.0;
		}
		
		draw_label(margin, margin + i * height, str, scale, background, text, alpha);
	}
	
	// health
	var section2 = 3;
	var healthRed = make_color_rgb(220, 20, 20);
	var healthLabel = "HP";
	draw_label_width(margin, margin + section2 * height, healthLabel, defaultHp, defaultHp, 1, c_white, healthRed, 1);
	draw_label_width(margin, margin + section2 * height, healthLabel, hp, defaultHp, 1, healthRed, c_white, 1);
	
	// dash
	var staminaColor = make_color_rgb(220, 138, 50);
	var staminaLabel = "dash";
	var staminaStep = (isDashing / 1) * 100;
	draw_label_width(margin, margin + (4 * height), staminaLabel, 100, 100, 1, c_white, staminaColor, 1);
	draw_label_width(margin, margin + (4 * height), staminaLabel, isDashing * staminaStep, 100, 1, staminaColor, c_white, 1);
	
	
	draw_label(margin, margin + (5 * height), $"gold: {format_number(coins)}", 1, c_yellow, c_black, 1);
}

effectShowExclamation = true;

drawEffectGUI = function() {
	var len = array_length(effects);
	
	for (var i = 0; i < len; i++) {
		var effect = EFFECT.get(effects[i].effectID);
		
		var xx = 5;
		var yy = HEIGHT / 1.5;
		
		var width = 150;
		var step = (effects[i].time / effects[i].timeMax);
		
		var height = 32;
		var str = $"you are {effect.name}";
		
		var scale = 1;
		
		draw_label_width(
			xx, 
			yy + i * (height),
			str, (width * step), width, scale, c_red, c_white, 1, true, 4, false
		);
	}
}

drawGUI = function() {
	drawEffectGUI();
	drawWeaponGUI();
}


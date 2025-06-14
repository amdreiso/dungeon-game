
// Player
busy = false;

killCount = 0;
effects = [];


// health
defaultHp = 100;
hp = defaultHp;
isHit = false;
hitCooldown = 0;
isDead = false;

hit = function(damage, e, shake = 2.8) {
	if (isHit) return;
	
	hp -= damage;
	camera_shake(shake);
	
	hitCooldown = 0;
	//isHit = true;
	
	checkDead();
	
	hitmarker_create(damage);
}

checkDead = function(){}


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
}


// collisions
collisions = function() {
	
	if (place_meeting(x, y, Enemy)) {
		var inst = instance_nearest(x, y, Enemy);
		hit(inst.damage, inst);
	}
	
}


// camera
var cam = instance_create_depth(x, y, depth, Camera);
cam.target = self;


// draw
spriteState = {
	idle: sPlayerNOSKIN,
	move: sPlayerNOSKIN,
}

draw = function() {
	var sprite = spriteState.idle;
	
	if (isMoving) {
		sprite = spriteState.move;
	}
	
	sprite_index = sprite;
	draw_self();
}


// inventory
var hand = function(itemID, ammo=0) {
	return {
		itemID: itemID,
		ammo: ammo,
	};
}

hands = [hand(ITEM_ID.Pistol), hand(-1)];
handIndex = 0;

setHand = function(handID, itemID) {
	hands[handID] = itemID;
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


// weapons
weaponRecoil = 0;
weaponRecoilRecoverSpeed = 0.75;
shootCooldown = 0;

attack = function() {
	if (busy) return;
	
	var item = getHand().itemID;
	if (item == -1) return;
	
	var type = ITEM.getType(item);
	var comps = ITEM.get(item).components;
	
	switch (type) {
		case ITEM_TYPE.Weapon:
		
			shootCooldown = max(0, shootCooldown - GameSpeed);
			
			// shoot
			if (mouse_check_button(mb_left) && shootCooldown == 0) {
				projectile_create(
					x, y, depth, sProjectile_pixel, 4, comps.projectileKnockback
				);
				shootCooldown = 10;
				
				weaponRecoil = comps.recoil;
				
				camera_shake(comps.cameraShake);
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
		
		//draw_set_alpha(0.5);
		//var offset = 4 + random_range(-cringenumberfuck, cringenumberfuck);
		//draw_rectangle_color(
		//	margin + offset, 
		//	margin + i * height + offset, 
		//	margin + string_width(str) + offset, 
		//	margin + string_height(str) + i * height + offset, 
		//	background, background, background, background, false
		//);
		//draw_set_alpha(1);
		
		//draw_set_halign(fa_left);
		//draw_set_valign(fa_top);
		
		//draw_rectangle_color(margin, margin + i * height, margin + string_width(str), margin + string_height(str) + i * height, background, background, background, background, false);
		//draw_text_transformed_color(margin, margin + i * height, str, scale, scale, 0, text, text, text, text, alpha);
		draw_label(margin, margin + i * height, str, scale, background, text, alpha);
	}
	
	// health
	draw_label_width(margin, margin + 3 * height, "[ HP ]", defaultHp, 1, c_white, c_white, 1);
	draw_label_width(margin, margin + 3 * height, "[ HP ]", hp, 1, c_red, c_white, 1);
}


drawGUI = function() {
	drawWeaponGUI();
}




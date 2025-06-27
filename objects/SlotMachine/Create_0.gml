
image_speed = 0;

cooldown = 0;

colliding = false;
bought = false;

price = 100;

update = function() {
	colliding = (place_meeting(x, y, Player));
	if (!colliding) return;
	
	if (keyboard_check_pressed(ord("F")) && Player.coins >= price) {
		Player.coins -= price;
		bought = true;
		
		//with (Player) hitmarker_create(
		//	other.price, c_yellow, true, 1, 1, "- $"
		//);
	}
}

draw = function() {
	
	depth = -y;
	
	if (bought) {
		image_speed = 1;
		
		on_last_frame(function(){
			image_speed = 0;
			image_index = 0;
			bought = false;
			
			var itemID = ITEM.roll();
			var drop = instance_create_depth(x, y + 8, depth, WeaponDrop);
			drop.itemID = itemID;
			
			var hsp = 2, vsp = 5;
			
			drop.force = vec2(
				random_range(-hsp, hsp),
				random_range(vsp/2, vsp)
			);
		});
	}
	
	sprite_index = sObject_SlotMachine;
	
	surface_set_target(SurfaceHandler.mainSurface);
	draw_self();
	surface_reset_target();
	
}

instructions = [];
instructions_add("F to ", c_green, c_black);




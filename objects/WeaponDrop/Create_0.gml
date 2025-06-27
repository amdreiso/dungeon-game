
hsp = 0;
vsp = 0;
force = vec2();

itemID = ITEM_ID.Flamethrower;
colliding = false;

alarm[0] = 5 * 60;

pickup = function() {
	if (!colliding) return;
	
	if (keyboard_check_pressed(ord("F"))) {
		with (Player) {
			setHand(handIndex, other.itemID);
		}
		
		instance_destroy();
	}
}

xscale = 1;

draw = function() {
	var item = ITEM.get(itemID);
	if (!item) return;
	
	var spr = item.components.sprite;
	if (spr == -1) return;
	
	image_xscale = lerp(image_xscale, xscale, 0.1);
	
	sprite_index = spr;
	draw_self();
}

instructions = [];

instructions_add($"F to take weapon", make_color_rgb(210, 25, 50), c_black);

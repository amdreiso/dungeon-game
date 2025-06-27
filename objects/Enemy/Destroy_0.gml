
repeat (irandom_range(1, 3)) {
	coin_create(x, y);
}

camera_shake(1.5);

if (killedByPlayer) {
	particle_create_blood(30, 40);
	
	if (irandom(100) > 95) {
		var drop = instance_create_depth(x, y, depth, Drop);
		drop.dropID = irandom(ds_map_size(DropData) - 1);
	}
	
	Player.killCount ++;
}

//if (irandom(100) > 95) {
//	var index = irandom(ds_map_size(ConsumableData) - 1);
	
//	var drop = (instance_create_depth(x, y, depth, Drop));
//	drop.consumableID = index;
//}

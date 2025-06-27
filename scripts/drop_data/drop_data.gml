function drop_data(){
	globalvar DropData; DropData = ds_map_create();
	globalvar DROP; DROP = {};
}

function drop_init() {
	DROP = {
		register: function(dropID, name, sprite, fn=function(){}) {
			var drop = {};
			drop.name = name;
			drop.sprite = sprite;
			drop.fn = fn;
			DropData[? dropID] = drop;
		},
	
		get: function(dropID) {
			if (!ds_map_exists(DropData, dropID)) return;
			return DropData[? dropID];
		},
	}
	
	DROP.register(DROP_ID.SmallMedkit, "small medkit", sSmallMedkit, function(){
		if (!instance_exists(Player)) return;
		with (Player) {
			hp += 10;
			hitmarker_create("10", c_green, true, 1, 1, "+");
		}
	});
	
}

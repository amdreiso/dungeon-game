function skin_data() {
	globalvar SkinData; SkinData = {};
	globalvar SKIN;
	
	SkinData.player = ds_map_create();
	SkinData.item = ds_map_create();
}

function skin_init() {
	SKIN = {
		registerPlayer: function(skinID, name, idle, move, rarity=RARITY.Common) {
			var skin = {};
			skin.name = name;
			skin.spriteState = {
				idle: idle,
				move: move,
			}
			skin.rarity = rarity;
			SkinData.player[? skinID] = skin;
		},
		
		getPlayer: function(skinID) {
			if (!ds_map_exists(SkinData.player, skinID)) return false;
			return SkinData.player[? skinID];
		}
	}
	
	SKIN.registerPlayer(SKIN_PLAYER_ID.Riley, "riley", sPlayer_RileyIdle, sPlayer_RileyMove);
	SKIN.registerPlayer(SKIN_PLAYER_ID.Death, "death", sPlayer_DeathIdle, sPlayer_DeathMove);
	SKIN.registerPlayer(SKIN_PLAYER_ID.VGA, "vga", sPlayer_VgaIdle, sPlayer_VgaIdle);
}

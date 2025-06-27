
function item_data() {
	globalvar ItemData;
	globalvar ITEM;
	ItemData = ds_map_create();
}

function item_get_default_components(type) {
	var components = {
		onEquip: function(){},
		update: function(){},
		draw: function(){},
		drawGUI: function(){},
		
		rarity: RARITY.Common,
	};
	
	switch (type) {
		case ITEM_TYPE.Blank:
			struct_merge(components, {});
			break;
		
		case ITEM_TYPE.Armor:
			struct_merge(components, {
				applyArmor: function(){},
			});
			break;
		
		case ITEM_TYPE.Weapon:
			struct_merge(components, {
				recoil: 4,
				playerRecoil: 0,
				precision: 0,
				ammo: 0,
				magazine: 0,
				damage: 0,
				reloadTime: 0,
				shootCooldown: 20,
				
				knockback: 0,
				
				projectile: -1,
				projectileSpawnOffset: 0,
				projectileCount: 1,
				
				cameraShake: 0,
				cameraOffset: 0,
				
				sprite: -1,
				
				// sound
				audio: {
					sound: -1,
					pitch: 1.00,
					stopOnRelease: false,
					overlap: true,
					fadeOut: 0,
					fadeIn: 0,
				},
			});
			break;
	}
	
	return components;
}

function item_init() {
	ITEM = {
		register: function(itemID, type, name, icon, components = {}) {
			var item = {};
			
			item.name = name;
			item.type = type;
			item.icon = icon;
			item.components = item_get_default_components(type);
			
			struct_merge(item.components, components);
			
			ItemData[? itemID] = item;
			
			print($"Registered item: {item.name} at ID: {itemID}");
		},
		
		get: function(itemID) {
			if (!ds_map_exists(ItemData, itemID)) return;
			return ItemData[? itemID];
		},
		
		getType: function(itemID) {
			if (!ds_map_exists(ItemData, itemID)) return;
			return ItemData[? itemID].type;
		},
		
		getRarity: function(itemID) {
			if (!ds_map_exists(ItemData, itemID)) return;
			return ItemData[? itemID].rarity;
		},
		
		getRarityColor: function(itemID) {
			var color = {};
			
			switch(ItemData[? itemID].components.rarity) {
				case RARITY.Common:
					color.text = c_dkgray;
					color.background = c_white;
					break;
					
				case RARITY.Epic:
					color.text = c_aqua;
					color.background = c_dkgray;
					break;
					
				case RARITY.Exotic:
					color.text = c_lime;
					color.background = c_dkgray;
					break;
					
				case RARITY.LGBT:
					color.text = color_darkness(Style.rainbow, 200);
					color.background = Style.rainbow;
					break;
					
				case RARITY.Mythical:
					color.text = c_purple;
					color.background = c_ltgray;
					break;
					
				case RARITY.Rare:
					color.text = c_white;
					color.background = c_dkgray;
					break;
					
				case RARITY.Uncommon:
					color.text = c_gray;
					color.background = c_white;
					break;
					
				case RARITY.Trash:
					color.text = c_orange;
					color.background = c_maroon;
					break;
			}
			
			return color;
		},
		
		roll: function() {
			var items = ds_map_keys_to_array(ItemData);
	
			var weighted = [];

			for (var i = 0; i < array_length(items); i++) {
				var itemID = items[i];
				var item = ItemData[? itemID];
				if (!is_struct(item)) continue;

				var rarity = item.components.rarity;
				var weight = 0;

				switch (rarity) {
					case RARITY.Trash:    weight = 10; break;
					case RARITY.Common:   weight = 10; break;
					case RARITY.Uncommon: weight = 10; break;
					case RARITY.Rare:     weight = 10; break;
					case RARITY.Epic:     weight = 6;  break;
					case RARITY.Exotic:   weight = 3;  break;
					case RARITY.Mythical: weight = 1;  break;
					case RARITY.LGBT:     weight = 0.5; break;
				}

				for (var j = 0; j < weight; j++) {
					array_push(weighted, itemID);
				}
			}

			if (array_length(weighted) == 0) ITEM.roll();

			var rollvalue = weighted[irandom(array_length(weighted)-1)];
			return rollvalue;
		}

	}
	
	#region Weapons
	
	ITEM.register(ITEM_ID.Pistol, ITEM_TYPE.Weapon, "pistol", -1, {
		rarity: RARITY.Trash,
		
		// draw
		sprite: sWeapon_Pistol,
		
		// projectile
		damage: 8,
		projectile: Projectile_Pistol,
		
		cameraShake: 1.25,
		
		// sound
		audio: {
			sound: snd_pistol1,
			pitch: [0.80, 1.00],
			stopOnRelease: false,
			overlap: true,
			fadeOut: 0,
			fadeIn: 0,
		},
	});
	
	ITEM.register(ITEM_ID.Flamethrower, ITEM_TYPE.Weapon, "flamethrower", -1, {
		rarity: RARITY.LGBT,
		
		// draw
		sprite: sWeapon_Flamethrower,
		
		shootCooldown: 1,
		
		// projectile
		precision: 9,
		projectile: Projectile_Flamethrower,
		projectileSpawnOffset: 30,
		
		cameraOffset: 0.8,
		
		// sound
		audio: {
			sound: snd_flamethrower1,
			pitch: 0.80,
			overlap: false,
			stopOnRelease: true,
			fadeOut: 50,
			fadeIn: 50,
		},
	});
	
	ITEM.register(ITEM_ID.Paintgun, ITEM_TYPE.Weapon, "paintgun", -1, {
		rarity: RARITY.Mythical,
		
		// draw
		sprite: sWeapon_Paintgun,
		
		
		// projectile
		damage: 2,
		precision: 26,
		projectile: Projectile_Paintgun,
		projectileSpawnOffset: 10,
		projectileCount: 3,
		knockback: 0.2,
		shootCooldown: 4,
		
		// sound
		//audio: {
		//	sound: snd_flamethrower1,
		//	pitch: 0.80,
		//	overlap: false,
		//	stopOnRelease: true,
		//	fadeOut: 50,
		//	fadeIn: 50,
		//},
	});
	
	ITEM.register(ITEM_ID.Shotgun, ITEM_TYPE.Weapon, "shotgun", -1, {
		rarity: RARITY.Rare,
		
		// draw
		sprite: sWeapon_Shotgun,
		
		
		// projectile
		damage: 70,
		precision: 26,
		projectile: Projectile_Shotgun,
		projectileSpawnOffset: 10,
		projectileCount: 5,
		knockback: 0.5,
		shootCooldown: 80,
		playerRecoil: 2,
		
		cameraShake: 5,
		
		// sound
		audio: {
			sound: snd_shotgun1,
			pitch: [0.80, 1.00],
			overlap: true,
			stopOnRelease: false,
			fadeOut: 0,
			fadeIn: 0,
		},
	});
	
	ITEM.register(ITEM_ID.Cross, ITEM_TYPE.Weapon, "cross", -1, {
		rarity: RARITY.Mythical,
		
		// draw
		sprite: sWeapon_Cross,
		
		
		// projectile
		damage: 25,
		precision: 9,
		projectile: Projectile_Cross,
		projectileSpawnOffset: 10,
		projectileCount: 1,
		knockback: 0.5,
		shootCooldown: 20,
		recoil: 0,
		
		cameraShake: 0,
		
		// sound
		//audio: {
		//	sound: snd_flamethrower1,
		//	pitch: 0.80,
		//	overlap: false,
		//	stopOnRelease: true,
		//	fadeOut: 50,
		//	fadeIn: 50,
		//},
	});
	
	ITEM.register(ITEM_ID.Scythe, ITEM_TYPE.Weapon, "scythe", -1, {
		rarity: RARITY.Exotic,
		
		// draw
		sprite: sWeapon_Scythe,
		
		
		// projectile
		damage: 34,
		precision: 0,
		projectile: Projectile_Scythe,
		projectileSpawnOffset: 10,
		projectileCount: 1,
		knockback: 0.2,
		shootCooldown: 25,
		recoil: 10,
		playerRecoil: 1.5,
		
		cameraShake: 2,
		
		// sound
		audio: {
			sound: snd_scythe_throw,
			pitch: [0.80, 1.00],
			overlap: true,
			stopOnRelease: false,
			fadeOut: 0,
			fadeIn: 0,
		},
	});
	
	#endregion
	
}


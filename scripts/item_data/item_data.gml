
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
		
		rarity: ITEM_RARITY.Common,
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
				precision: 0,
				ammo: 0,
				magazine: 0,
				damage: 0,
				reloadTime: 0,
				
				projectileSpeed: 0,
				projectileSprite: -1,
				projectileKnockback: 0,
				
				cameraShake: 1,
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
				case ITEM_RARITY.Common:
					color.text = c_dkgray;
					color.background = c_white;
					break;
					
				case ITEM_RARITY.Epic:
					color.text = c_aqua;
					color.background = c_dkgray;
					break;
					
				case ITEM_RARITY.Exotic:
					color.text = c_lime;
					color.background = c_dkgray;
					break;
					
				case ITEM_RARITY.LGBT:
					color.text = c_purple;
					color.background = c_dkgray;
					break;
					
				case ITEM_RARITY.Mythical:
					color.text = c_purple;
					color.background = c_dkgray;
					break;
					
				case ITEM_RARITY.Rare:
					color.text = c_white;
					color.background = c_dkgray;
					break;
					
				case ITEM_RARITY.Uncommon:
					color.text = c_gray;
					color.background = c_white;
					break;
					
				case ITEM_RARITY.Trash:
					color.text = c_orange;
					color.background = c_maroon;
					break;
			}
			
			return color;
		}
	}
	
	ITEM.register(ITEM_ID.Pistol, ITEM_TYPE.Weapon, "pistol", -1, {
		rarity: ITEM_RARITY.Trash,
		
		// draw
		sprite: sWeapon_Pistol,
		
		projectileKnockback: 1,
	});
}



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
				recoil: 0,
				precision: 0,
				ammo: 0,
				magazine: 0,
				damage: 0,
				reloadTime: 0,
				
				projectileSpeed: 0,
				projectileSprite: -1,
			});
			break;
	}
	
	return components;
}

function item_init() {
	ITEM = {
		register: function(itemID, type, name, sprite, components = {}, rarity = ITEM_RARITY.Common) {
			var item = {};
			
			item.name = name;
			item.type = type;
			item.sprite = sprite;
			item.rarity = rarity;
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
	}
	
	ITEM.register(ITEM_ID.Pistol, ITEM_TYPE.Weapon, "pistol", -1, {});
}


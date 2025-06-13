
function effect_data(){
	globalvar EffectData; 
	globalvar EFFECT; 
	EffectData = ds_map_create();
}

EFFECT = {
	register: function(effectID, name, load = function(){}, update = function(){}, destroy = function(obj){}) {
		var effect = {};
	
		effect.name = name;
		effect.load = load;
		effect.update = update;
		effect.destroy = destroy;
	
		EffectData[? effectID] = effect;
	},
	
	get: function(effectID) {
		if (!ds_map_exists(EffectData, effectID)) return;
		return EffectData[? effectID];
	},
	
}

function effect_init() {
	
	EFFECT.register(
		EFFECT_ID.Burn,
		"Burn",
		function(obj) {
		},
		
		function(obj) {
			with (obj) {
				static tick = 0;
				tick += GameSpeed;
				
				var val = 222;
				color = c_red;
				
				if (floor(tick) % 60 == true) {
					var damage = 10;
					hit(damage, -1);
					if (obj == Player) camera_shake(5); // player hit
				}
				
				if (floor(tick) % 10 == true) {
					repeat ( irandom(2) ) {
						var range = sprite_get_width(sprite_index) / 4;
						var xx = x + random_range(-range, range);
						var yy = y + random_range(-range, range);
						
						with (instance_create_depth(xx, yy, depth, Particle)) {
							sprite = sParticle_Flames;
							image_speed = 0;
							image_index = irandom(sprite_get_number(sprite));
							destroyTime = irandom_range(60, 120);
							scale = random_range(0.70, 1.00) * 1.5;
							image_angle = 0;
							
							vsp = -random(0.20);
						}
					}
				}
			}
		},
		
		function(obj) {
		}
	);
	
}


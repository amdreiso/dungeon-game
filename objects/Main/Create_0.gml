
enums();
macros();

fovy();


// data
item_data();
item_init();

effect_data();
effect_init();


// globals
globalvar Game;
Game = {
	name: "",
	version: "0.0 indev",
	author: "amdreiSO",
	links: {
		discord: "",
		youtube: "https://www.youtube.com/channel/UCT-lQnbYpMKoVPWaQXB_DMw",
	}
};

globalvar GameSpeed; GameSpeed = 1;
globalvar Paused; Paused = false;
globalvar Debug; Debug = {
	debug: false,
	tools: false,
	console: false,
};

globalvar Settings; Settings = {
	graphics: {
		maxParticlesOnScreen: 200,
		cameraShakeIntensity: 1.0,
		guiScale: 2.0,
		raycastCount: 500,
		showKey: true,
	},
	
	audio: {
	},
};

globalvar Debug; Debug = true;

instance_create_depth(x, y, depth, SurfaceHandler);
instance_create_depth(200, 200, depth, Player);


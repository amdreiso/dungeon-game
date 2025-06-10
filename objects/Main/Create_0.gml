
fovy();

globalvar Game;
Game = {
	name: "",
	version: "0.0 indev",
	author: "amdrei",
};

globalvar GameSpeed; GameSpeed = 1;
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


// data
item_data();


instance_create_depth(200, 200, depth, Player);


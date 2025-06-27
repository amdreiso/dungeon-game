
busy = (
	DevMenu ||
	Console ||
	Paused
);

movement();
attack();
collisions();

handleInventory();
handleHealth();
handleGrabbable();

// camera
if (!instance_exists(Camera)) {
	var cam = instance_create_depth(x, y, depth, Camera);
	cam.target = self;
}

effects_apply(self);

level_set_boundaries();


// 3D sound
audio_listener_position(x, y, 0);



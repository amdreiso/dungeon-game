
busy = false;

// movement
defaultSpd = 1.5;
spd = defaultSpd;
hsp = 0;
vsp = 0;
force = vec2();

movement = function() {
	if (busy) return;
	
	var up = keyboard_check(ord("W"));
	var left = keyboard_check(ord("A"));
	var down = keyboard_check(ord("S"));
	var right = keyboard_check(ord("D"));
	
	x += hsp;
	y += vsp;
	hsp += force.x;
	vsp += force.y;
	
	var dir = point_direction(0, 0, right-left, down-up);
	var len = (right-left != 0 || down-up != 0);
	
	hsp = lengthdir_x(spd * len, dir);
	vsp = lengthdir_y(spd * len, dir);
}


// camera
var cam = instance_create_depth(x, y, depth, Camera);
cam.target = self;


// draw
draw = function() {
	rect(x, y, 16, 16);
}


// inventory
hands = [-1, -1];

setHand = function(handID, itemID) {
	hands[handID] = itemID;
}

getHand = function(handID) {
	return hands[handID];
}







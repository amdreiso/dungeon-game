
enums();
macros();

fovy();

// data
item_data();
item_init();

effect_data();
effect_init();

drop_data();
drop_init();

skin_data();
skin_init();

command_data();


// globals
globalvar Game;
Game = {
	name: "dungeon-game",
	version: "0.0 indev",
	author: "amdreiSO",
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
		volume: 1.00,
		music: 1.00,
		sfx: 1.00,
	},
};

load_settings();

globalvar Debug; Debug = true;
globalvar DevMenu; DevMenu = false;
globalvar DevMenuPage; DevMenuPage = 0;


// sound
globalvar Sound; Sound = {};
Sound.distance = 20;
Sound.dropoff	= 5;
Sound.multiplier = 1;

audio_falloff_set_model(audio_falloff_inverse_distance);
audio_listener_orientation(0, 1, 0, 0, 0, 1);


// draw
globalvar Style; Style = {
	rainbow: c_white,
};

rainbowSpeed = 0.5;
rainbowIndex = 0;
rainbowIndexDirection = 0;
rainbowSaturation = 255;
rainbowValue = 255;

// sound
audio_group_load(audiogroup_music);
audio_group_load(audiogroup_sfx);

handleSound = function() {
	audio_group_set_gain(audiogroup_sfx, Settings.audio.sfx, 0);
	audio_group_set_gain(audiogroup_music, Settings.audio.music, 0);
	
	audio_master_gain(Settings.audio.volume);
}



// level
instance_create_depth(0, 0, depth, Level);



// console
globalvar Console; Console = false;

logs = [];
commands = [];
logRewind = -1;

runCommand = function(input, showHistory = false) {
	if (input == "") return;
	
	var args = string_split(input, " ", true);
	array_delete(args, 0, 1);
	
	var found = false;
	
	if (showHistory)
		log("- "+input);
	
	// Run Actual Command
	for (var i = 0; i < array_length(CommandData); i++) {
		if (string_starts_with(string_lower(input), CommandData[i].name)) {
			var argc = CommandData[i].argc;
			var argl = array_length(args);
			
			if (argc != argl) {
				err($"Missing {argc} arguments.");
				return;
			}
			
			CommandData[i].fn(args);
			found = true;
		}
	}
	
	if (!found) {
		err("Invalid command!");
	}
}

consoleScroll = 0;

clearConsole = function() {
	consoleScroll = 0;
	commands = [];
	logs = []
}

drawConsole = function() {
	if (!Console) return;
	
	var input = keyboard_string;
	static pastCommand = 0;
	
	if (keyboard_check_pressed(vk_enter)) {
		runCommand(input, true);
		array_push(commands, input);
		keyboard_string = "";
		pastCommand = 0;
	}
	
	var len = array_length(commands);
	
	if (keyboard_check_pressed(vk_up) && pastCommand < len) {
		pastCommand += 1;
		keyboard_string = commands[len - pastCommand];
	}
	
	if (keyboard_check_pressed(vk_down) && pastCommand > 1) {
		pastCommand -= 1;
		keyboard_string = commands[len - pastCommand];
	}
	
	// Draw the actual console
	var width = 700;
	var height = 400;
	var c0 = $080808;
	var c1 = Style.rainbow;
	
	draw_set_alpha(0.95);
	
	draw_rectangle_color(
		window_get_width() - width, 200, window_get_width(), 200 + height, 
		c0, c0, c0, c0, false
	);
	
	draw_set_alpha(1);
	
	draw_rectangle_color(
		window_get_width() - width, 200, window_get_width(), 200 + height, 
		c1, c1, c1, c1, true
	);
	
	draw_set_halign(fa_left);
	
	// Draw logs
	var count = array_length(logs);
	var maxcount = 26;
	if (array_length(logs) > maxcount) {
		count = maxcount;
	}
	
	consoleScroll += (mouse_wheel_up() && consoleScroll < array_length(logs) - maxcount) ? 1 : 0;
	consoleScroll -= (mouse_wheel_down() && consoleScroll > 0) ? 1 : 0;
	
	for (var i = consoleScroll; i < count + consoleScroll; i++) {
		var sep = 14;
	
		draw_set_font(logs[i].font);
		
		draw_text_color(
			window_get_width() - width + 5, 
			(150 + height) - (i - consoleScroll) * sep, 
			
			logs[i].str, 
			logs[i].color, logs[i].color, logs[i].color, logs[i].color, 1
		);
	}
	
	draw_set_font(fnt_console);
		
	var bar = "█";
	draw_text(window_get_width() - width + 5, 180 + height, "> " + input + bar);
	
	draw_set_font(fnt_main);
	draw_set_halign(fa_center);
	
	var scale = 0.10;
	var yy = 201;
	
	// KITTIESSSS
	draw_sprite_ext(sKitty, 0, window_get_width(), yy + height, scale, scale, 0, c_white, 1);
	draw_sprite_ext(sKitty3, 0, window_get_width() - (sprite_get_width(sKitty) * scale), yy + height, scale, scale, 0, c_white, 1);
	draw_sprite_ext(sKitty2, 0, window_get_width() - (sprite_get_width(sKitty3) * scale), yy + height, scale, scale, 0, c_white, 1);
}

runCommand("start");







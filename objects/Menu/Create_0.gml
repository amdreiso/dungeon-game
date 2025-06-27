
backgroundSong = audio_play_sound(snd_menu, 0, true, 1, 0, random_range(0.90, 1.00));

enum MENU_PAGE {
	Home,
	Level,
	Infinite,
	Dev,
	Options,
	OptionsAudio,
	OptionsGraphics,
}

gameName = Game.name;
page = 0;
menuWidth = WIDTH / 3;
menuBackgroundColor = c_black;

c1 = c_black;
c2 = c_black;
c3 = c_black;
c4 = c_black;
margin = 5;

test = 0;

enum MENU_BUTTON_TYPE {
	Method,
	Slider,
}

var Button = function(name, backgroundColor, textColor, fn, goback = true) {
	return {
		type: MENU_BUTTON_TYPE.Method,
		name: name,
		fn: fn,
		backgroundColor: backgroundColor,
		textColor: textColor,
		goback: goback,
	}
}

var ButtonSlider = function(name, backgroundColor, textColor, get, set, variabledefault, slope=0.1) {
	return {
		type: MENU_BUTTON_TYPE.Slider,
		name: name,
		backgroundColor: backgroundColor,
		textColor: textColor,
		get: get,
		set: set,
		variabledefault: variabledefault,
		slope: slope,
	}
}

homeButtons = [
	Button("   levels   ", c_white, c_black, function(){
		Menu.page = MENU_PAGE.Level;
		audio_stop_all();
		room_goto(rmDebug);
	}),
	
	Button("   infinite   ", c_orange, c_black, function(){
		Menu.page = MENU_PAGE.Infinite;
	}),
	
	Button("options", c_green, c_black, function(){
		Menu.page = MENU_PAGE.Options;
	}),
	
	Button("feed the dev xD", c_red, c_black, function(){
		Menu.page = MENU_PAGE.Dev;
	}),
	
	Button("quit", c_orange, c_blue, function(){
		game_end();
	}),
];

optionButtons = [
	Button("return", c_blue, c_white, function(){
		Menu.page = MENU_PAGE.Home;
	}),
	
	Button("graphics", c_fuchsia, c_black, function(){
		Menu.page = MENU_PAGE.OptionsGraphics;
	}),	
	
	Button("audio", c_aqua, c_black, function(){
		Menu.page = MENU_PAGE.OptionsAudio;
	}),	
];

optionGraphicButtons = [
	Button("return", c_blue, c_white, function(){
		Menu.page = MENU_PAGE.Options;
	}),
	
	Button("toggle fullscreen", make_color_rgb(35, 35, 35), c_white, function(){
		window_set_fullscreen(!window_get_fullscreen());
	}),
];

optionAudioButtons = [
	Button("return", c_blue, c_white, function(){
		Menu.page = MENU_PAGE.Options;
	}),
	
	ButtonSlider("volume", $FFCBA646, c_black, 
							function(){ return Settings.audio.volume; },
							function(v){ Settings.audio.volume = clamp(v, 0, 1); save_settings(); },
							1.00, 0.005),
	
	ButtonSlider("music", make_color_rgb(200, 200, 80), c_black, 
							function(){ return Settings.audio.music; },
							function(v){ Settings.audio.music = clamp(v, 0, 1); save_settings(); },
							1.00, 0.005),
	
	ButtonSlider("sfx", make_color_rgb(170, 130, 220), c_black, 
							function(){ return Settings.audio.sfx; },
							function(v){ Settings.audio.sfx = clamp(v, 0, 1); save_settings(); },
							1.00, 0.005),
];

devButtons = [
	Button("return", c_blue, c_white, function(){
		Menu.page = MENU_PAGE.Home;
	}),
	
	Button("discord", make_color_rgb(100, 100, 255), c_white, function(){
		url_open("https://discord.gg/hkfcYf8pDS");
	}),
	
	Button("youtube", make_color_rgb(255, 55, 205), c_black, function(){
	}),
	
	Button("ko-fi", make_color_rgb(100, 10, 155), c_white, function(){
	}),
	
	Button("instagram", make_color_rgb(84, 200, 55), c_black, function(){
	}),
	
	Button("patreon", make_color_rgb(100, 80, 05), c_white, function(){
	}),
];

infiniteDifficulty = ["EASY", "NORMAL", "HARDCORE"];
infiniteDifficultyIndex = 1;

infiniteButtons = [
	Button("return", c_blue, c_white, function(){
		Menu.page = MENU_PAGE.Home;
	}),
	
	Button($"change difficulty", c_blue, c_white, function(){
		with (Menu) {
			if (infiniteDifficultyIndex >= array_length(infiniteDifficulty)-1) {
				infiniteDifficultyIndex = 0;
			} else {
				infiniteDifficultyIndex ++;
			}
			
		}
	}, false),
	
	Button("play", c_aqua, c_black, function(){
		audio_stop_all();
		Level.isInfinite = true;
		Level.infiniteDifficulty = infiniteDifficulty[infiniteDifficultyIndex];
		room_goto(rmInfinite);
	}),
];

buttonIndex = 0;

drawButtons = function(arr) {
	var click = (keyboard_check_pressed(vk_space));
	var up = (mouse_wheel_up() || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up));
	var down = (mouse_wheel_down() || keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down));
	var left = (keyboard_check(ord("A")));
	var right = (keyboard_check(ord("D")));
	
	for (var i = 0; i < array_length(arr); i++) {
		var b = arr[i];
		var str = b.name;
		var height = 32;
				
		if (buttonIndex == i) {
			str = string_insert("[ ", str, 0);
			str = string_insert(str, " ]", 0);
		}
		
		var heightOffset = 2;
		
		switch (b.type) {
			case MENU_BUTTON_TYPE.Method:
			
				draw_label(
					margin, (margin) + (i + heightOffset) * height, str, 1, 
					b.backgroundColor, b.textColor, 1
				);
				
				break;
				
			case MENU_BUTTON_TYPE.Slider:
				
				var maxwidth									= 100;
				var current										= b.get();
				var step											= (current / b.variabledefault);
				var width											= maxwidth * step;
				var arrowButtonWidth					= 20;
				
				var leftArrowBackgroundColor	= b.backgroundColor;
				var leftArrowTextColor				= b.textColor;
				
				var rightArrowBackgroundColor = b.backgroundColor;
				var rightArrowTextColor				= b.textColor;
				
				if (buttonIndex == i) {
					if (left && current > 0) { 
						leftArrowBackgroundColor = b.textColor;
						leftArrowTextColor = b.backgroundColor;
						
						b.set(current - b.slope); 
					}
					
					if (right && current < b.variabledefault) { 
						rightArrowBackgroundColor = b.textColor;
						rightArrowTextColor = b.backgroundColor;
						
						b.set(current + b.slope); 
					}
				}
				
				draw_label_width(
					margin, margin + (i + heightOffset) * height,
					"<", arrowButtonWidth, arrowButtonWidth, 1, leftArrowBackgroundColor, leftArrowTextColor, 1
				);
				
				draw_label_width(
					margin + arrowButtonWidth, margin + (i + heightOffset) * height, str, width, maxwidth, 1, 
					b.textColor, b.backgroundColor, 1, true, 4, false
				);
				
				draw_label_width(
					margin + arrowButtonWidth, margin + (i + heightOffset) * height, str, width, maxwidth, 1, 
					b.backgroundColor, b.textColor, 1, true
				);
				
				draw_label_width(
					(margin + arrowButtonWidth) + maxwidth, margin + (i + heightOffset) * height,
					">", arrowButtonWidth, arrowButtonWidth, 1, rightArrowBackgroundColor, rightArrowTextColor, 1
				);
				
				break;
		}
	}
	
	if (Console) return;
	
	if (click && arr[buttonIndex].type == MENU_BUTTON_TYPE.Method) {
		arr[buttonIndex].fn();
		if (arr[buttonIndex].goback) buttonIndex = 0;
	}
			
	if (up && buttonIndex > 0) {
		buttonIndex --;
		audio_stop_sound(snd_select_menu);
		audio_play_sound(snd_select_menu, 0, false, 1, 0, random_range(0.87, 1.00));
	};
	
	if (down && buttonIndex < array_length(arr) - 1) {
		buttonIndex ++;
		audio_stop_sound(snd_select_menu);
		audio_play_sound(snd_select_menu, 0, false, 1, 0, random_range(0.87, 1.00));
	};
}

drawTitle = function() {
	draw_set_halign(fa_center);
			
	var titleX = menuWidth / 2;
	var titleScale = 3;
			
	var tTail = 6;
			
	for (var t = tTail; t > 1; t--) {
		var dis = 0;
		var disCalc = 0;
		var amp = 2;
		var vel = 0.002;
		var time = (current_time + t * 500);
		var sinX = sin(time * vel) * amp;
		var sinY = (sin(time * vel/1.5) * amp);
		var c = c_black;
		var d = 7;
				
		disCalc = (t * dis);
		
		draw_text_transformed_color(
			titleX + sinX * t, margin + sinY + disCalc, Game.name, titleScale, titleScale, 0, c, c, c, c, 1-t/d
		);
		
		draw_text_transformed_color(
			titleX + sinX * t, margin + sinY + disCalc, Game.name, titleScale, titleScale, 0, c3, c4, c1, c2, 1-t/d
		);
	}
	
	draw_text_transformed_color(
		titleX, margin, Game.name, titleScale, titleScale, 0, c1, c2, c3, c4, 1
	);
	
	draw_set_halign(fa_left);
}

drawMenu = function() {
	drawTitle();
	
	switch(page) {
		case MENU_PAGE.Home:
			drawButtons(homeButtons);
			break;
		
		case MENU_PAGE.Options:
			drawButtons(optionButtons);
			break;
		
		case MENU_PAGE.OptionsAudio:
			drawButtons(optionAudioButtons);
			break;
		
		case MENU_PAGE.OptionsGraphics:
			drawButtons(optionGraphicButtons);
			break;
		
		case MENU_PAGE.Dev:
			drawButtons(devButtons);
			break;
		
		case MENU_PAGE.Infinite:
			draw_set_halign(fa_right);
			draw_text(menuWidth - margin, margin + 3 * 32, infiniteDifficulty[infiniteDifficultyIndex]);
			draw_set_halign(fa_left);
			
			drawButtons(infiniteButtons);
			break;
	}
}





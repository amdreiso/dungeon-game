
if (!audio_is_playing(snd_splashscreen) || keyboard_check_pressed(vk_anykey)) {
	room_goto(rmMenu);
	audio_stop_sound(snd_splashscreen);
}


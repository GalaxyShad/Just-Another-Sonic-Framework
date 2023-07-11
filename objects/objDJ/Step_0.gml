
if ((!audio_sound_get_loop(current)) && (!audio_is_playing(current))) {
	if (current != MUSIC_MAP[$ "drowning"])
		__resume_main_music();
}
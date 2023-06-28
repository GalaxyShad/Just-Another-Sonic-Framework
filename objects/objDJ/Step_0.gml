
if ((!audio_sound_get_loop(current_music)) && (!audio_is_playing(current_music))) {
	on_end(current_music);
	__play_default();
}
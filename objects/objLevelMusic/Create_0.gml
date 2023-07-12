
if (id != instance_find(objLevelMusic, 0)) {
	instance_destroy();
	exit;
}

audio_stop_all();

audio_play_sound(Music, 0, true);

offset = 0;

pause = function() {
	audio_pause_sound(Music);
};

resume = function() {
	audio_resume_sound(Music);	
};











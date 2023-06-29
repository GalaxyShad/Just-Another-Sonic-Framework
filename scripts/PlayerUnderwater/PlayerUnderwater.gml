
function player_underwater_regain_air() {
	// Dirty crutch
	audio_stop_sound(musDrowning);
	
	remaining_air = 30;
	timer_underwater.reset();
};


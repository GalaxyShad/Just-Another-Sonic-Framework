
function player_underwater_regain_air() {
	// Dirty crutch
	audio_stop_sound(musDrowning);
	
	remaining_air = 30;
	timer_underwater.reset();
};


function player_underwater_event() {
	if (array_contains([25, 20, 15], remaining_air)) {
		// warning chime	
		audio_play_sound(sndUnderwaterWarningChime, 0, 0);
	} 
	
	if (remaining_air == 12) {
		// drowning music	
		show_debug_message("drowning music");
		o_dj.set_music("drowning");
	} 
	
	if (array_contains([12, 10, 8, 6, 4, 2], remaining_air)) {
		// warning number bubble
		var _number = (remaining_air / 2) - 1;
		instance_create_depth(
			x + 6 * image_xscale, y, -1000, objBubbleCountdown, { number: _number });
	} 
	
	if (remaining_air == 0) {
		// player drown	
		audio_play_sound(sndPlrDrown, 0, 0);
		state.change_to("die");
	}
	
	instance_create_depth(x + 6 * image_xscale, y, -1000, objBreathingBubble);
	
	remaining_air--;
};


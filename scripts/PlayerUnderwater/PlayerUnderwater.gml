
/// @param {Struct.Player} plr
function player_underwater_regain_air(plr) {
	// Dirty crutch
	audio_stop_sound(musDrowning);
	
	plr.remaining_air = 30;
	plr.timer_underwater = plr.delay_underwater_event;
};

/// @param {Struct.Player} plr
function player_underwater_event(plr) {
	if (array_contains([25, 20, 15], plr.remaining_air)) {
		// warning chime	
		audio_play_sound(sndUnderwaterWarningChime, 0, 0);
	} 
	
	if (plr.remaining_air == 12) {
		// drowning music	
		show_debug_message("drowning music");
		plr.o_dj.play_drowning();
	} 
	
	if (array_contains([12, 10, 8, 6, 4, 2], plr.remaining_air)) {
		// warning number bubble
		var _number = (plr.remaining_air / 2) - 1;
		instance_create_depth(
			plr.inst.x + 6 * plr.inst.image_xscale, plr.inst.y, -1000, objBubbleCountdown, { number: _number });
	} 
	
	if (plr.remaining_air == 0) {
		// player drown	
		audio_play_sound(sndPlrDrown, 0, 0);
		plr.state_machine.change_to("die");
	}
	
	instance_create_depth(plr.inst.x + 6 * plr.inst.image_xscale, plr.inst.y, -1000, objBreathingBubble);
	
	plr.remaining_air--;
};


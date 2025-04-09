

function PlayerStateSpindash() : BaseState() constructor {
	__spinrev = 0;
	
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		audio_sound_pitch(sndPlrSpindashCharge, 1);
		audio_play_sound(sndPlrSpindashCharge, 0, false);
		
		__spinrev = 0;
		
		plr.inst.behavior_loop.disable(player_behavior_jump);
		plr.inst.behavior_loop.disable(player_behavior_ground_movement);
		plr.animator.set("spindash");	
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) { 
		plr.inst.behavior_loop.enable(player_behavior_jump);
		plr.inst.behavior_loop.enable(player_behavior_ground_movement);
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {

		if (!(plr.input_y() > 0)) {
			plr.gsp = (8 + (floor(__spinrev) / 2)) * sign(plr.inst.image_xscale);
	
			audio_stop_sound(sndPlrSpindashCharge);
			audio_play_sound(sndPlrSpindashRelease, 0, false);
		
			plr.state_machine.change_to("roll");
	
			plr.inst.camera.set_lag_timer(15);
		}

	
		if (plr.is_input_jump_pressed()) {
			__spinrev += (__spinrev < 8) ? 2 : 0;
		
			audio_stop_sound(sndPlrSpindashCharge);
		
			audio_sound_pitch(sndPlrSpindashCharge, 1 + __spinrev / 10);
			audio_play_sound(sndPlrSpindashCharge, 0, false);
		}
	
		__spinrev -= (((__spinrev * 1000) div 125) / 256000);
	};
}
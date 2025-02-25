

function PlayerStateSpindash() : BaseState() constructor {
	__spinrev = 0;
	
	on_start = function(player) {
		audio_sound_pitch(sndPlrSpindashCharge, 1);
		audio_play_sound(sndPlrSpindashCharge, 0, false);
		__spinrev = 0;
		
		with player {
			//allow_jump = false;	
			//allow_movement = false;
			behavior_loop.disable(player_behavior_jump);
			behavior_loop.disable(player_behavior_ground_movement);
			animator.set("spindash");	
		}
	};
	
	on_exit = function(player) { with player {
		behavior_loop.enable(player_behavior_jump);
		behavior_loop.enable(player_behavior_ground_movement);
		//allow_jump = true;
		//allow_movement = true;	
	}};
	
	on_step = function(player) {
		with player {
			if (!is_key_down) {
				plr.gsp = (8 + (floor(other.__spinrev) / 2)) * sign(image_xscale);
		
				audio_stop_sound(sndPlrSpindashCharge);
				audio_play_sound(sndPlrSpindashRelease, 0, false);
			
				state.change_to("roll");
		
				camera.set_lag_timer(15);
			}
		}
	
		if (player.is_key_action_pressed) {
			__spinrev += (__spinrev < 8) ? 2 : 0;
		
			audio_stop_sound(sndPlrSpindashCharge);
		
			audio_sound_pitch(sndPlrSpindashCharge, 1 + __spinrev / 10);
			audio_play_sound(sndPlrSpindashCharge, 0, false);
		
		}
	
		__spinrev -= (((__spinrev * 1000) div 125) / 256000);
		
	};
}
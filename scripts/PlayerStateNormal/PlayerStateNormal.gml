
function BaseState() constructor {};

function PlayerStateNormal() : BaseState() constructor {
	__idle_anim_timer = undefined;
	
	on_start = function() {
		__idle_anim_timer = 0;
	};
	
	on_step = function(player) { with player {
		// Look Up and Down
		if (ground && is_key_up && gsp == 0)
			state.change_to("look_up");
		if (ground && is_key_down && gsp == 0)
			state.change_to("look_down");
			
		// To Roll
		if (ground && is_key_down && abs(gsp) >= 1) {
			state.change_to("roll");
			audio_play_sound(sndPlrRoll, 0, false);
		}
		
		// Skid
		if (ground && abs(gsp) >= 4 && 
			((gsp < 0 && is_key_right) || (gsp > 0 && is_key_left))
		) {
			state.change_to("skid");
			audio_play_sound(sndPlrBraking, 0, false);
		}
		
		// Balancing
		var _check_balanced = (sensor.check_expanded(-6, 0, function() { 
			return (!sensor.is_collision_ground_left_edge() || !sensor.is_collision_ground_right_edge()); 
		}));
		
		if (ground && gsp == 0 && _check_balanced) {
			state.change_to("balancing");
		}
		
		// Push
		if ((gsp >= 0 && is_key_right && sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || 
			(gsp <= 0 && is_key_left  && sensor.check_expanded(1, 0, sensor.is_collision_solid_left))
		) {
			if (ground) state.change_to("push");
		}
	}};
	
	on_animate = function(player) { with player {
		var _abs_gsp = abs(gsp);
		
		other.__idle_anim_timer = (ground && _abs_gsp == 0) ? 
			other.__idle_anim_timer+1 : 0;
			
		if (!ground) {
			animator.set("walking");
			animator.set_image_speed(0.125 + _abs_gsp / 24.0);
			
			return;
		}
		

		if (_abs_gsp == 0) {
			if (other.__idle_anim_timer >= 180 && other.__idle_anim_timer < 816)
				animator.set("bored");
			else if (other.__idle_anim_timer >= 816)
				animator.set("bored_ex");
			else 
				animator.set("idle");
		} else {
			if (_abs_gsp < 6)
				animator.set("walking");
			else if (_abs_gsp < 12)
				animator.set("running");
			else 
				animator.set("dash");
		}
				
				
		if (animator.is(["walking", "running", "dash"])) {
			animator.set_image_speed(0.125 + _abs_gsp / 24.0);
		} 
	}};
}
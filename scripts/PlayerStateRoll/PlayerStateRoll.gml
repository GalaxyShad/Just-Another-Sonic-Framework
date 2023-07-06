

function PlayerStateRoll() : BaseState() constructor {
	on_start = function(player) { with player {
		animator.set("curling");
		
		behavior_loop.disable(player_behavior_slope_decceleration);
		behavior_loop.disable(player_behavior_ground_movement);
		behavior_loop.disable(player_behavior_ground_friction);
	}};
	
	__slopes_decceleration = function(player) { with player {
		var _sina = dsin(sensor.get_angle());
		
		gsp -= _sina * ((sign(gsp) == sign(_sina)) ? 
			physics.slope_factor_rollup : 
			physics.slope_factor_rolldown);
	}};
	
	__apply_friction = function(player) { with player {
		gsp -= min(abs(gsp), physics.friction_speed / 2) * sign(gsp);
	}};
	
	__movement = function(player) { with player {
		if (is_key_left) {
			if (gsp > 0) {
				gsp -= physics.roll_deceleration_speed;  
				if (gsp <= 0) gsp = -0.5;  		
			}
		} else if (is_key_right) {
			if (gsp < 0) {
				gsp += physics.roll_deceleration_speed;  
				if (gsp >= 0) gsp = 0.5;  
			} 
		}
	}};
	
	on_step = function(player) {

		if (player.ground) {
			__slopes_decceleration(player);
			__movement(player);
			__apply_friction(player);
		}

		with player {
			if (abs(gsp) < 0.5)
				state.change_to("normal");
		}
	};
	
	on_animate = function(player) { with player {
		animator.set_image_speed(0.5 + abs(gsp) / 8.0);
	}};
	
	on_exit = function(player) { with player {
		behavior_loop.enable(player_behavior_slope_decceleration);
		behavior_loop.enable(player_behavior_ground_movement);
		behavior_loop.enable(player_behavior_ground_friction);
	}};
}
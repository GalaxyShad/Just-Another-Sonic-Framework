

function PlayerStateRoll() : BaseState() constructor {
	on_start = function(player) { with player {
		animator.set("curling");
		
		behavior_loop.disable(player_behavior_slope_decceleration);
		behavior_loop.disable(player_behavior_ground_movement);
		behavior_loop.disable(player_behavior_ground_friction);
	}};
	
	__slopes_decceleration = function(player) { with player {
		var _sina = collision_detector.get_angle_data().sin;
		
		plr.gsp -= _sina * ((sign(plr.gsp) == sign(_sina)) ? 
			physics.slope_factor_rollup : 
			physics.slope_factor_rolldown);
	}};
	
	__apply_friction = function(player) { with player {
		plr.gsp -= min(abs(plr.gsp), physics.friction_speed / 2) * sign(plr.gsp);
	}};
	
	__movement = function(player) { with player {
		if (is_key_left) {
			if (plr.gsp > 0) {
				plr.gsp -= physics.roll_deceleration_speed;  
				if (plr.gsp <= 0) gsp = -0.5;  		
			}
		} else if (is_key_right) {
			if (plr.gsp < 0) {
				plr.gsp += physics.roll_deceleration_speed;  
				if (plr.gsp >= 0) plr.gsp = 0.5;  
			} 
		}
	}};
	
	on_step = function(player) {

		if (player.plr.ground) {
			__slopes_decceleration(player);
			__movement(player);
			__apply_friction(player);
		}

		with player {
			if (abs(plr.gsp) < 0.5)
				state.change_to("normal");
		}
	};
	
	on_animate = function(player) { with player {
		animator.set_image_speed(0.5 + abs(plr.gsp) / 8.0);
	}};
	
	on_exit = function(player) { with player {
		behavior_loop.enable(player_behavior_slope_decceleration);
		behavior_loop.enable(player_behavior_ground_movement);
		behavior_loop.enable(player_behavior_ground_friction);
	}};
}
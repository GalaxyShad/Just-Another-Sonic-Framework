

function PlayerStateRoll() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.animator.set("curling");
		
		plr.inst.behavior_loop.disable(player_behavior_slope_decceleration);
		plr.inst.behavior_loop.disable(player_behavior_ground_movement);
		plr.inst.behavior_loop.disable(player_behavior_ground_friction);
	};
	
	/// @param {Struct.Player} plr
	__slopes_decceleration = function(plr) { 
		var _sina = plr.collider.get_angle_data().sin;
		
		plr.gsp -= _sina * ((sign(plr.gsp) == sign(_sina)) ? 
			plr.physics.slope_factor_rollup : 
			plr.physics.slope_factor_rolldown);
	};
	
	/// @param {Struct.Player} plr
	__apply_friction = function(plr) { 
		plr.gsp -= min(abs(plr.gsp), plr.physics.friction_speed / 2) * sign(plr.gsp);
	};
	
	/// @param {Struct.Player} plr
	__movement = function(plr) { 
		if (plr.input_x() < 0) {
			if (plr.gsp > 0) {
				plr.gsp -= plr.physics.roll_deceleration_speed;  
				if (plr.gsp <= 0) gsp = -0.5;  		
			}
		} else if (plr.input_x() > 0) {
			if (plr.gsp < 0) {
				plr.gsp += plr.physics.roll_deceleration_speed;  
				if (plr.gsp >= 0) plr.gsp = 0.5;  
			} 
		}
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (plr.ground) {
			__slopes_decceleration(plr);
			__movement(plr);
			__apply_friction(plr);
		}

		if (abs(plr.gsp) < 0.5)
			plr.state_machine.change_to("normal");
	};
	
	/// @param {Struct.Player} plr
	on_animate = function(plr) { 
		plr.animator.set_image_speed(0.5 + abs(plr.gsp) / 8.0);
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.inst.behavior_loop.enable(player_behavior_slope_decceleration);
		plr.inst.behavior_loop.enable(player_behavior_ground_movement);
		plr.inst.behavior_loop.enable(player_behavior_ground_friction);
	};
}
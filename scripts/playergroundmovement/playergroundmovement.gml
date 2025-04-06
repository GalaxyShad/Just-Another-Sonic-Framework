
/// @param {Struct.Player} plr
function player_behavior_ground_movement(plr) {
	if (!plr.ground) return;
	
	if (plr.inst.timer_control_lock.is_ticking())
		return;
	
	if (plr.input_x() < 0) {
		if (plr.gsp > 0) {
			plr.gsp -= plr.physics.deceleration_speed;  
			
			if (plr.gsp <= 0) 
				plr.gsp = -0.5;  		
		} else if (plr.gsp > -plr.physics.top_speed) {		
			plr.gsp -= plr.physics.acceleration_speed;
			
			if (plr.gsp < -plr.physics.top_speed) 
				plr.gsp = -plr.physics.top_speed;  		
		} 
	} else if (plr.input_x() > 0) {
		if (plr.gsp < 0) {
			plr.gsp += plr.physics.deceleration_speed;  
			
			if (plr.gsp >= 0) 
				plr.gsp = 0.5;  
		} else if (plr.gsp < plr.physics.top_speed) {
			plr.gsp += plr.physics.acceleration_speed;
			
			if (plr.gsp > plr.physics.top_speed) 
				plr.gsp = plr.physics.top_speed;  
		}
	}
}

/// @param {Struct.Player} plr
function player_behavior_slope_decceleration(plr) {
	return;

	if (!plr.ground) return;

	var _slp_dec_value = plr.physics.slope_factor * plr.collider.get_angle_data().sin;
	
	if (abs(_slp_dec_value) >= 0.05078125)
		plr.gsp -= _slp_dec_value;
}

/// @param {Struct.Player} plr
function player_behavior_ground_friction(plr) {
	if (!plr.ground) return;
	
	if (plr.input_x() < 0 || plr.input_x() > 0)
		return;
			
	plr.gsp -= min(abs(plr.gsp), plr.physics.friction_speed) * sign(plr.gsp);
}

/// @param {Struct.Player} plr
function player_behavior_fall_off_slopes(plr) {
	return;

	// Sonic 3 method
	#macro FALL_OFF_SPEED_VALUE 2.5
	
	if (!plr.inst.timer_control_lock.is_ticking() 
		&& abs(plr.gsp) < FALL_OFF_SPEED_VALUE 
		&& plr.collider.is_angle_in_range(35, 326)
	) { 
		plr.inst.timer_control_lock.reset_and_start();
			
		if (plr.collider.is_angle_in_range(69, 293)) {
			plr.ground = false;
		} else {
			plr.gsp += (plr.collider.get_angle_data().degrees < 180) ? -0.5 : +0.5;	
		}
	} else {
		plr.inst.timer_control_lock.tick();		
	}
}

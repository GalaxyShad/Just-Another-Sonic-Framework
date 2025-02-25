

function player_behavior_ground_movement() {
	if (!plr.ground) return;
	
	if (timer_control_lock.is_ticking())
		return;
	
	if (is_key_left) {
		if (plr.gsp > 0) {
			plr.gsp -= physics.deceleration_speed;  
			
			if (plr.gsp <= 0) 
				plr.gsp = -0.5;  		
		} else if (plr.gsp > -physics.top_speed) {		
			plr.gsp -= physics.acceleration_speed;
			
			if (plr.gsp < -physics.top_speed) 
				plr.gsp = -physics.top_speed;  		
		} 
	} else if (is_key_right) {
		if (plr.gsp < 0) {
			plr.gsp += physics.deceleration_speed;  
			
			if (plr.gsp >= 0) 
				plr.gsp = 0.5;  
		} else if (plr.gsp < physics.top_speed) {
			plr.gsp += physics.acceleration_speed;
			
			if (plr.gsp > physics.top_speed) 
				plr.gsp = physics.top_speed;  
		}
	}
}

function player_behavior_slope_decceleration() {
	if (!plr.ground) return;
	
	var _slp_dec_value = physics.slope_factor * collision_detector.get_angle_data().sin;
	
	if (abs(_slp_dec_value) >= 0.05078125)
		plr.gsp -= _slp_dec_value;
}

function player_behavior_ground_friction() {
	if (!plr.ground) return;
	
	if (is_key_left || is_key_right)
		return;
			
	plr.gsp -= min(abs(plr.gsp), physics.friction_speed) * sign(plr.gsp);
}

function player_behavior_fall_off_slopes() {
	// Sonic 3 method
	#macro FALL_OFF_SPEED_VALUE 2.5
	
	if (!timer_control_lock.is_ticking() 
		&& abs(plr.gsp) < FALL_OFF_SPEED_VALUE 
		&& collision_detector.is_angle_in_range(35, 326)
	) { 
		timer_control_lock.reset_and_start();
			
		if (collision_detector.is_angle_in_range(69, 293)) {
			plr.ground = false;
		} else {
			plr.gsp += (collision_detector.get_angle_data().degrees < 180) ? -0.5 : +0.5;	
		}
	} else {
		timer_control_lock.tick();		
	}
}

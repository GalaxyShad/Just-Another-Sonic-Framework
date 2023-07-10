

function player_behavior_ground_movement() {
	if (!ground) return;
	
	if (timer_control_lock.is_ticking())
		return;
	
	if (is_key_left) {
		if (gsp > 0) {
			gsp -= physics.deceleration_speed;  
			
			if (gsp <= 0) 
				gsp = -0.5;  		
		} else if (gsp > -physics.top_speed) {		
			gsp -= physics.acceleration_speed;
			
			if (gsp < -physics.top_speed) 
				gsp = -physics.top_speed;  		
		} 
	} else if (is_key_right) {
		if (gsp < 0) {
			gsp += physics.deceleration_speed;  
			
			if (gsp >= 0) 
				gsp = 0.5;  
		} else if (gsp < physics.top_speed) {
			gsp += physics.acceleration_speed;
			
			if (gsp > physics.top_speed) 
				gsp = physics.top_speed;  
		}
	}
}

function player_behavior_slope_decceleration() {
	if (!ground) return;
	
	var _slp_dec_value = physics.slope_factor * sensor.get_angle_sin();
	
	if (abs(_slp_dec_value) >= 0.05078125)
		gsp -= _slp_dec_value;
}

function player_behavior_ground_friction() {
	if (!ground) return;
	
	if (is_key_left || is_key_right)
		return;
			
	gsp -= min(abs(gsp), physics.friction_speed) * sign(gsp);
}

function player_behavior_fall_off_slopes() {
	// Sonic 3 method
	#macro FALL_OFF_SPEED_VALUE 2.5
	
	if (!timer_control_lock.is_ticking() && abs(gsp) < FALL_OFF_SPEED_VALUE && 
		sensor.angle_in_range(35, 326)
	) { 
		timer_control_lock.reset_and_start();
			
		if (sensor.angle_in_range(69, 293)) {
			ground = false;
		} else {
			gsp += (sensor.get_angle() < 180) ? -0.5 : +0.5;	
		}
	} else {
		timer_control_lock.tick();		
	}
}

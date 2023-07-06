

function player_behavior_ground_movement() {
	if (!ground) return;
	
	if (is_key_left) {
		if (gsp > 0) {
			gsp -= physics.deceleration_speed;  
			if (gsp <= 0) gsp = -0.5;  		
		} else if (gsp > -physics.top_speed) {		
			gsp -= physics.acceleration_speed;
			if (gsp < -physics.top_speed) gsp = -physics.top_speed;  		
		} 
	} else if (is_key_right) {
		if (gsp < 0) {
			gsp += physics.deceleration_speed;  
			if (gsp >= 0) gsp = 0.5;  
		} else if (gsp < physics.top_speed) {
			gsp += physics.acceleration_speed;
			if (gsp > physics.top_speed) gsp = physics.top_speed;  
		}
	}
}

function player_behavior_slope_deacceleration() {
	if (!ground) return;
	
	var _slp_dec_value = physics.slope_factor * dsin(sensor.get_angle());
	
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
	
	if (timer_control_lock.is_ticking()) {
		timer_control_lock.tick();
		return;
	}
	
	if ((abs(gsp) < FALL_OFF_SPEED_VALUE) && 
		(sensor.get_angle() >= 35) && (sensor.get_angle() <= 326)
	) { 
		timer_control_lock.reset_and_start();
			
		if (sensor.get_angle() >= 69 && sensor.get_angle() <= 293) {
			ground = false;
		} else {
			gsp += (sensor.get_angle() < 180) ? -0.5 : +0.5;	
		}
	}
}

function __depr_player_ground_movement() {
	if (!ground) return;
		
	// Deacceleration on slopes
	var _sina = dsin(sensor.get_angle());
	
	if (state.current() == "roll") {
		gsp -= _sina * ((sign(gsp) == sign(_sina)) ? 
			physics.slope_factor_rollup : 
			physics.slope_factor_rolldown);
	} else if (abs(physics.slope_factor * _sina) >= 0.05078125)
		gsp -= physics.slope_factor * _sina;
	

	// Movement
	if (allow_movement && !timer_control_lock.is_ticking()) {
		if(state.current() == "roll") {
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
		} else {
			if (is_key_left) {
				if (gsp > 0) {
					gsp -= physics.deceleration_speed;  
					if (gsp <= 0) gsp = -0.5;  		
				} else if (gsp > -physics.top_speed) {		
					gsp -= physics.acceleration_speed;
					if (gsp < -physics.top_speed) gsp = -physics.top_speed;  		
				} 
			} else if (is_key_right) {
				if (gsp < 0) {
					gsp += physics.deceleration_speed;  
					if (gsp >= 0) gsp = 0.5;  
				} else if (gsp < physics.top_speed) {
					gsp += physics.acceleration_speed;
					if (gsp > physics.top_speed) gsp = physics.top_speed;  
				}
			}
		}
	}
	
	if (state.current() == "roll")
		gsp -= min(abs(gsp), physics.friction_speed / 2) * sign(gsp);
	
	
	
}
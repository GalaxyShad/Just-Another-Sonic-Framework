// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerGroundMovement() {
	if (!ground)
		return;
		
	// Deacceleration on slopes
	var _sina = dsin(sensor.get_angle());
	
	if (state.current() == "roll") {
		gsp -= _sina * ((sign(gsp) == sign(_sina)) ? 
			physics.slope_factor_rollup : 
			physics.slope_factor_rolldown);
	} else if (abs(physics.slope_factor * _sina) >= 0.05078125)
		gsp -= physics.slope_factor * _sina;
	

	// Movement
	if (control_lock_timer == 0 && allow_movement) {
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
	
	// Friction
	if (!is_key_left && !is_key_right && state.current() != "roll" && state.current() != "land") {
		gsp -= min(abs(gsp), physics.friction_speed) * sign(gsp);
	}
	
	if (state.current() == "roll")
		gsp -= min(abs(gsp), physics.friction_speed / 2) * sign(gsp);
	
	if (state.current() == "land")
		gsp -= min(abs(gsp), physics.friction_speed) * sign(gsp);

	// Fall off slopes
	// Sonic 3 method
	if (control_lock_timer == 0) {
	    if (abs(gsp) < 2.5 && sensor.get_angle() >= 35 && sensor.get_angle() <= 326) { 
			control_lock_timer = 30;
			
			if (sensor.get_angle() >= 69 && sensor.get_angle() <= 293) {
				ground = false;
			} else {
				gsp += (sensor.get_angle() < 180) ? -0.5 : +0.5;	
			}
	        
	    }
	} else {
	    control_lock_timer--; 
	}
	
}
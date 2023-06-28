// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerGroundMovement() {
	if (!ground) return;
		
	// Deacceleration on 
	var sina = dsin(sensor.get_angle());
	
	if (state.current() == "roll") {
		if (sign(gsp) == sign(sina)) gsp -= slp_rollup * sina;
		else gsp -= slp_rolldown * sina;
	} else if (gsp != 0) gsp -= slp * sina;
	

	// Movement
	if (control_lock_timer == 0 && allow_movement) {
		if(state.current() == "roll") {
			if (is_key_left) {
				if (gsp > 0) {
					gsp -= 0.125;  
					if (gsp <= 0) gsp = -0.5;  		
				}
			} else if (is_key_right) {
				if (gsp < 0) {
					gsp += 0.125;  
					if (gsp >= 0) gsp = 0.5;  
				} 
			}
		}
		else {
			if (is_key_left) {
				if (gsp > 0) {
					gsp -= dec;  
					if (gsp <= 0) gsp = -0.5;  		
				} else if (gsp > -top) {		
					gsp -= acc;
					if (gsp < -top) gsp = -top;  		
				} 
			} else if (is_key_right) {
				if (gsp < 0) {
					gsp += dec;  
					if (gsp >= 0) gsp = 0.5;  
				} else if (gsp < top) {
					gsp += acc;
					if (gsp > top) gsp = top;  
				}
			}
		}
	}
	
	// Friction
	if (!is_key_left && !is_key_right && state.current() != "roll" && state.current() != "land") gsp -= min(abs(gsp), frc) * sign(gsp);
	if (state.current() == "roll") gsp -= min(abs(gsp), frc / 2) * sign(gsp);
	if (state.current() == "land") gsp -= min(abs(gsp), frc) * sign(gsp);

	// Fall off slopes
	if (control_lock_timer == 0) {
	    if (abs(gsp) < 2.5 && sensor.get_angle() >= 46 && sensor.get_angle() <= 315) { 
			ground = false;
			gsp = 0; 
	        control_lock_timer = 30;
	    }
	} else control_lock_timer--;
	
}
// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerAirMovement(){
	if (ground)
		return;
		
	if (state.current() == "hurt") {
		ysp += 0.1875;
		return;	
	}
	
	// Gravity
	if(state.current() != "climbe"){
		if (state.current() == "glide" || state.current() == "glideRotation") {
			if(ysp<0.5) ysp += glide_gravity_force;
			if(ysp>0.5) ysp -= glide_gravity_force;
		};
		else ysp += physics.gravity_force;
	}
	else if (ysp > 16) ysp = 16;
	//else if (state.current() == "climbe") ysp = 0;
	//show_debug_message("Air movement");
	//if (state.current() != "glide" && state.current() != "glideRotation") ysp += glide_gravity_force; else ysp = 0;
	
	// Movement
	if (allow_movement) {
		if (is_key_left && xsp > -physics.top_speed) 
			xsp -= physics.air_acceleration_speed;
		else if (is_key_right && xsp < physics.top_speed) 
			xsp += physics.air_acceleration_speed;
	}	
		
	// Air Drag
	if (!ground && ysp < 0 && ysp > -4) {
	    xsp -= (((xsp * 1000) div 125) / 256000);
	}
}
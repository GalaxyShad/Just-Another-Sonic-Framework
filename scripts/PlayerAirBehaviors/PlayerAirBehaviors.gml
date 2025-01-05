
function player_behavior_apply_gravity() {
	if (ground) return;
		
	ysp += physics.gravity_force;
	
	if (ysp > 16) 
		ysp = 16;
}

function player_behavior_air_movement() {
	if (ground) return;
	
	if (!allow_movement)
		return;

	if (is_key_left && xsp > -physics.top_speed) 
		xsp -= physics.air_acceleration_speed;
	else if (is_key_right && xsp < physics.top_speed) 
		xsp += physics.air_acceleration_speed;
}

function player_behavior_air_drag() {
	if (ground) return;
	
	if (ysp < 0 && ysp > -4) {
	    xsp -= (((xsp * 1_000) div 125) / 256_000);
	}	
}
